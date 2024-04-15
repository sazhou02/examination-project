const express = require("express");
const router = express.Router();
const db = require("../db/connector");

router.get("/detail", async (req, res) => {
  const { centerId, year } = req.query;
  const [result] = await db.query("SELECT * FROM schedule WHERE center_id = ? AND year = ? ORDER BY month, date", [centerId, year]);
  let schedule = {};
  result.forEach(row => {
    if (!schedule[row.month]) {
      schedule[row.month] = [];
    }
    schedule[row.month].push({ num: row.num });
  });
  res.send(schedule);
});

router.post("/update", async (req, res) => {
  const { schedule, year, centerId } = req.body;
  let promises = [];

  for (let i = 1; i <= 12; i++) {
    if (schedule[i]) {
      const [result] = await db.query(
        "SELECT * FROM schedule WHERE year = ? AND month = ? AND center_id = ?",
        [year, i, centerId]
      );
      if (result.length) {
        await db.query(
          "DELETE FROM schedule WHERE year = ? AND month = ? AND center_id = ?",
          [year, i, centerId]
        );
      }
      schedule[i].forEach((item, index) => {
        let value = item.num;
        promises.push(db.query(
          "INSERT INTO schedule (year, month, date, num, center_id) VALUES (?, ?, ?, ?, ?)",
          [year, i, index + 1, value, centerId]
        ));
      });
    }
  }
  
  await Promise.all(promises);
  res.send({ message: 'Schedule updated successfully' });
});

module.exports = router;
