var express = require('express');
var router = express.Router();
const User = require('../db/user');

const authMiddleware = require('../auth/middleware')

router.get('/:id', (req, res) => {
  if (!isNaN(req.params.id)) {
    User.getOne(req.params.id).then(user => {
      if (user) {
        delete user.password;
        //res.json(user);
        res.render('users', {
          title: "All Users",
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
