var express = require('express');
var router = express.Router();
const apisController= require("../controller/api/apisController");

/* GET home page. */
router.get('/users', apisController.usersList);
router.get('/products', apisController.productsList);
router.get('/lastProducts', apisController.lastProducts);
router.get("/users/:id" , apisController.userDetail);
router.post("/users/checkPassword", apisController.checkPassword)
router.post("/users/updatePassword" , apisController.updatePassword);
router.get("/products/:id", apisController.productDetail);


module.exports = router;
