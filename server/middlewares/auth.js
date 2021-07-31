const jwt = require("jsonwebtoken");

const verifyToken = (req, res, next) => {
  let token = JSON.parse(req.get("token"));

  jwt.verify(token, process.env.SECRET_KEY, (err, decoded) => {
    if (err) {
      return res.status(401).json({
        ok: false,
        err,
      });
    }

    req.user = decoded.user;

    next();
  });
};

module.exports = {
  verifyToken,
};