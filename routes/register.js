const express = require('express');
const router = express.Router();
const {UserController, upload} = require('../controllers/UserController');

router.post('/register', upload.single('image'), UserController.register);

module.exports = router;
