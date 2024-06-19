const productRoute = require('express').Router();
const ProductControler = require('../controllers/ProductController')

productRoute.get('/', ProductControler.getProducts);
productRoute.get('/:id', ProductControler.getProductById); 
productRoute.post('/', ProductControler.addProduct);
productRoute.delete('/:id', ProductControler.deleteProduct);
productRoute.put('/:id', ProductControler.updateProduct);

module.exports = productRoute
