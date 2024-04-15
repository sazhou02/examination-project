const express = require("express");
const router = express.Router();
const db = require("../db/connector");
const { Permission } = require("../db/baseApi");

router.get("/list", async function (req, res) {
  let sql = `SELECT p.* FROM admin a
            INNER JOIN role_permission rp ON a.role_id = rp.role_id
            INNER JOIN permission p ON rp.permission_id = p.id
            WHERE a.id = ?
            ORDER BY p.index, p.level`;
  const [rows] = await db.query(sql, [req.body.id]);
  rows.forEach((cur) => {
    let parent = rows.find((row) => row.id === cur.parent_id);
    if (parent) {
      if (!parent.children) {
        parent.children = [cur];
      } else {
        parent.children.push(cur);
      }
    }
  });
  res.send(rows.find((row) => row.level === 0));
});

router.post("/update", async function (req, res) {
  Permission.updateMany(req.body);
  res.send({ message: "修改成功" });
});

router.get("/listByRole/:roleId", async function (req, res) {
  console.log(req.params.roleId);
  const [rows] = await db.query(
    `SELECT * FROM permission
                                INNER JOIN role_permission ON permission.id = role_permission.permission_id
                                WHERE role_permission.role_id = ?`,
    [req.params.roleId]
  );
  res.send(rows);
});
module.exports = router;
