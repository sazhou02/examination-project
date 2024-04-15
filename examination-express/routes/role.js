const express = require('express');
const router = express.Router();
const db = require('../db/connector');
const { Role, RolePermission } = require('../db/baseApi');

router.get("/list", async (req, res) => {
  const result = await Role.list();
  res.send(result[0]);
});

router.post("/delete", async (req, res) => {
  const { deletedRoleId } = req.body;
  await db.query("DELETE FROM role_permission WHERE role_id = ?", [deletedRoleId]);
  await db.query("DELETE FROM role WHERE id = ?", [deletedRoleId]);
  res.send();
});

router.post("/create", async (req, res) => {
  const { name, description, selectedIds } = req.body;
  // 插入角色并获取新插入角色的ID
  const [roleResult] = await db.query("INSERT INTO role (name, description) VALUES (?, ?)", [name, description]);
  const maxId = roleResult.insertId;
  // 插入角色权限关系
  for (const pmsId of selectedIds) {
    await db.query("INSERT INTO role_permission (permission_id, role_id) VALUES (?, ?)", [pmsId, maxId]);
  }
  res.send();
});

router.put("/update", async (req, res) => {
  const { name, description, updateId } = req.body;
  const sql = "UPDATE role SET name = ?, description = ? WHERE id = ?";
  const result = await db.query(sql, [name, description, updateId]);
  res.send();
});
module.exports = router;