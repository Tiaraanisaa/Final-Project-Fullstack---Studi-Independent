const { product } = require('../models');

class ProductController {
  static getProducts(req, res) {
    product.findAll()
      .then(result => {
        res.json(result);
      })
      .catch(err => {
        res.json(err);
      });
  }

  static getProductById(req, res) {
    let id = +req.params.id;
    product.findByPk(id)
      .then(result => {
        if (result) {
          res.json(result);
        } else {
          res.status(404).json({
            message: "Product not found"
          });
        }
      })
      .catch(err => {
        res.json(err);
      });
  }

  static addProduct(req, res) {
    const { name, qty, categoryId, imageUrl, createdBy } = req.body;
    product.create({
      name, qty, categoryId, imageUrl, createdBy
    })
      .then(result => {
        res.json(result);
      })
      .catch(err => {
        res.json(err);
      });
  }

  static deleteProduct(req, res) {
    let id = +req.params.id;
    product.destroy({
      where: { id }
    })
      .then(result => {
        if (result === 1) {
          res.json({
            message: "Product has been deleted!"
          });
        } else {
          res.json({
            message: "Product failed to delete."
          });
        }
      })
      .catch(err => {
        res.json(err);
      });
  }

  static updateProduct(req, res) {
    let id = +req.params.id;
    const { name, qty, categoryId, imageUrl, createdBy } = req.body;
    product.update({
      name, qty, categoryId, imageUrl, createdBy
    }, {
      where: { id }
    })
      .then(result => {
        if (result[0] === 1) {
          res.json({
            message: "Successful product update!"
          });
        } else {
          res.json({
            message: "Product failed to update"
          });
        }
      })
      .catch(err => {
        res.json(err);
      });
  }
}

module.exports = ProductController;
