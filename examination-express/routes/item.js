const express = require('express');
const router = express.Router();
const db = require('../db/connector');
const { Item } = require('../db/baseApi');

router.post("/list", async function (req, res) {
    const { category_id } = req.body;
    const sql = `SELECT * FROM item WHERE category_id = ? ORDER BY id`;
    const [result] = await db.query(sql, [category_id]);
    res.send(result);
});

module.exports = router;