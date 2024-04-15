const express = require('express');
const router = express.Router();
const db = require('../db/connector');
const { Queue } = require('../db/baseApi');

router.post("/examinee_info", async function (req, res) {
    const { department_id } = req.body;
    const sql1 = `SELECT order_id AS oid FROM queue WHERE department_id = ? ORDER BY serial_number`;
    const [res1] = await db.query(sql1, [department_id]);
    if (res1.length == 0) {
        res.send([{ name: "无" }]);
    } else {
        const order_id = res1[0].oid;
        console.log("order_id>>>>", order_id);
        const sql2 = `SELECT examinee.name AS name, examination_order.examinee_id AS examinee_id 
                      FROM examinee, examination_order 
                      WHERE examination_order.id = ? AND examination_order.examinee_id = examinee.id`;
        const [nameResult] = await db.query(sql2, [order_id]);
        const name = nameResult[0].name;
        const examinee_id = nameResult[0].examinee_id;
        const sql3 = `SELECT assignment.category_id,
                assignment.status
                FROM assignment 
                INNER JOIN category ON assignment.category_id = category.id 
                WHERE category.department_id = ? AND assignment.order_id = ?`;
        const [assRes] = await db.query(sql3, [department_id, order_id]);
        console.log("assRes>>>>", assRes);
        res.send([{ name: name, assRes: assRes, order_id: order_id, examinee_id: examinee_id }]);
    }
});

router.post("/delete", async function (req, res) {
    const { order_id, department_id } = req.body;
    const [dtimeResult] = await db.query(`SELECT time FROM queue WHERE order_id = ?`, [order_id]);
    var dtime = dtimeResult[0].time;
    const [timeResult] = await db.query(`SELECT queue_length FROM department WHERE id = ?`, [department_id]);
    var time = timeResult[0].queue_length;
    const sql = `UPDATE department SET queue_length = ? WHERE id = ?`;
    await db.query(sql, [time - dtime, department_id]);
    const sql2 = `DELETE FROM queue WHERE order_id = ? AND department_id = ?`;
    await db.query(sql2, [order_id, department_id]);
    res.send();
});

router.post("/alter", async function (req, res) {
    const { order_id, department_id } = req.body;
    // 实现改排逻辑
    res.send();
});

router.post("/list", async function (req, res) {
    const sql = `SELECT name, queue_length, number FROM department WHERE id IN (9, 10, 14, 16, 17, 19, 24, 25) ORDER BY id`;
    const [result] = await db.query(sql);
    res.send(result);
});


module.exports = router;