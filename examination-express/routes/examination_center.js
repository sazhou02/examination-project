const express = require("express");
const router = express.Router();
const db = require("../db/connector");
const { ExaminationCenter, ExaminationOrder, GroupInformation } = require("../db/baseApi");
const { underlineToCamel } = require("../util");
const xlsx = require('node-xlsx');
const multer = require('multer');
const fs = require('fs');

router.post("/list", async (req, res) => {
  const { curPage, pageSize, searchValue } = req.body;
  const sql = `SELECT a.id AS id,
              a.name AS n, district_id, address, nearby, telephone, announcement, response_time, consult_num, morning_limit, afternoon_limit, price, is_hot, img_src, b.name
              FROM examination_center a
              JOIN district b ON a.district_id = b.id
              where a.name LIKE ?
              LIMIT ?, ?`;
  let [result] = await db.query(sql, [`%${searchValue || ""}%`, (curPage - 1) * pageSize, pageSize]);
  result.map(item => {
    item.announcement = item.announcement.split(",");
    return item;
  })
  res.send(underlineToCamel(result));
});

router.post("/del", async (req, res) => {
  const { name } = req.body;
  const sql = `DELETE FROM examination_center WHERE name = ?`;
  await db.query(sql, [name]);
  res.send({ message: "删除成功" });
});

router.post("/count", async (req, res) => {
  const sql = `SELECT COUNT(*) AS count FROM examination_center`;
  let [result] = await db.query(sql);
  res.send({ total: result[0].count });
});

router.get("/list", async (req, res) => {
  const { search = "" } = req.query;
  let curPage = 1;
  const sql = `SELECT a.id AS id,
              a.name AS name, district_id, address, nearby, telephone, announcement, latitude, longitude, morning_limit, afternoon_limit, b.name AS district
              FROM examination_center a
              JOIN district b ON a.district_id = b.id
              WHERE a.name LIKE ?
              LIMIT ?, ?`;
  let [result] = await db.query(sql, [`%${search}%`, (curPage - 1) * 5, 5]);
  res.send(underlineToCamel(result));
});

router.get("/detail", async (req, res) => {
  const { id } = req.query;
  const sql = `SELECT a.id AS id,
              a.name AS name, district_id, address, nearby, telephone, announcement, latitude, longitude, morning_limit, afternoon_limit, b.name AS district
              FROM examination_center a
              JOIN district b ON a.district_id = b.id
              WHERE a.id = ?`;
  let [result] = await db.query(sql, [id]);
  if (result.length > 0) {
    res.send(underlineToCamel(result[0]));
  } else {
    res.status(404).send({ message: "未找到详情" });
  }
});

router.post("/listByDistance", async (req, res) => {
  const { location, keyword = "" } = req.body;
  const { latitude, longitude } = location;
  const sql = `SELECT examination_center.*, examination_center.name AS name, district.name AS district,
   ROUND(
		6378.138 * 2 * ASIN(
			SQRT(
				POW(
					SIN((
							? * PI()/ 180 - latitude * PI()/ 180 
							)/ 2 
					),
					2 
				) + COS( ? * PI()/ 180 ) * COS( latitude * PI()/ 180 ) * POW(
					SIN((
							? * PI()/ 180 - longitude * PI()/ 180 
							)/ 2 
					),
					2 
				)
			)
		) * 1000 
	) AS distance 
   FROM examination_center
   JOIN district ON district.id = examination_center.district_id
   WHERE examination_center.name LIKE ? 
   ORDER BY distance`;
  const params = [latitude, latitude, longitude, `%${keyword}%`];
  const [result] = await db.query(sql, params);
  res.send(underlineToCamel(result));
});

router.get("/singleCenter", async(req, res) => {
  const { id } = req.query;
  const sql = `SELECT * FROM examination_center WHERE operator_id = ?`;
  const [result] = await db.query(sql, [id]);
  res.send(underlineToCamel(result));
});

router.post("/addCenter", async(req, res) => {
  const { id } = req.body;
  req.body.operator_id = id;
  await ExaminationCenter.insertOne(req.body);
  res.send();
});

router.post("/updateCenter", async(req, res) => {
  const { centerId } = req.body;
  await ExaminationCenter.updateOne(req.body, centerId);
  res.send();
});

const upload_middleware = multer({ dest: './public' });
router.post("/groupImport", upload_middleware.single("file"), async(req, res) => {
  const data = xlsx.parse(req.file.path)[0].data;
  console.log(data);
  const list = data.slice(6);
  fs.unlink(req.file.path, () => {}); // 删除上传的文件
  const packageName = data[1][1];
  
  const [packageResult] = await db.query("SELECT id FROM package WHERE name = ?", [packageName]);
  const packageId = packageResult[0].id;
  
  const [groupInsertResult] = await GroupInformation.insertOne({
    companyName: data[0][1],
    createTime: new Date(),
    startTime: data[2][1],
    endTime: data[3][1],
    number: list.length,
    packageId
  });
  
  const groupOrderId = groupInsertResult.insertId; 
  await ExaminationOrder.insertMany(list.map(p => {
    return {
      packageId: packageId,
      status: 0,
      type: 0,
      groupInformationId: groupOrderId,
      phone: p[1],
      name: p[0]
    };
  }));
  
  res.send();
});
module.exports = router;
