const express = require('express');
const router = express.Router();
const db = require('../db/connector');
const { ExaminatinOrder } = require('../db/baseApi');
const { Assignment } = require('../db/baseApi');

//按名或电话搜索用户订单信息
router.post("/list", async (req, res) => {
    const {dname} = req.body;
    const sql= `SELECT 
                    a.id AS id,
                    a.examinee_id AS examinee_id,
                    b.name AS name,
                    b.phone AS phone,
                    c.name AS package_name,
                    d.name AS center_name,
                    a.examine_date AS examine_date,
                    a.status AS status,
                    a.type AS type
                FROM 
                    examination_order a
                    JOIN examinee b ON a.examinee_id = b.id
                    JOIN package c ON a.package_id = c.id
                    JOIN examination_center d ON a.center_id = d.id
                    LEFT JOIN group_information e ON a.group_information_id = e.id
                WHERE
                    CONCAT(b.name, b.phone) LIKE ?
                ORDER BY
                    a.examine_date DESC`;
    let [result] = await db.query(sql, [`%${dname}%`]);
    res.send(result);
});

// 按订单号查询子项目
router.post('/assignment', async (req, res) => {
    const {order_id} = req.body;
    const sql=`SELECT DISTINCT
                    b.id
                FROM
                    assignment a
                    JOIN category b ON b.id = a.category_id
                WHERE
                    a.order_id = ?`;
    let [result] = await db.query(sql, [order_id]);
    res.send(result);
});

//按订单号添加子项目名
router.post('/addAssignment', async (req, res) => {
    const { order_id, name } = req.body;
    const sql = `SELECT id FROM category WHERE name = ?`;
    let categoryResult = await db.query(sql, [name]);
    let category_id = categoryResult[0][0].id;
    await Assignment.insertOne({ id: 4, category_id: category_id, order_id: order_id, status: 0, is_extra: true });
    res.send();
});

//改变体检订单状态
router.post('/changeStatus', async (req, res) => {
    const { order_id, order_status } = req.body;
    const sql = `UPDATE examination_order SET status = ? WHERE id = ?`;
    await db.query(sql, [order_status, order_id]);
    res.send();
});

//改变体检订单吃饭情况
router.post('/changeBreakfast', async (req, res) => {
    const { examinee_id, breakfast } = req.body;
    const sql = `SELECT id, breakfast FROM examination_order WHERE examinee_id = ? AND status IN (0, 1, 2, 3, 6)`;
    const result = await db.query(sql, [examinee_id]);
    const id = result[0][0].id; // 根据你使用的MySQL客户端库，可能需要调整这里的索引
    const sql2 = `UPDATE examination_order SET breakfast = ?, status = 3 WHERE id = ?`;
    await db.query(sql2, [breakfast, id]); // 注意这里应当使用查询到的订单ID，而非 examinee_id
    res.send();
});

router.post('/changeStatus2', async (req, res) => {
    const { examinee_id, status } = req.body;
    const sql = `SELECT id FROM examination_order WHERE examinee_id = ? AND status IN (0, 1, 2, 3, 6)`;
    const result = await db.query(sql, [examinee_id]);
    const id = result[0][0].id; // 根据你使用的MySQL客户端库，可能需要调整这里的索引
    const sql2 = `UPDATE examination_order SET status = ? WHERE id = ?`;
    await db.query(sql2, [status, id]); // 注意这里应当使用查询到的订单ID，而非 examinee_id
    res.send();
});


//按订单号添加套餐内子检查项目
router.post('/newAssignment', async (req, res) => {
    const { order_id } = req.body;
    const sql = `SELECT DISTINCT
                    b.category_id 
                 FROM 
                    examination_order a
                    JOIN package_category b ON a.package_id = b.package_id
                 WHERE 
                    a.id = ?`;
    let [que] = await db.query(sql, [order_id]);
    let values = que.map(item => [item.category_id, order_id, 0, false, new Date()]);
    if (values.length > 0) {
        let sql2 = `INSERT INTO assignment (category_id, order_id, status, is_extra, create_time) VALUES ?`;
        await db.query(sql2, [values]);
    }
    res.send({ msg: 'ok' });
});

router.post("/examinee_info", async (req, res) => {
    const { user_id } = req.body;
    const sql = `SELECT * FROM examinee WHERE user_id = ?`;
    let [result] = await db.query(sql, [user_id]);
    res.send(result);
});

router.post("/examinee_status", async (req, res) => {
    const { examinee_id } = req.body;
    const sql = `SELECT * FROM examination_order WHERE examinee_id = ? AND status IN (0, 1, 2, 3, 6)`;
    let [tmp] = await db.query(sql, [examinee_id]);
    if (tmp.length > 0) {
        const result = tmp[0];
        let status = result.status;
        let time = ((new Date().getTime()) - new Date(result.examine_date).getTime()) / 86400000;
        let date = time <= 1 && time >= 0.25;
        if (status == 1) {
            const sql2 = `SELECT * FROM queue WHERE order_id = ?`;
            let [result2] = await db.query(sql2, [result.id]);
            if (result2.length > 0) {
                let department_id = result2[0].department_id;
                let [departmentResult] = await db.query(`SELECT name FROM department WHERE id = ?`, [department_id]);
                let department_name = departmentResult[0].name;
                let serial_number = result2[0].serial_number;
                let dtime = result2[0].clock_time;
                let breakfast = result.breakfast;
                res.send({ order_id: result.id, breakfast: breakfast, status: status, date: date, department_name: department_name, department_id: department_id, serial_number: serial_number, time: dtime });
            }
        } else {
            res.send({ status: status, date: date, order_id: result.id });
        }
    } else {
        res.send({ status: 4, date: true });
    }
});


module.exports = router;