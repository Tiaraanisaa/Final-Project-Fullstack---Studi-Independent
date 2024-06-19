const { Sequelize, DataTypes } = require('sequelize');
const sequelize = require('../config/database'); 

const category = sequelize.define('category', {

  name: {
    type: DataTypes.STRING,
    allowNull: false
  }
});

module.exports = category;
