const express = require('express');
const router = express.Router();
const db = require('../db/connector');
const { User } = require('../db/baseApi');
const { underlineToCamel } = require("../util");

router.get('/:id', async function(req, res) {
  const id = req.params.id;
  const sql = `SELECT * FROM user WHERE id = ${id}`;
  const [result] = await db.query(sql);
  res.send(underlineToCamel(result[0]));
})

router.post('/addUser', async function(req, res) {
  await User.insertOne(req.body);
  res.send();
});

router.post('/addUsers', async function(req, res) {
  await User.insertMany(req.body);
  res.send();
});

router.delete('/delete/:id', async function(req, res) {
  await User.deleteOne(req.params.id);
  res.send();
});

router.post('/batchDelete', async function(req, res) {
  await User.deleteMany(req.body);
  res.send();
});

router.put('/update/:id', async function(req, res) {
  await User.updateOne(req.body, req.params.id);
  res.send();
});

router.post('/page', async function(req, res) {
  const { page, size } = req.body;
  const sql = `SELECT * FROM user LIMIT ?, ?`;
  const sqlTotal = `SELECT COUNT(*) AS total FROM user`;
  const offset = (page - 1) * size;
  const [result] = await db.query(sql, [offset, size]);
  const [totalRes] = await db.query(sqlTotal);
  res.send({
    rows: underlineToCamel(result),
    total: parseInt(totalRes[0].total, 10),
  });
});

router.post('/search', async function(req, res) {
  const { keyword, page, size } = req.body;
  const offset = (page - 1) * size;
  const sql = `SELECT * FROM user WHERE name LIKE ? OR identification_number LIKE ? OR sex LIKE ? OR phone LIKE ? LIMIT ?, ?`;
  const sqlTotal = `SELECT COUNT(*) AS total FROM user WHERE name LIKE ? OR identification_number LIKE ? OR sex LIKE ? OR phone LIKE ?`;
  const likeKeyword = `%${keyword}%`;
  const [result] = await db.query(sql, [likeKeyword, likeKeyword, likeKeyword, likeKeyword, offset, size]);
  const [totalRes] = await db.query(sqlTotal, [likeKeyword, likeKeyword, likeKeyword, likeKeyword]);
  res.send({
    rows: underlineToCamel(result),
    total: parseInt(totalRes[0].total, 10)
  });
});
module.exports = router;
