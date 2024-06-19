require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser'); 
const app = express();
const port = 3000;
const { UserController, upload } = require('./controllers/UserController');
const AuthController = require('./controllers/AuthController');
const sequelize = require('./config/database'); 
const cors = require('cors');
const bcrypt = require('bcrypt');
const User = require('./models/users');
const registerRouter = require('./routes/register');
const loginRouter = require('./routes/login');
const categoryRoute = require('./routes/category')
const productRoute = require('./routes/product')

const routes = require('./routes');
app.use(routes);

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.use(bodyParser.json());
app.use('/uploads', express.static('uploads'));


// endpoint 
app.post('/api/register', upload.single('image'), UserController.register);
app.post('/api/login', async (req, res) => {
  const { username, password } = req.body;
  try {
    const user = await User.findOne({ where: { username} });
    if (user && await bcrypt.compare(password, user.password)) {
      // jika data login valid
      res.status(200).json({ message: 'Login successful'});
    } else {
      // jika data login tidak valid
      res.status(400).json({ message: 'Invalid credentials'});
    }
  } catch (error) {
    console.error('Error during login:', error);
    res.status(500).json({ message: 'Internal server error'});
  }
});


// menggunakan routes
app.use('/api', registerRouter);
app.use('/api', loginRouter);
app.use('/categories', categoryRoute);
app.use('/products', productRoute);


// sinkronisasi database dan memulai server
sequelize.sync({ force: false })
  .then(() => {
    console.log('Database & tables created!');
    app.listen(port, () => {
      console.log(`Server running on http://192.168.107.239:${port}`);
    });
  })
  .catch(err => {
    console.error('Unable to connect to the database:', err);
  });
