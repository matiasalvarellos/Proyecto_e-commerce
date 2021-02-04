var express = require('express');
var router = express.Router();
const apisController= require("../controller/api/apisController");

/* GET home page. */
router.get('/users', apisController.listUser);
router.get('/products', apisController.listProducts);
router.get('/lastProducts', apisController.lastProducts);


module.exports = router;
