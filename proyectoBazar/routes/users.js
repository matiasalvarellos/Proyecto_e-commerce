var express = require('express');
var router = express.Router();
const usersController= require("../controller/usersController");
const validator = require("../middlewares/express-validator");
const guestMiddleware = require("../middlewares/guestMiddleware")
const authMiddleware = require("../middlewares/authMiddleware");
const userMulterConfig = require("../middlewares/multer/multerRegister");

/* GET users listing. */
router.get('/login', guestMiddleware ,usersController.login);
router.post("/login", validator.login , usersController.processLogin);
router.get("/register", usersController.registro);
router.post("/register", userMulterConfig.single("avatar"), validator.regis, usersController.processRegistro);
router.post("/logout", usersController.logout);

module.exports = router;
