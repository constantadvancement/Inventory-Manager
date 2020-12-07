'use strict'

// Configures the mysql database using sequelize

const fs = require('fs')
const path = require('path')
const Sequelize = require('sequelize')
const basename = path.basename(__filename)
const config = require('../config/config.developer')
const db = {}

const sequelize = new Sequelize(
    config.mysqlInfo.database, 
    config.mysqlInfo.username, 
    config.mysqlInfo.password, 
    config.mysqlInfo.options
);

// List all files in a directory in Node.js recursively in a synchronous fashion
function walkSync(dir, filelist) {
    let files = fs.readdirSync(dir);
    filelist = filelist || [];

    files.forEach(function(file) {
        if (fs.statSync(path.join(dir, file)).isDirectory()) {
            filelist = walkSync(path.join(dir, file), filelist);
        } else {
            filelist.push(path.join(dir, file));
        }
    });
    return filelist;
};
  
// load all the models by walking the models directory recursively
let models = []
walkSync(__dirname, models)

// for each of the files, import the model
models.forEach(file => {
    // if the file is not a JS file or looks like this file, don't process it
    if ((file.indexOf('.') === 0) || (file.includes(basename)) || (file.slice(-3) !== '.js')) return

    // let model = sequelize.import(file)
    let model = require(file) (sequelize, Sequelize.DataTypes)
    db[model.name] = model
})

Object.keys(db).forEach(modelName => {
    if(db[modelName].associate) {
        db[modelName].associate(db);
    }
});

db.sequelize = sequelize
db.Sequelize = Sequelize

module.exports = db