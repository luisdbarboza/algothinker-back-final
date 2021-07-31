const express = require("express");
const upload = require("../config/multer");

const ImageController = require("../classes/ImageController");

const route = express.Router();

route.get("/:type/:filename", ImageController.sendFile);

route.post("/upload/:type", upload.array("images"), ImageController.upload);

module.exports = route;