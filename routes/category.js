const categoryRoute = require('express').Router();
const CategoryControler = require('../controllers/CategoryController')

categoryRoute.get('/', CategoryControler.getCategories)

module.exports = categoryRoute
