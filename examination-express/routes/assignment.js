const express = require("express");
const router = express.Router();
const db = require("../db/connector");
const { Assignment } = require("../db/baseApi.js");

router.get("/getByOrder/:id", async function (req, res) {
  const sql = `SELECT * FROM assignment WHERE order_id = ?`;
  const [result] = await db.query(sql, [req.params.id]);
  res.send(result);
});

router.post("/intel", async function (req, res) {
  const { examinee_id } = req.body;

  // 查找订单号
  const [orderResult] = await db.query(
    `SELECT id FROM examination_order WHERE examinee_id = ? AND status IN (0,1,2,3,6)`,
    [examinee_id]
  );
  if (!orderResult.length) {
    return res.send({ message: "Order not found" });
  }
  const order_id = orderResult[0].id;

  // 查找 category_id
  const [categoryResults] = await db.query(
    `SELECT category_id FROM assignment WHERE order_id = ? AND status = 0`,
    [order_id]
  );

  // 计算年龄
  const [birthdayResult] = await db.query(
    `SELECT birthday FROM examinee WHERE id = ?`,
    [examinee_id]
  );
  const birthday = new Date(birthdayResult[0].birthday);
  const age = Math.floor(
    (new Date().getTime() - birthday.getTime()) / 31536000000
  );

  // 判断制约关系
  const four_two = false,
    six_ten = false,
    nine_all = false,
    breakfast = true;
  if (
    categoryResults.length == 0 ||
    (categoryResults.length == 1 && categoryResults[0].category_id == 10)
  ) {
    // 无项目，体检结束
    await db.query(`UPDATE examination_order SET status = ? WHERE id = ?`, [
      4,
      order_id,
    ]);
    res.send({ end: true });
  } else {
    categoryResults.forEach(({ category_id }) => {
      if (category_id == 4) four_two = true; // 心电图 -> 内科
      if (category_id == 6) {
        six_ten = true;
        breakfast = false;
      } // 超声 -> 尿检
      if (category_id == 9) {
        nine_all = true;
        breakfast = false;
      } // 抽血先做
    });

    //组合sql，筛选内容：包含所排科室did、检查时长time
    var sql = `select department_id, sum(average_duration) as time from category where id in (`;
    for (var i = 0; i < categoryResults.length; ++i) {
      if (categoryResults[i].category_id == 2 && four_two == true) {
        continue;
      } //心电图-》内科
      else if (categoryResults[i].category_id == 10 && six_ten == true) {
        continue;
      } //超声-》尿检
      else if (categoryResults[i].category_id == 10) {
        continue;
      } else {
        sql = sql + categoryResults[i].category_id + `,`;
      }
    }
    sql = sql.substring(0, sql.length - 1);
    sql = sql + `) group by department_id`;
    const [result] = await db.query(sql); //{department_id:,time:}

    //排队逻辑(还需扩充)
    var did = -1,
      time = -1,
      dtime = -1; //最终选择的科室
    if (nine_all) {
      const [queueResult] = await db.query(
        `SELECT queue_length FROM department WHERE id = ?`,
        [14]
      );
      did = 14;
      time = queueResult[0].queue_length;
    } else {
      var sql2 = `select id,queue_length from department where id in (`;
      for (var i = 0; i < result.length; ++i) {
        sql2 = sql2 + result[i].department_id + `,`;
      }
      sql2 = sql2.substring(0, sql2.length - 1);
      sql2 = sql2 + `) order by queue_length limit 1`;
      var result2 = (await db.query(sql2)).rows[0];
      did = result2.id;
      time = result2.queue_length;
    }
    for (var i = 0; i < result.length; ++i) {
      if (result[i].department_id == did) {
        dtime = result[i].time;
        time = time + dtime;
        break;
      }
    }

    // 判断是否可以吃饭
    if (breakfast) {
      const [breakfastResult] = await db.query(
        `SELECT breakfast FROM examination_order WHERE examinee_id = ? AND status IN (0, 1, 2, 3, 6)`,
        [examinee_id]
      );
      if (breakfastResult.length > 0) {
        let status = breakfastResult[0].breakfast;
        if (status == 0) {
          await db.query(
            `UPDATE examination_order SET breakfast = 1 WHERE id = ?`,
            [order_id]
          );
        }
      }
    }

    // 插入排队序列(需判空)
    const [qMinResult] = await db.query(
      `SELECT serial_number FROM queue WHERE department_id = ? ORDER BY serial_number ASC LIMIT 1`,
      [did]
    );
    const [qMaxResult] = await db.query(
      `SELECT serial_number FROM queue WHERE department_id = ? ORDER BY serial_number DESC LIMIT 1`,
      [did]
    );
    let q_min = qMinResult.length === 0 ? 1 : qMinResult[0].serial_number;
    let q_max = qMaxResult.length === 0 ? 1 : qMaxResult[0].serial_number;
    let q_num = -1;
    if (age >= 75) {
      q_num = (q_min + 1) % 9999;
    } else {
      q_num = (q_max + 2) % 9999;
    }

    let curTime = new Date();
    let addSeconds = new Date(
      curTime.setSeconds(curTime.getSeconds() + time - dtime)
    );
    let formattedTime = `${addSeconds.getHours()}:${addSeconds.getMinutes()}:${addSeconds.getSeconds()}`;
    await db.query(
      `INSERT INTO queue (department_id, serial_number, order_id, time, clock_time) VALUES (?, ?, ?, ?, ?)`,
      [did, q_num, order_id, dtime, formattedTime]
    );

    await db.query(
      `UPDATE department SET queue_length = ?, number = ? WHERE id = ?`,
      [time + dtime, q_num, did]
    );

    //department_id、time、number、breakfast
    res.send({
      department_id: did,
      time: time,
      number: q_num,
      order_id: order_id,
      end: false,
    });
  }
});

module.exports = router;
