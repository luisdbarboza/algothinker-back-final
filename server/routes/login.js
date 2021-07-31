const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const currentRoute = express.Router();

const { pool: dbPool } = require('../database/db');
const { respondWithErrorMessage } = require('../helpers');

currentRoute.post('/', async (req, res) => {
  const { email, password } = req.body;
  const customError = 'INCORRECT_CREDENTIALS';
  try {
    const sqlQuery = `SELECT id, name, email, profile_picture, password FROM users WHERE email = $1`;
    let params = [email];
    let results = await dbPool.query(sqlQuery, params);
    const user = results.rows[0];

    if (!user) {
      throw new Error(customError);
    }

    const arePasswordsEquivalent = await bcrypt.compare(
      password,
      user.password
    );

    if (!arePasswordsEquivalent) {
      throw new Error(customError);
    }

    delete user.password;

    const token = jwt.sign(
      {
        user,
      },
      process.env.SECRET_KEY,
      {
        expiresIn: '365d',
      }
    );

    res.json({
      ok: true,
      user,
      token,
    });
  } catch (err) {
    if (err.message === customError) {
      return res.status(500).json({
        ok: false,
        err: err.message,
      });
    } else respondWithErrorMessage(res, err, 500);
  }
});

module.exports = currentRoute;
