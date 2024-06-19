const User = require('../models/users'); 
const multer = require('multer');
const bcrypt = require('bcrypt');
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

const UserController = {
  register: async (req, res) => {
    try {
      const { username, password } = req.body;
      const image = req.file ? req.file.buffer : null; 

      const existingUser = await User.findOne({ where: { username } });
      if (existingUser) {
        return res.status(400).json({ message: 'Username already exists' });
      }

      const hashedPassword = await bcrypt.hash(password, 10)
      const newUser = await User.create({ username, password:hashedPassword, image });

      res.status(201).json({ message: 'User registered successfully', user: newUser });
    } catch (error) {
      console.error('Error in registering user:', error);
      res.status(500).json({ message: 'Internal server error' });
    }
  }
};

module.exports = {
  UserController,
  upload
};
