const express = require('express');

const CategoriesController = require("../classes/CategoriesController");

const currentRoute = express.Router();

currentRoute
  .route('/')
  .get(CategoriesController.getAllCategoriesInfo)
  .post(CategoriesController.createCategory);

currentRoute.route('/tree').get(CategoriesController.getCategoriesTree)

currentRoute.route('/:id').delete(CategoriesController.deleteCategory);

module.exports = currentRoute;
