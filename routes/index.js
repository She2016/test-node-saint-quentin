var express = require('express');
var router = express.Router();

router.get('/', (req, res, next) => {
  res.render('index', {
    title: "Home"
  })
})

router.get('/dynamic', (req, res, next) => {
  res.render('dynamic', {
    title: "Dynamic data"
  })
});

router.get('/model', (req, res, next) => {
  res.render('model', {
    title: "3D Model"
  })
});





module.exports = router;