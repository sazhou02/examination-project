const express = require("express");
const router = express.Router();
const db = require("../db/connector");
const { underlineToCamel } = require("../util");
const { Admin } = require("../db/baseApi");

router.post("/newAdmin", async function (req, res) {
  const { name, phone, newRoleId, password } = req.body;
  await Admin.insertOne({ name, phone, roleId: newRoleId, password });
  res.send();
});

router.post("/page", async function (req, res) {
  const { page, size } = req.body;
  const sql = `SELECT *, admin.name AS name, role.name AS role_name FROM admin JOIN role ON admin.role_id = role.id LIMIT ?, ?`;
  const sqlTotal = `SELECT COUNT(*) AS total FROM admin`;
  const offset = (page - 1) * size; // 计算偏移量
  const [result] = await db.query(sql, [offset, size]); // 传递偏移量和条数
  const [totalRes] = await db.query(sqlTotal); // 查询总数
  res.send({
    rows: underlineToCamel(result), // 将下划线命名转为驼峰命名
    total: parseInt(totalRes[0].total, 10), // 将字符串转为整数
  });
});



module.exports = router;
