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

router.get('/management', (req, res, next) => {
  res.render('management', {
    title: "Manage des halls"
  })
});

router.get('/schedule', (req, res, next) => {
  res.render('schedule', {
    title: "Schedule"
  })
});



module.exports = router;