module.exports= function(sequelize, DataTypes){
    let alias="Color";
    let cols={
        name: DataTypes.STRING    
    };
    let config={
        timestamps:false,
    }
    let Color=sequelize.define(alias, cols, config);
    
    return Color;
}