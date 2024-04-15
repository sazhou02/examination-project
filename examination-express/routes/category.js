const express = require("express");
const router = express.Router();
const db = require("../db/connector");
const { Category } = require("../db/baseApi");

router.get("/list", async (req, res) => {
    const [result] = await Category.list();
    res.send(result);
});

router.post("/item", async (req, res) => {
    const { name } = req.body;
  // 使用 JOIN 明确表连接，并且使用 ? 作为参数化查询的占位符
    const sql = `SELECT
                    b.name
                FROM 
                    category a
                    JOIN item b ON a.id = b.category_id
                WHERE
                    a.name = ?`;
    const [result] = await db.query(sql, [name]);
    res.send(result);
});
module.exports = router;
