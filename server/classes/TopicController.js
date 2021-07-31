const { pool: dbPool } = require('../database/db');
const { updateTableById, respondWithErrorMessage } = require('../helpers');

class TopicController {
  async createTopic(req, res) {
    const {
      title,
      icon,
      category_id,
      introduction,
      introduction_image,
      lesson_data,
      visualization_data,
    } = req.body;

    console.log("CREATING TOPIC");

    const lessonData = JSON.parse(lesson_data);

    try {
      let sqlQuery = `INSERT INTO topics ( title, icon, category_id, introduction, introduction_image, `;
      sqlQuery += 'lesson_data, visualization_data) ';
      sqlQuery += ' VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING topics';
      const values = [
        title,
        icon,
        category_id,
        introduction,
        introduction_image,
        lessonData,
        visualization_data,
      ];
      const result = await dbPool.query(sqlQuery, values);

      res.json({
        ok: true,
        topic: result.rows[0],
      });
    } catch (err) {
      console.log(err);
      respondWithErrorMessage(res, err, 500);
    }
  }

  async getSingleTopic(req, res) {
    const customError = 'Topico inexistente';

    try {
      const topicId = req.params.id;
      let sqlQuery = `SELECT  id, title, introduction, introduction_image FROM topics WHERE title=$1`;
      const values = [topicId];
      const result = await dbPool.query(sqlQuery, values);

      if (result.rowCount === 1) {
        res.json({
          ok: true,
          topic: result.rows[0],
        });
      } else {
        throw new Error(customError);
      }
    } catch (err) {
      if (err.message != customError) respondWithErrorMessage(res, err, 500);
      else {
        respondWithErrorMessage(res, customError, 400);
      }
    }
  }

  async getSingleTopicTypeOfData(req, res) {
    const customError = 'Topico inexistente';

    try {
      const topicId = req.params.id;
      const typeOfData = req.params.typeOfData;
      const fieldName = typeOfData === 'leccion' ? 'lesson_data' : 'visualization_data';
      let sqlQuery = `SELECT ${fieldName} FROM topics WHERE title=$1`;
      const values = [topicId];
      const result = await dbPool.query(sqlQuery, values);

      if (result.rowCount === 1) {
        res.json({
          ok: true,
          topicData: typeOfData === 'leccion' ? result.rows[0].lesson_data : result.rows[0],
        });
      } else {
        throw new Error(customError);
      }
    } catch (err) {
      console.log(err);
      if (err.message != customError) respondWithErrorMessage(res, err, 500);
      else {
        respondWithErrorMessage(res, customError, 400);
      }
    }
  }

  async updateTopicInformation(req, res) {
    const customError = 'Topico inexistente';

    try {
      let sqlQuery;
      let result;
      let values;
      const topicId = req.params.id;

      sqlQuery = updateTableById(topicId, 'topics', req.body);

      values = Object.keys(req.body).map((key) => req.body[key]);

      result = await dbPool.query(sqlQuery, values);

      if (result.rowCount === 1) {
        res.json({
          ok: true,
          user: result.rows[0],
        });
      } else {
        throw new Error(customError);
      }
    } catch (err) {
      if (err.message != customError) respondWithErrorMessage(res, err, 500);
      else {
        respondWithErrorMessage(res, customError, 400);
      }
    }
  }

  async deleteTopic(req, res) {
    const customError = 'topico inexistente';

    try {
      const topicId = req.params.id;
      const sqlQuery = `DELETE FROM topics WHERE id=$1 RETURNING topics`;
      const values = [topicId];
      const result = await dbPool.query(sqlQuery, values);

      if (result.rowCount === 1) {
        res.json({
          ok: true,
          message: 'Topico borrado',
        });
      } else {
        throw new Error(customError);
      }
    } catch (err) {
      if (err.message != customError) respondWithErrorMessage(res, err, 500);
      else {
        const error = { message: customError };
        respondWithErrorMessage(res, error, 400);
      }
    }
  }
}

module.exports = new TopicController();
