const express = require('express');
const { verifyToken } = require('../middlewares/auth');

const currentRoute = express.Router();

const ChallengeController = require('../classes/ChallengeController');

currentRoute
  .route('/')
  .get(ChallengeController.getAllChallenges)
  .post(ChallengeController.createChallenge);

currentRoute
  .route('/:id')
  .get(ChallengeController.getSingleChallengeInfo)
  .put(ChallengeController.updateChallenge)
  .delete(ChallengeController.deleteChallenge);

currentRoute.route('/topic/:id').get(ChallengeController.getChallengesPerTopic);

currentRoute
  .route('/user/topic/:id')
  .get(verifyToken, ChallengeController.getChallengesSolvedPerUserAndTopic);

module.exports = currentRoute;
