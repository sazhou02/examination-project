const express = require("express");
const router = express.Router();
const db = require("../db/connector");
const { underlineToCamel } = require("../util");
const { Examinee } = require("../db/baseApi");

//新增或更改体检人信息
router.post("/update", async function (req, res) {
  try {
    const { id, packageId, centerId, examinee, groupInformationId } = req.body;
    const {
      name,
      identificationNumber,
      sex,
      birthday,
      phone,
      relationshipId,
      status,
      examineDate
    } = examinee;

    let orderId, examineeId;
    if (status === "add") {
      const [examineeRes] = await db.query(
        "SELECT * FROM examinee WHERE user_id = ?",
        [id]
      );
      if (!examineeRes[0]?.id) {
        const [result] = await db.query(
          "INSERT INTO examinee (name, identification_number, sex, birthday, phone, create_time, user_id, relationship_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
          [
            name,
            identificationNumber,
            sex,
            birthday,
            phone,
            new Date(),
            id,
            relationshipId,
          ]
        );
        examineeId = result.insertId;
      } else {
        examineeId = examineeRes[0].id;
      }
      const [ordeRres] = await db.query(
        "INSERT INTO examination_order (examinee_id, package_id, status, type, examine_date, period, group_information_id, center_id, phone, breakfast) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [examineeId, packageId, 1, 1, examineDate, 0, groupInformationId, centerId, phone, 0]
      );
      console.log("groupInformationId:::", groupInformationId);
      if (groupInformationId) {
        // 团购
        const [groupRes] = await db.query(
          "SELECT * FROM group_information WHERE package_id = ? AND id = ?",
          [packageId, groupInformationId]
        );
        console.log("groupRes:::", groupRes);
        if (groupRes[0].number === 3) {
          const [groupOrderRes] = await db.query(
            "SELECT * FROM examination_order WHERE group_information_id = ?",
            [groupInformationId]
          );
          const groupOrderIds = groupOrderRes.map((item) => item.id);
          console.log("groupOrderIds:::", groupOrderIds);
          const processPromises = groupOrderIds.map(orderId => orderProcess(orderId, packageId));
          await Promise.all(processPromises);
          res.send({ message: "三人拼团成功! " });
        } else {
          res.send({ message: "ok" });
        }
      } else {
        // 订单id
        orderId = ordeRres.insertId;
        orderProcess(orderId, packageId);
        res.send({ message: "ok" });
      }
    } else {
      Examinee.updateOne(examinee, examinee.id);
      // await db.query(
      //   "update examinee (name, identification_number, sex, birthday, phone, create_time, user_id, relation) values ($1, $2, $3, $4, $5, CURRENT_TIMESTAMP, $6, $7)",
      //   [name, identificationNumber, sex, birthday, phone, id, relationship]
      // )
      res.send({ message: "ok" });
    }
  } catch (error) {
    console.error("Error:", error);
    res.status(500).send("Internal Server Error");
  }
});

router.get("/list", async function (req, res) {
  const { id } = req.body;
  const [result] = await db.query("select * from examinee where user_id = ?", [
    id,
  ]);
  res.send(underlineToCamel(result));
});

router.delete("/delete", async function (req, res) {
  const { id } = req.query;
  await db.query("delete from examinee where id = ?", [id]);
  res.send();
});

const orderProcess = async (orderId, packageId) => {
  try {
    const sql = `SELECT DISTINCT
                b.category_id 
              FROM 
                examination_order a
                JOIN package_category b ON a.package_id = b.package_id
              WHERE 
              a.id = ?`;
    let [que] = await db.query(sql, [orderId]);
    let values = que.map((item) => [
      item.category_id,
      orderId,
      0,
      false,
      new Date(),
    ]);
    if (values.length > 0) {
      let sql2 = `INSERT INTO assignment (category_id, order_id, status, is_extra, create_time) VALUES ?`;
      await db.query(sql2, [values]);
    }
    const [packageCategoryRes] = await db.query(
      "SELECT category_id FROM package_category WHERE package_id = ?",
      [packageId]
    );
    // 分类id
    const categoryIds = packageCategoryRes.map((item) => item.category_id);

    const [categoryRes] = await db.query(
      "SELECT department_id FROM category WHERE id IN (?)",
      [categoryIds]
    );
    // 科室id
    const departmentIds = categoryRes.map((item) => item.department_id);
    const uniqueDepartmentIds = [...new Set(departmentIds)];
    await Promise.all(uniqueDepartmentIds.map((item, index) => {
      return db.query(
        "INSERT INTO queue (department_id, serial_number, order_id, time) VALUES (?, ?, ?, ?)",
        [item, orderId + index + 1, orderId, 30]
      );
    }));
  } catch (error) {
    console.error("error in orderProcess:", error);
    throw error;
  }
};

module.exports = router;
