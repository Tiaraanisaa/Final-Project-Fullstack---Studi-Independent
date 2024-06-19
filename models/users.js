'use strict';
const { Model, DataTypes } = require('sequelize');
const sequelize = require('../config/database'); 
 
class User extends Model {
  static associate(models) {
    // define association here
  }
}

User.init({
  username: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false
  },
  image: {
    type: DataTypes.BLOB,
    allowNull: true
  }
}, {
  sequelize,
  modelName: 'User',
});

module.exports = User;
