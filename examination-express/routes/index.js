const jwt = require("jsonwebtoken");
const db = require("../db/connector");
const express = require("express");
const axios = require("axios");
const router = express.Router();
const { underlineToCamel } = require("../util");
const SECRET_KEY = "ajskdlfksj2jrk";

router.get("/", function (req, res, next) {
  res.render("index", { title: "Express" });
});

router.post("/login", async (req, res) => {
  const { username, password } = req.body;
  let [rows] = await db.query(
    `SELECT id, role_id FROM admin WHERE name = ? AND password = ?`,
    [username, password]
  );
  if (rows.length === 0) {
    res.send({ login: false, message: "用户名或密码错误！" });
  } else {
    const { id, roleId } = underlineToCamel(rows[0]);
    const time = Date.now();
    const token = jwt.sign({ id, roleId, time }, SECRET_KEY);
    const [permissionRows] = await db.query(
        `SELECT permission.path 
        FROM role_permission
        JOIN permission ON role_permission.permission_id = permission.id
        JOIN admin ON admin.role_id = role_permission.role_id
        WHERE admin.id = ?`,
      [id]
    );
    const path = permissionRows.map(row => row.path);
    res.send({
      login: true,
      message: "登陆成功！",
      token,
      roleId,
      id,
      path: path,
    });
  }
});
router.post("/getSms", async (req, res) => {
  const { phone } = req.body;
  let code = "";
  for (let i = 0; i < 6; i++) {
    code += parseInt(Math.random() * 10);
  }
  let a = axios.create({
    headers: {
      Authorization: "APPCODE 9633357b72b04b27b62c549584a63350",
      "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
    },
  });
  a.post("http://dfsns.market.alicloudapi.com/data/send_sms", {
    content: `code:${code}`,
    phone_number: phone,
    template_id: "TPL_0000",
  }).catch(err => console.error(err)); // Make sure to handle errors

  // Adjusting for MySQL
  const [result] = await db.query("SELECT * FROM user WHERE phone = ?", [phone]);
  if (result.length === 0) {
    await db.query(
      `INSERT INTO user (name, identification_number, sex, birthday, phone, create_time) VALUES ('', '', '', NULL, ?, CURRENT_TIMESTAMP)`,
      [phone]
    );
  }
  await db.query(`UPDATE user SET sms = ? WHERE phone = ?`, [code, phone]);
  res.send({ message: "SMS sent successfully." });
});

router.post("/userLogin", async (req, res) => {
  const { phone } = req.body;
  const [rows] = await db.query(`SELECT * FROM user WHERE phone = ?`, [phone]);
  console.log("!!!", rows);
  if (rows.length === 1) {
    const id = rows[0].id;
    const token = jwt.sign({ id, time: Date.now() }, SECRET_KEY);
    res.send({ message: "登陆成功", success: true, token, userInfo: rows[0] });
  }
  else {
    res.send({ message: "验证码错误", success: false });
  }
});
module.exports = router;
