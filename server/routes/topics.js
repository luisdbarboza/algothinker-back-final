const express = require('express');

const TopicController = require("../classes/TopicController");

const currentRoute = express.Router();

currentRoute.route('/')
  .post(TopicController.createTopic);

currentRoute
  .route('/:id')
  .get(TopicController.getSingleTopic)
  .put(TopicController.updateTopicInformation)
  .delete(TopicController.deleteTopic);

currentRoute
  .route('/:id/:typeOfData')
  .get(TopicController.getSingleTopicTypeOfData);

module.exports = currentRoute;
