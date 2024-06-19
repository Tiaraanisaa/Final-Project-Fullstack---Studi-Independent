const { category } = require('../models');

console.log(' category model:', category);

class CategoryController {
  static getCategories(req, res){
    category.findAll()
    .then(categories => {
      res.json(categories)
    })
    .catch(err => {
      res.json(err)
    })
  }


}

module.exports = CategoryController;
