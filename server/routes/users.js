const express = require('express');
const UserController = require('../classes/UserController');
const { verifyToken } = require('../middlewares/auth');

const currentRoute = express.Router();

currentRoute
  .route('/')
  .get(UserController.getAllUsersInfo)
  .post(UserController.createUser)
  .put(verifyToken, UserController.updateUser);

currentRoute
  .route('/:id')
  .get(UserController.getSingleUserInfo)
  .delete(UserController.deleteUser);

module.exports = currentRoute;
