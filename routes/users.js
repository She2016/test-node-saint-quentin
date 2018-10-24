var express = require('express');
var router = express.Router();
const User = require('../db/user');

const authMiddleware = require('../auth/middleware')

router.get('/', (req, res) => {
  res.render('maping', {
    title: "All Users"
  })
});

router.get('/create', (req, res) => {
  res.render('creating', {
    title: "All Users"
  })
});

router.get('/all', authMiddleware.allowAdmins, (req, res) => {
  User.getAllUsers().then(users => {
    if (users) {
      res.render('all_users', {
        title: "All Users",
        jsonData: users
      })
    } else {
      res.Error(res, 404, "User Not Found");
    }
  });
});



router.get('/:id', authMiddleware.ensureLoggedIn, (req, res) => {
  if (!isNaN(req.params.id)) {
    User.getOne(req.params.id).then(user => {
      if (user) {
        delete user.password;
        //res.json(user);
        res.render('users', {
          title: "One User",
          jsonData: JSON.stringify(user)
        })
      } else {
        res.Error(res, 404, "User Not Found");
      }
    });
  } else {
    res.Error(res, 500, "Invalid ID");
  }
});


module.exports = router;