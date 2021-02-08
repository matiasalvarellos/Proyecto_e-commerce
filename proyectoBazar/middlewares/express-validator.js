const {body, validationResult} = require("express-validator");
const fs = require("fs");
const path = require ("path");
const bcrypt = require("bcryptjs");
const db = require("../database/models");

const validar = {   
    regis:[
        body("name")
         .isLength({min:3})
         .withMessage("Campo de nombre debe tener un minimo de 3 caracteres"),
        body("last_name")
         .isLength({min:3})
         .withMessage("Campo de apellido debe tener un minimo de 3 caracteres"),
        body("email")
            .isEmail()
            .withMessage("El Email debe ser valido")
            .bail()
            .custom(function(value){
                return db.User.findOne({
                    where:{
                        email: value
                    }
                }).then(user => {
                    if(user){
                        return Promise.reject("Email ya registrado!")
                    }
                })
            }),
        body("password")
            .isLength({min: 4})
            .withMessage("La contraseña debe tener un minimo de 4 caracteres"),
        body("avatar")
            .custom(function(value, {req}){
                return req.file;
            })
            .withMessage("Imagen Obligatoria")
            .bail()
            .custom(function(value, {req} ){
                const imagenesValidas = [".jpg", ".jpeg", ".png"]
                const extencion = path.extname(req.file.originalname);
                return imagenesValidas.includes(extencion);               
            })
            .withMessage("archivo no valido")
    ],
    login:[
        body("email")
            .notEmpty()
            .withMessage("Completar campo de Email")
            .bail()
            .isEmail()
            .withMessage("Email con formato incorrecto")
            .bail()
            .custom(function(value, {req}){
             return db.User.findOne({
                where:{
                    email: value
                }
             }).then(user => {
                    if(!user){
                        return Promise.reject("Usuario o contraseña invalidos")
                    }
                    if(!bcrypt.compareSync(req.body.password, user.password)){
                        return Promise.reject("Usuario o contraseña invalidos")
                    }
                })
            }),
        body("password")
            .notEmpty()
            .withMessage("Completar campo de contraseña")
    ],

    /*prod:[
        body("code")
         .isLength({min:3})
         .withMessage("Campo de nombre debe tener un minimo de 3 caracteres"),
        body("name")
         .isLength({min:3})
         .withMessage("Campo nombre de producto debe tener un minimo de 3 caracteres"),
        body("stock")
            .notEmpty()
            .withMessage("Completar campo de stock"),
        body("cost")
            .isLength({min:""})
            .withMessage("Campo costo debe de estar completo"),
        body("markup")
            .withMessage("Campo markup debe estar completo"),
        body("discount")
               .notEmpty()
               .withMessage("Completar el campo de discount")
       
    ]*/



    
}

module.exports= validar;