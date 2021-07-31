const express = require("express");
const route = express.Router();

route.use("/users", require("./users"));
route.use("/categories", require("./categories"));
route.use("/topics", require("./topics"));
route.use("/images", require("./images"));
route.use("/login", require("./login"));
route.use("/challenges", require("./challenges"));
route.use("/tests", require("./tests"));
route.use("/visualizations", require("./visualizations"));

module.exports = route;
