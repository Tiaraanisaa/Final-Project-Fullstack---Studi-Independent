const { Sequelize, DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const product = sequelize.define('product', {
  name: {
    type: DataTypes.STRING,
    allowNull: false
  },
  qty: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  categoryId: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  imageUrl: {
    type: DataTypes.STRING,
    allowNull: true
  },
  createdBy: {
    type: DataTypes.STRING,
    allowNull: false
  }
});

module.exports = product;
