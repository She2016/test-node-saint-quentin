var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var session = require('express-session');
var flash = require('connect-flash');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var buildingsRouter = require('./routes/buildings');
var auth = require('./auth');
var authMiddleware = require('./auth/middleware');

var app = express();

// view engine setup
app.set('views', [path.join(__dirname, 'views'), 
                  path.join(__dirname, 'views/buildings'), 
                  path.join(__dirname, 'views/users')]);
app.set('view engine', 'pug');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser('keyboard_cat'));
app.use(session({
  secret: 'djhxcvxfgshajfgjhgsjhfgsakjeauytsdfy',
  resave: false,
  saveUninitialized: true,
  cookie: { maxAge: 60000 }
  }));
app.use(flash());
app.use(express.static(path.join(__dirname, 'public')));

// send errors to page if any.
app.use(function(req, res, next){
  res.locals.success_messages = req.flash('success_messages');
  res.locals.error_messages = req.flash('error_messages');
  next();
});

app.use('/auth', auth);
app.use('/', indexRouter); // localhost:3000 --> All users have access
app.use('/users', authMiddleware.ensureLoggedIn, usersRouter); // localhost:3000/users --> just logged in users have access
app.use('/buildings', authMiddleware.allowAdmins, buildingsRouter); // localhost:3000/buildings --> just admins have access

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function (err, req, res, next) {
    res.status(err.code || 500)
    res.json({
        message: err.message,
        error: req.app.get('env') === 'development' ? err : {}
      });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function (err, req, res, next) {
  res.status(err.code || 500)
  res.json({
      message: err.message,
      error: req.app.get('env') === 'development' ? err : {}
    });
});

module.exports = app;
