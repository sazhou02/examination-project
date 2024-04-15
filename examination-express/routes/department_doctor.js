const express = require('express');
const router = express.Router();
const db = require('../db/connector');
const { DepartmentDoctor } = require('../db/baseApi');

router.post("/list", async (req, res) => {
  const { dname } = req.body;

  let sql = `SELECT b.name AS doctor_name, c.name AS department_name, d.is_busy
              FROM department_doctor a
              JOIN admin b ON a.administer_id = b.id
              JOIN department c ON a.department_id = c.id
              JOIN doctor_status d ON d.doctor_id = b.id`;

  // 初始化参数数组
  const params = [];
  // 如果dname不是空字符串，则添加WHERE子句
  if(dname.trim() !== '') {
    sql += ` WHERE c.name = ?`;
    params.push(dname);
  }
  // 添加排序
  sql += ` ORDER BY doctor_name;`;

  // 执行查询，传入参数
  const [result] = await db.query(sql, params);
  res.send(result);
});

module.exports = router;