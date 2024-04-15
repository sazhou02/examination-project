const express = require("express");
const router = express.Router();
const db = require("../db/connector");
const { ExaminationResult } = require("../db/baseApi");

//assignment添加医生id、examination_result添加若干记录
router.post("/add", async function (req, res) {
	const { category_id, data, order_id, start_id, doctor_id } = req.body;

	// 查找订单号
	const sql1 = `SELECT id FROM assignment WHERE order_id = ? AND category_id = ?`;
	const [assignmentResult] = await db.query(sql1, [order_id, category_id]);
	const assignment_id = assignmentResult[0].id;

	// 订单状态、医生id更新
	const sql2 = `UPDATE assignment SET doctor_id = ?, status = 1 WHERE id = ?`;
	await db.query(sql2, [doctor_id, assignment_id]);

	// 更新体检状态
	const sql6 = `SELECT status FROM assignment WHERE order_id = ?;`;
	const [assignmentStatus] = await db.query(sql6, [order_id]);
	console.log("@@@@", assignmentStatus);
	const statusBool = assignmentStatus.every(item => item.status === 1);
	if (statusBool) {
		const sql7 = `UPDATE examination_order SET status = 5 WHERE id = ?;`;
		await db.query(sql7, [order_id]);
	}

	// 检查结果表插入数据
	let inserts = [];
	for (let item of data) {
		if (item.value_type == 0) {
			inserts.push([
				item.value,
				null,
				assignment_id,
				start_id + item.item_id,
				new Date(),
			]);
		} else {
			const sql4 = `SELECT id FROM result_text_option WHERE text = ?`;
			let [result] = await db.query(sql4, [item.text]);
			let text_option_id = -1;
			if (result.length > 0) {
				text_option_id = result[0].id;
			} else {
				const sql5 = `INSERT INTO result_text_option (text) VALUES (?)`;
				const [insertResult] = await db.query(sql5, [item.text]);
				text_option_id = insertResult.insertId; // 使用insertId获取新插入记录的ID
			}
			inserts.push([
				null,
				text_option_id,
				assignment_id,
				start_id + item.item_id,
				new Date(),
			]);
		}
	}

	if (inserts.length > 0) {
		const sql = `INSERT INTO examination_result (result_value, text_option_id, assignment_id, item_id, create_time) VALUES ?`;
		db.query(sql, [inserts], (error, results) => {
			if (error) {
				// 错误处理
				console.error("Batch insert error: ", error);
				return;
			}
			// 成功处理，例如打印插入结果
			console.log("Batch insert success: ", results);
		});
	}

	res.send();
});

router.post("/getReport", async (req, res) => {
	const { orderId } = req.body;
	const sql1 = `SELECT id, category_id FROM assignment WHERE order_id = ?;`;
	const [categoryRes] = await db.query(sql1, [orderId]);

	const allReports = [];
	// 分类名
	for (let index = 0; index < categoryRes.length; index++) {
		const element = categoryRes[index];
		const examination = {};

		// 查找分类名
		categoryId = element.category_id;
		const sql2 = `SELECT id, name FROM category WHERE id = ?;`;
		const [categoryNameRes] = await db.query(sql2, [categoryId]);
		const categoryName = categoryNameRes[0].name;
		examination.categoryName = categoryName;

		// 处理分类下每个项目的数据
		const sql3 = `SELECT id AS itemId, value_type AS valueType, normal_option_id AS normalId ,name FROM item WHERE category_id = ?;`;
		const [itemRes] = await db.query(sql3, [categoryId]);
		const processedItemRes = await processItems(itemRes, categoryId, orderId);
		examination.itemRes = processedItemRes;
		allReports.push(examination);
	}
	res.send(allReports);
});

async function processItems(itemRes, categoryId, orderId) {
	// 使用Promise.all来处理所有的异步操作
	const processedItems = await Promise.all(
		itemRes.map(async (item) => {
			if (item.valueType === 0) {
				// 数值
				const sql4 = `SELECT id AS assignmentId FROM assignment WHERE category_id = ? AND order_id = ?;`;
				const [assRes] = await db.query(sql4, [categoryId, orderId]);

				if (!assRes[0]) return { ...item, value: null };

				const assignmentId = assRes[0].assignmentId;
				const itemId = item.itemId;

				const sql5 = `SELECT result_value FROM examination_result WHERE assignment_id = ? AND item_id = ?;`;
				const [resultRes] = await db.query(sql5, [assignmentId, itemId]);

				if (!resultRes[0]) return { ...item, value: null };

				const resultValue = resultRes[0].result_value;
				return { ...item, value: resultValue };
			} else {
				// 文本
				const sql6 = `SELECT text from result_text_option WHERE id = ?;`;
				const [textRes] = await db.query(sql6, [item.normalId]);

				if (!textRes[0]) return { ...item, value: null };

				return { ...item, value: textRes[0].text };
			}
		})
	);

	return processedItems;
}

module.exports = router;
