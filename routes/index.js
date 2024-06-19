const route = require('express').Router()

route.get('/', (req, res) => {
    res.send('Welcome!')
  })


module.exports = route
