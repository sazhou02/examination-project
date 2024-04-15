const db = require("./connector");
const { COLUMNS, COLUMN_QUERY_TYPE } = require("./constants");
const { camelToUnderline, underlineToPascal, underlineToCamel, getCurTime } = require("../util");

// 将常用单表sql封装成api，传入参数可自动拼接生成sql
class BaseApi {
  constructor(table) {
    this.table = table;
    this.columns = COLUMNS[table];
    this.columnsWithId = this.columns.concat('id');
  }

  // 返回实体的字段名-值数组
  getColValList(entity) {
    camelToUnderline(entity);
    return this.columns.map((column) => {
      const value = entity[column];
      let val;
      if (column === "create_time") {
        val = getCurTime();
      } else if (value === void 0) {
        val = null;
      } else {
        val = value;
      }
      return [column, val];
    });
  }

  // 返回实体的字段数组
  getColList(entity) {
    return this.getColValList(entity).map((pair) => pair[0]);
  }

  // 返回实体的值数组
  getValueList(entity) {
    return this.getColValList(entity).map((pair) => pair[1]);
  }

  insertOne(entity) {
    const valueList = this.getValueList(entity);
    const placeholders = new Array(valueList.length).fill('?').join(', ');
    const sql = `INSERT INTO ${this.table} (${this.columns.join()}) VALUES (${placeholders})`;
    return db.query(sql, valueList);
  }

  insertMany(entities) {
    const len = this.getValueList(entities[0]).length;
    const allValues = entities.map((entity) => this.getValueList(entity)).flat();
    const placeholders = entities.map(() => `(${new Array(len).fill('?').join(', ')})`).join(', ');
    const sql = `INSERT INTO ${this.table} (${this.columns.join()}) VALUES ${placeholders}`;
    return db.query(sql, allValues);
  }

  deleteOne(id) {
    const sql = `DELETE FROM ${this.table} WHERE id = ?`;
    return db.query(sql, [id]);
  }

  deleteMany(ids) {
    const placeholders = new Array(ids.length).fill('?').join(', ');
    const sql = `DELETE FROM ${this.table} WHERE id IN (${placeholders})`;
    return db.query(sql, ids);
  }

  updateOne(entity, id) {
    const colValList = this.getColValList(entity).filter((pair) => pair[0] !== 'create_time');
    const setSql = colValList.map((pair) => `${pair[0]} = ?`).join(', ');
    const sql = `UPDATE ${this.table} SET ${setSql} WHERE id = ?`;
    const values = [...colValList.map(pair => pair[1]), id];
    return db.query(sql, values);
  }

  async updateMany(entities) {
    for (let entity of entities) {
      await this.updateOne(entity, entity.id);
    }
  }

  // 查询所有结果
  async list(columns = this.columnsWithId) {
    const sql = `SELECT ${columns.join()} FROM ${this.table}`;
    let result = await db.query(sql);
    underlineToCamel(result.rows);
    return result;
  }

  // 分页 + 条件过滤
  page(filter, columns = this.columns) {
    const { page = 1, size = 8, sorted, order = "asc", query } = filter;
    camelToUnderline(query);
    let allValues = [];
    const querySql = this.columnsWithId.map((col) => {
      const condition = query[col];
      if (condition === void 0 || condition === null) return;
      const type = COLUMN_QUERY_TYPE[this.table][col];
      switch (type) {
        case -1: {
          return;
        }
        case 0: {
          allValues.push(condition);
          return `${col} = ?`;
        }
        case 1: {
          allValues.push(`%${condition}%`);
          return `${col} LIKE ?`;
        }
        case 2: {
          let sqlList = [];
          const { start, end } = condition;
          if (start) {
            allValues.push(start);
            sqlList.push(`${col} > ?`);
          }
          if (end) {
            allValues.push(end);
            sqlList.push(`${col} < ?`);
          }
          return sqlList.join(" AND ");
        }
        case 3: {
          allValues = allValues.concat(condition);
          const placeholders = new Array(condition.length).fill('?').join(', ');
          return `${col} IN (${placeholders})`;
        }
      }
    })
    .filter((part) => part)
    .join(' AND ');
    
    let sql = `SELECT ${columns.join()} FROM ${this.table}`;
    if (querySql) sql += ` WHERE ${querySql}`;
    if (sorted && this.columnsWithId.includes(sorted) && /asc|desc/i.test(order)) {
      sql += ` ORDER BY ${sorted} ${order}`;
    }
    
    // MySQL uses LIMIT offset, count instead of LIMIT count OFFSET offset
    sql += ` LIMIT ?, ?`;
    allValues.push((page - 1) * size, size);
    return db.query(sql, allValues);
  }
}

const TableApiCollection = Object.keys(COLUMNS).reduce((pre, cur) => {
  pre[underlineToPascal(cur)] = new BaseApi(cur);
  return pre;
}, {});

module.exports = TableApiCollection;