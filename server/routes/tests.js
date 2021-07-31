const express = require('express');
const { verifyToken } = require('../middlewares/auth');

const currentRoute = express.Router();

const TestsController = require('../classes/TestsController');

currentRoute
  .route('/')
  .get(TestsController.getAllTests)
  .post(TestsController.createTest);

currentRoute
  .route('/:id')
  .put(TestsController.updateTest)
  .delete(TestsController.deleteChallenge);

currentRoute
  .route('/challenge')
  .post(verifyToken, TestsController.evaluateTest);

module.exports = currentRoute;
