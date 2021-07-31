const { pool: dbPool } = require('../database/db');

const { respondWithErrorMessage } = require('../helpers');

class CategoriesController {
  async getAllCategoriesInfo(req, res) {
    try {
      const sqlQuery = 'SELECT * FROM categories';
      const result = await dbPool.query(sqlQuery);
      const categories = result.rows;

      res.json({
        ok: true,
        categories,
      });
    } catch (err) {
      respondWithErrorMessage(res, err, 500);
    }
  }

  async getCategoriesTree(req, res) {
      try {
        const tree = [];
        let values;
        let sqlQuery = 'SELECT * FROM categories';
        let result = await dbPool.query(sqlQuery);
        const categories = result.rows;

        for (let category of categories) {
          const treeItem = {};
          treeItem.title = category.title;
          treeItem.icon = category.icon;

          sqlQuery = 'SELECT id, title, icon FROM topics WHERE category_id = $1';
          values = [category.id];

          result = await dbPool.query(sqlQuery, values);
          
          treeItem.topics = result.rows;
          tree.push(treeItem);
        }

        res.json({
          ok: true,
          tree
        });
      } catch(err) {
        console.log(err);
        respondWithErrorMessage(res, err, 500);
      }
  }

  async createCategory(req, res) {
    try {
      let { title, icon } = req.body;

      icon = JSON.parse(icon);

      let sqlQuery = `INSERT INTO categories (title, icon) `;
      sqlQuery += `VALUES ($1, $2) RETURNING id`;

      const values = [title, icon];

      const result = await dbPool.query(sqlQuery, values);
      const categoryId = result.rows[0].id;

      res.status(201).json({
        ok: true,
        message: 'categoria registrada',
        categoryId: categoryId,
      });
    } catch (err) {
      respondWithErrorMessage(res, err, 500);
    }
  }

  async deleteCategory(req, res) {
    try {
      const categoryId = req.params.id;
      const sqlQuery = `DELETE FROM categories WHERE id=$1 RETURNING categories`;
      const values = [categoryId];
      const result = await dbPool.query(sqlQuery, values);

      if (result.rowCount === 1) {
        res.json({
          ok: true,
          message: 'Categoria borrada',
        });
      } else {
        throw new Error('categoria inexistente');
      }
    } catch (err) {
      if (err.message != 'Usuario inexistente')
        respondWithErrorMessage(res, err, 500);
      else {
        const customError = { message: err.message };
        respondWithErrorMessage(res, customError, 400);
      }
    }
  }
}

module.exports = new CategoriesController();
