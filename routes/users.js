var express = require('express');
var router = express.Router();
var authMiddleware = require('../auth/middleware');
const Users = require('../db/user')
const bcrypt = require('bcrypt-nodejs');

function isValidId(req, res, next) {
  if (!isNaN(req.params.id)) return next();
  next(new Error('Invalid ID'));
}

/* GET events page. */
router.get('/', function (req, res, next) {
  Users.getAllUsers().then(function (data) {
      res.render('allUsers', {
        title: "All Users",
        message: req.flash('success_messages'),
        
        jsonData: data
      })
    })
    .catch(function (err) {
      return next(err);
    });
});


/* GET create users page. */
router.get('/create', authMiddleware.ensureLoggedIn, function (req, res, next) {
  Users.getAllUsersTypes().then(function (data) {
    res.render('createUser', {
      title: 'Create an user!',      
      jsonData: data
    });
  })
});

/* POST create user page. */
router.post('/create', function (req, res, next) {
  Users.getOneByEmail(req.body.email).then(user => {
    //If user not found
    if (!user) {
      // This is unique email
      // Hash password
      var salt = bcrypt.genSaltSync(10);
      bcrypt.hash(req.body.password, salt, null, (err, hash) => {
        const user = {
          name: req.body.name,
          email: req.body.email,
          password: hash,
          type: req.body.type
        };
        // Insert The user in the DB
        Users.create(user).then(id => {
          req.flash('success_messages', 'You have created the user Successfully!')
          res.redirect('/users');
        }).catch(function (err) {
          return next(err);
        });
      })
    } else {
      req.flash('error_messages', 'Failed to create the user!')
      res.redirect('/users');
    }
  })
});

/* GET create users page. */
router.get('/edit/:id', isValidId, function (req, res, next) {
  Users.getOne(req.params.id).then(function (data) {
    Users.getAllUsersTypes().then(function (types) {
      res.render('editUser', {
        title: 'Edit an users!',       
        name: data.name,
        email: data.email,
        usertype: data.type,
        jsonData: types,
        id: data.id
      })
    }).catch(function (err) {
      return next(err);
    })
  }).catch(function (err) {
    return next(err);
  })
})

/* GET create users page. */
router.post('/edit/:id', isValidId, function (req, res, next) {
  Users.edit(req.params.id, req.body).then(function () {
    req.flash('success_messages', 'You have updated the users Successfully!')
    res.redirect('/users');
  }).catch(function (err) {
    return next(err);
  })
})


router.get('/delete/:id', isValidId, function (req, res, next) {
  console.log(req.params.id)
  Users.delete(req.params.id).then(() => {
    req.flash('success_messages', 'You have deleted the user Successfully!')
    res.redirect('/users');
  }).catch(function (err) {
    return next(err)
  })
})

module.exports = router;