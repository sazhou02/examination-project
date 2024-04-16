const express = require('express');
const router = express.Router();
const db = require('../db/connector');
const { PackageCategory } = require('../db/baseApi');

router.get('/list', async function(req, res) {
    const { isHot, tag } = req.query;
    let sql = "SELECT * FROM package";
    let params = [];
    if (isHot) {
        sql += " WHERE is_hot = ?";
        params.push(isHot);
    }
    if (tag) {
        sql += params.length > 0 ? " AND tag = ?" : " WHERE name = ?";
        params.push(tag);
    }
    const [result] = await db.query(sql, params);
    res.send(result);
});

// 按套餐名查所有种类
router.post("/categories", async (req, res) => {
    const { name } = req.body;
    const sql = `SELECT 
                    *
                FROM 
                    package a
                    JOIN package_category b ON a.id = b.package_id
                    JOIN category c ON c.id = b.category_id
                WHERE
                    a.name = ?;`
    const [result] = await db.query(sql, [name]);
    res.send(result);
});

router.get("/categories", async (req, res) => {
    const { id } = req.query;
    const sql = `SELECT 
                    c.name AS name
                FROM 
                    package a
                    JOIN package_category b ON a.id = b.package_id
                    JOIN category c ON c.id = b.category_id
                WHERE
                    a.id = ?;`;
    const [result] = await db.query(sql, [id]);
    res.send(result);
});

router.get("/categoryList", async (req, res) => {
    const [result] = await db.query("SELECT * FROM category");
    res.send(result);
});

router.post("/changeCategories", async (req, res) => {
    const { packageId, items } = req.body;
    await db.query("DELETE FROM package_category WHERE package_id = ?", [packageId]);
    if (items.length) {
        const sql = "INSERT INTO package_category (package_id, category_id) VALUES ?";
        const values = items.map(item => [packageId, item.categoryId]);
        await db.query(sql, [values]);
    }
    res.send();
});

router.get("/allPackageInstitution", async (req, res) => {
    const { packageName } = req.query;
    let sql = `
    SELECT 
        cp.id AS id,
        ec.name AS centerName, 
        ec.address AS centerAddress, 
        ec.id AS centerId,
        p.name AS packageName, 
        p.price AS packagePrice, 
        p.applicable_group AS applicableGroup,
        p.img_src AS imgSrc,
        p.id AS packageId
    FROM center_package cp
    JOIN examination_center ec ON cp.center_id = ec.id
    JOIN package p ON cp.package_id = p.id
`;

    if (packageName) {
        sql += ` WHERE p.name LIKE ?`;
    }
    const [result] = await db.query(sql, packageName ? [`%${packageName}%`] : []);
    res.send(result);
});

router.post("/packageInCenter", async (req, res) => {
    const { centerId } = req.body;

    const sql = `
        SELECT 
            ec.*, 
            p.id As packageId,
            p.name As packageName,
            p.price AS packagePrice,
            p.applicable_group AS applicableGroup,
            p.img_src AS imgSrc
        FROM examination_center ec
        JOIN center_package cp ON ec.id = cp.center_id
        JOIN package p ON cp.package_id = p.id
        WHERE ec.id = ?
    `;
    const [results] = await db.query(sql, [centerId]);
    if (results.length > 0) {
        const response = {
            centerInfo: {
                centerId: results[0].id,
                centerName: results[0].name,
                centerAddress: results[0].address,
                centerNearby: results[0].nearby,
                telephone: results[0].telephone,
                announcement: results[0].announcement,
                centerImg: results[0].img_src,
                responseTime: results[0].response_time,
                consult_num: results[0].consult_num,
                morning_limit: results[0].morning_limit,
                afternoon_limit: results[0].afternoon_limit,
                centerPrice: results[0].price
            },
            packages: results.map(row => ({
                packageId: row.packageId,
                packageName: row.packageName,
                packagePrice: row.packagePrice,
                applicableGroup: row.applicableGroup,
                imgSrc: row.imgSrc
            }))
        };
        res.json(response);
    } else {
        res.status(404).send('Center not found');
    }
});

router.get('/:package_id', async (req, res) => {
    const package_id = req.params.package_id;
    const sql = 'SELECT * FROM package WHERE id = ?';
    const [result] = await db.query(sql, [package_id]);
    res.send(result[0]);
});

module.exports = router;