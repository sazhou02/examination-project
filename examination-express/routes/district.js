const express = require('express');
const router = express.Router();
const db = require('../db/connector');
const { District } = require('../db/baseApi');

router.get("/list", async (req, res) => {
  const [result] = await District.list();
  res.send(result);
});

module.exports = router;