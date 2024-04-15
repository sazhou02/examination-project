const express = require("express");
const router = express.Router();
const db = require("../db/connector");
const { underlineToCamel } = require("../util");

router.post("/newAdmin", async function (req, res) {
  const { name, phone, newRoleId, password } = req.body;
  await Admin.insertOne({ name, phone, roleId: newRoleId, password });
  res.send();
});

router.post("/page", async function (req, res) {
  const { page, size } = req.body;
  // 在MySQL中，参数化查询使用 ? 作为占位符
  const [result] = await db.query(
    "SELECT *, p.name AS package_name, g.id AS id FROM group_information AS g JOIN package AS p ON g.package_id = p.id LIMIT ?, ?",
    [(page - 1) * size, size]
  );
  const [[{count: sum}]] = await db.query("SELECT COUNT(*) AS count FROM group_information");
  
  res.send({ rows: underlineToCamel(result), sum: parseInt(sum) });
});

router.post("/examineeList", async function (req, res) {
  const { page, size, groupId } = req.body;
  
  const [result] = await db.query(
    "SELECT * FROM examination_order WHERE group_information_id = ? LIMIT ?, ?",
    [groupId, (page - 1) * size, size]
  );
  const [[{ count: sum }]] = await db.query(
    "SELECT COUNT(*) AS count FROM examination_order WHERE group_information_id = ?",
    [groupId]
  );
  res.send({ rows: underlineToCamel(result), sum });
});

router.get("/info", async function (req, res) {
  const { phone } = req.query;
  const [result] = await db.query(
    "SELECT e.*, p.name AS package_name FROM examination_order AS e JOIN group_information AS g ON e.group_information_id = g.id JOIN package AS p ON e.package_id = p.id WHERE e.phone = ?",
    [phone]
  );

  const [[{ count: categoryNum }]] = await db.query(
    "SELECT COUNT(*) AS count FROM category JOIN package ON category.package_id = package.id JOIN examination_order ON package.id = examination_order.package_id WHERE examination_order.phone = ?",
    [phone]
  );

  if (result.length > 0) {
    res.send({ categoryNum, ...underlineToCamel(result[0]) });
  } else {
    res.send({ message: "No data found" });
  }
});

module.exports = router;
