const mysql = require('mysql2');
const configs = require('./config'); // 确保你的配置文件包含数据库配置

const pool = mysql.createPool(configs.db).promise(); // 使用promise()以支持Promise API

module.exports = pool;