const bcrypt = require('bcrypt');
const { pool: dbPool } = require('../database/db');
const path = require('path');
const {
  respondWithErrorMessage,
  deleteFile,
  updateTableById,
} = require('../helpers');

const uploadFolder = path.join(__dirname, '../uploads/Users');

class UserController {
  async getAllUsersInfo(req, res) {
    try {
      const sqlQuery = 'SELECT * FROM users';
      const result = await dbPool.query(sqlQuery);
      const users = result.rows;

      res.json({
        ok: true,
        users,
      });
    } catch (err) {
      respondWithErrorMessage(res, err, 500);
    }
  }

  async getSingleUserInfo(req, res) {
    const customError = 'Usuario inexistente';

    try {
      const userId = req.params.id;
      const sqlQuery = `SELECT id, name, email, profile_picture FROM users WHERE id=$1`;
      const values = [userId];
      const result = await dbPool.query(sqlQuery, values);

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

  async createUser(req, res) {
    try {
      const { name, email, password } = req.body;
      const saltRounds = 10;
      const hashedPassword = await bcrypt.hash(password, saltRounds);

      let sqlQuery = `SELECT email FROM users WHERE email=$1`;
      let values = [email];
      let result = await dbPool.query(sqlQuery, values);
      let firstMatch = result.rows[0];

      if (firstMatch) {
        res.status(500).json({
          ok: false,
          err: 'EMAIL_ALREADY_REGISTERED',
        });
      } else {
        sqlQuery = `INSERT INTO users ( name, email, password)`;
        sqlQuery += `VALUES ($1, $2, $3) RETURNING id`;
        values = [name, email, hashedPassword];

        result = await dbPool.query(sqlQuery, values);
        const userId = result.rows[0].id;

        res.status(201).json({
          ok: true,
          message: 'Usuario registrado',
          userId: userId,
        });
      }
    } catch (err) {
      respondWithErrorMessage(res, err, 500);
    }
  }

  async updateUser(req, res) {
    const customError = 'Usuario inexistente';

    try {
      let sqlQuery;
      let result;
      let values;
      const userId = req.user.id;;

      if (req.body.profile_picture) {
        //borra su foto de perfil vieja del sistema de archivos
        let oldProfilePicturePath;

        sqlQuery = 'SELECT profile_picture FROM users WHERE id = $1';
        values = [userId];

        result = await dbPool.query(sqlQuery, values);

        oldProfilePicturePath = result.rows[0].profile_picture;

        if (oldProfilePicturePath.length > 0) {
          oldProfilePicturePath = uploadFolder + '/' + oldProfilePicturePath;

          await deleteFile(oldProfilePicturePath);
        }
      }

      if('password' in req.body) {
        if(req.body.password.trim().length > 0) {
          const saltRounds = 10;
          req.body.password = await bcrypt.hash(req.body.password, saltRounds);  
        } else {
          delete req.body.password;
        }
      }

      if('name' in req.body && req.body.name.trim().length === 0) {
        delete req.body.name;
      }

      sqlQuery = updateTableById(userId, 'users', req.body);

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

  async deleteUser(req, res) {
    try {
      let customError = 'Usuario inexistente';

      const userId = req.params.id;
      const sqlQuery = `DELETE FROM users WHERE id=$1 RETURNING users`;
      const values = [userId];
      const result = await dbPool.query(sqlQuery, values);
      const profilePictureFilename = result.rows[0].users.split(',')[3];

      if (profilePictureFilename !== '""') {
        const profilePicturePath = `${uploadFolder}/${profilePictureFilename}`;

        await deleteFile(profilePicturePath);
      }

      if (result.rowCount === 1) {
        res.json({
          ok: true,
          message: 'Usuario borrado',
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

module.exports = new UserController();
