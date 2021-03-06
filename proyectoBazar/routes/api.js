var express = require('express');
var router = express.Router();
const apisController= require("../controller/api/apisController");

/* GET home page. */
router.get('/users', apisController.usersList);
router.get("/orders", apisController.amountOrder);
router.get("/categories", apisController.categoriesList);
router.get("/subcategories", apisController.subcategoryList);
router.get('/products', apisController.productsList);
router.get("/users/:id" , apisController.userDetail);
router.get("/products/:id", apisController.productDetail);
router.post("/cart/update", apisController.updateCart);
router.post("/users/checkPassword", apisController.checkPassword)
router.post("/users/updatePassword" , apisController.updatePassword);



module.exports = router;
