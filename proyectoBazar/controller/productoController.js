const db = require('../database/models');
const { Op } = require("sequelize");
const {validationResult} = require("express-validator");


function price(cost, markup){
    let ganancia = (Number(cost) * Number(markup))/100;
    let total = ganancia + Number(cost);
    return total;
}

producto={
    buscar: function (req, res, next) {
        let productToFind = req.query.product;
        db.Product.findAll({
            include: ["images"],
            where: {
                name: { [Op.like]: '%' + productToFind + '%' }
            }
        })
        .then(function (products) {
            res.render("productList", { products: products });
        })
    },
    list:function(req,res,next){
        db.Product.findAll( {include: [ {association:"images"}]}).then(function(products){
            res.render("productList", { products:products })
        })
    },
    crear: async function (req, res, next ){
        let colors = await db.Color.findAll() 
        let categories = await db.Category.findAll({
            include:[{association:"subcategories"}]
        })
        res.render("productCreate", {categories, colors});
    },
    store: async function (req, res, next){ 
        
        let errors =validationResult(req);

       if(errors.isEmpty()){
        let productCreate = await db.Product.create({
            code: req.body.code,
            name: req.body.name,
            stock: req.body.stock,
            color: req.body.color,
            description: req.body.description,
            cost:req.body.cost,
            markup: req.body.markup,
            discount: req.body.discount,
            price: price(req.body.cost, req.body.markup),
            offer: 0,
            subcategory_id: req.body.subcategories       
        })
        let imagesTocreate = req.files.map(file => {
            return {
                name: file.filename,
                product_id: productCreate.id,
            }
        })
        await db.Image.bulkCreate(imagesTocreate);
        await productCreate.setColors(req.body.colors);
        res.redirect("/productos");
        } else {
            let colors = await db.Color.findAll() 
            let categories = await db.Category.findAll({
                include:[{association:"subcategories"}]
            })
            return res.render("productCreate", {categories, colors, errors:errors.errors })
        }
    },        
    detalle: async function (req, res, next ){
        let productFound = await db.Product.findByPk(req.params.id, {
            include:["colors", "images", "subcategory"]
        })
        if(productFound){
            res.render("productDetail", { productFound});
        }else{
            res.render("productDetail", { alert: true });
        }
    },
    edit: async function(req, res, next){
        let colors = await db.Color.findAll();
        let categories = await db.Category.findAll({
            include: [{ association: "subcategories" }]
        })
        let product = await db.Product.findByPk(req.params.id,{
            include:["colors", "images", "subcategory"]
        });
        product.colorsId = product.colors.map(color =>{
            return color.id ;
        })
        if(product){
            res.render("productUpdate", { product, categories, colors});
        } else {
            res.render("productUpdate", { alert: true });
        }
    },
    update: async function(req, res, next){
        
        await db.Product.update({
            code: req.body.code,
            name: req.body.name,
            stock: req.body.stock,
            description: req.body.description,
            cost: req.body.cost,
            markup: req.body.markup,
            discount: req.body.discount,
            price: price(req.body.cost, req.body.markup),
            subcategory_id: req.body.subcategories,
        },{
            where: {
                id: req.params.id
            }
        })
        let productFound = await db.Product.findByPk(req.params.id);
        if(productFound){
            await productFound.setColors(req.body.colors);
        }
        res.redirect("/")
    },
    delete: async function(req, res, next){
        let product = await db.Product.findByPk(req.params.id);
        await product.setColors([]);
        await db.Image.destroy({
            where: {
                product_id: req.params.id
     
            }
        })
        await db.Product.destroy({
            where:{
                id: req.params.id
            }
        })
        res.redirect("/productos")
    },
    imageDelete:function (req, res, next){
        let imageName= req.body.imageToDelete;
        let productId;
        db.Image.findOne({name:imageName}).then(function(image){
             productId=image.product_id;
             db.Image.destroy ( {
                where: {
                    name:req.body.imageToDelete
                }
            }).then(function(){res.redirect("/productos/edit-images/"+productId); })


         })         
    
    },
    addImages: async function(req,res,next){
       let  productId=req.body.product_id;
        let imagesTocreate = req.files.map(file => {
            return {
                name: file.filename,
                product_id: productId,
            }
        })
        await db.Image.bulkCreate(imagesTocreate);
        res.redirect("/productos/edit-images/"+productId);
    },
    editImages: async function (req,res,next){
        let product = await  db.Product.findByPk(req.params.id,{
            include:[ "images"]
        });
        res.render("edit-images", {product})
    }
}

        
                   
                
        



module.exports=producto;