const { pool: dbPool } = require('../database/db');
const { respondWithErrorMessage, updateTableById } = require('../helpers');

class ChallengeController {
  async getAllChallenges(req, res) {
    try {
      const sqlQuery = 'SELECT * FROM challenges';
      const result = await dbPool.query(sqlQuery);
      const challenges = result.rows;

      res.json({
        ok: true,
        challenges,
      });
    } catch (err) {
      respondWithErrorMessage(res, err, 500);
    }
  }

  async getChallengesPerTopic(req, res) {
    const customError = 'Reto inexistente';

    try {
      const topicTitle = req.params.id;
      let sqlQuery = `SELECT id FROM topics where title=$1`;
      let values = [topicTitle];
      let result = await dbPool.query(sqlQuery, values);
      let topicId = result.rows[0].id;

      sqlQuery = `SELECT * FROM challenges where topic_id=$1`;
      values = [topicId];
      result = await dbPool.query(sqlQuery, values);

      if (result.rowCount) {
        res.json({
          ok: true,
          challenges: result.rows,
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

  async getSingleChallengeInfo(req, res) {
    const customError = 'Reto inexistente';

    try {
      const challengeId = req.params.id;
      const sqlQuery = `SELECT * FROM challenges where id=$1`;
      const values = [challengeId];
      const result = await dbPool.query(sqlQuery, values);

      if (result.rowCount) {
        res.json({
          ok: true,
          challege: result.rows,
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

  async getChallengesSolvedPerUserAndTopic(req, res) {
    const customError = 'Usuario inexistente';

    try {
      const topicTitle = req.params.id;
      const userId = req.user.id;

      let sqlQuery = `
        SELECT  
          DISTINCT user_id, challenge_id, topic_id,
          challenges.title AS challenge_title, topics.title AS topic_title
        FROM challenges_solved JOIN challenges ON challenges.id = challenges_solved.challenge_id
        JOIN topics ON topics.id = challenges.topic_id 
        WHERE user_id=$1 AND topics.title=$2
      `;

      let values = [userId, topicTitle];
      let result = await dbPool.query(sqlQuery, values);

      res.json({
        ok: true,
        challenges: result.rows,
      });
    } catch (err) {
      console.log(err);
      if (err.message != customError) respondWithErrorMessage(res, err, 500);
      else {
        respondWithErrorMessage(res, customError, 400);
      }
    }
  }

  async createChallenge(req, res) {
    try {
      const { topicId, title, heading, difficultyLevel, functionName } =
        req.body;
      let sqlQuery = `INSERT INTO challenges ( topic_id, title, heading, difficulty_level, function_name) `;
      sqlQuery += `VALUES ($1, $2, $3, $4, $5) RETURNING id`;
      const values = [topicId, title, heading, difficultyLevel, functionName];

      const result = await dbPool.query(sqlQuery, values);
      const challengeId = result.rows[0].id;

      res.status(201).json({
        ok: true,
        message: 'Desafio registrado',
        challengeId: challengeId,
      });
    } catch (err) {
      respondWithErrorMessage(res, err, 500);
    }
  }

  async updateChallenge(req, res) {
    const customError = 'Usuario inexistente';

    try {
      let sqlQuery;
      let result;
      let values;
      const challegeId = req.params.id;

      sqlQuery = updateTableById(challegeId, 'challenges', req.body);

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

  async deleteChallenge(req, res) {
    try {
      let customError = 'Reto inexistente';

      const challengeId = req.params.id;
      const sqlQuery = `DELETE FROM challenges WHERE id=$1 RETURNING challenges`;
      const values = [challengeId];
      const result = await dbPool.query(sqlQuery, values);

      if (result.rowCount === 1) {
        res.json({
          ok: true,
          message: 'Reto borrado',
        });
      } else {
        throw new Error(customError);
      }
    } catch (err) {
      if (err.message != customError) respondWithErrorMessage(res, err, 500);
      else {
        customError = { message: err.message };
        respondWithErrorMessage(res, customError, 400);
      }
    }
  }
}

module.exports = new ChallengeController();
