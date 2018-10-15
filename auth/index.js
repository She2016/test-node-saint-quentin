const express = require('express');
const bcrypt = require('bcrypt-nodejs');
const router = express.Router();
const User = require('../db/user');

router.get('/', (req, res) => {
	res.json({
		message: 'Lock'
	})
})

function validUser(user) {

	const validName = typeof user.name == 'string' &&
		user.name.trim() != '';
	const validEmail = typeof user.email == 'string' &&
		user.email.trim() != '';
	const validPassword = typeof user.password == 'string' &&
		user.password.trim() != '' &&
		user.password.trim().length >= 6

	return validName && validEmail && validPassword
}

router.post('/signup', (req, res, next) => {
	if (validUser(req.body)) {
		User
			.getOneByEmail(req.body.email)
			.then(user => {
				console.log('user', user);
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
							type: 'user'
						};
						// Insert The user in the DB
						User
							.create(user).then(id => {
								const isSecure = req.app.get('env') != 'development'
								res.cookie('user_id', user.id, {
									httpOnly: true,
									signed: true,
									secure: isSecure
								})
								res.json({
									id,
									message: 'it works'
								})
							})
					})
				} else {
					next(new Error('This email in use'))
				}
			})
	} else {
		next(new Error('Invalid user'))
	}

})

router.post('/login', (req, res, next) => {
	if (validUser(req.body)) {
		// Check to see if user in DB
		User
			.getOneByEmail(req.body.email)
			.then(user => {
				if (user) {
					//Compare password with hash password
					bcrypt.compare(req.body.password, user.password, function (err, result) {
						// If the passwords match
						if (result) {
							// Setting the 'set_cookie' header
							const isSecure = req.app.get('env') != 'development'
							res.cookie('user_id', user.id, {
								httpOnly: true,
								signed: true,
								secure: isSecure
							})
							res.json({
								id: user.id,
								message: 'Logged in!'
							})
						} else {
							next(new Error('Invalid Password'))
						}
					});
				} else {
					next(new Error('Invalid login'))
				}
			})
	} else {
		next(new Error('Invalid Syntax'))
	}
})

router.get('/logout', (req, res) => {
	res.clearCookie('user_id')
	res.json({
		message: 'Logged out'
	})
})
module.exports = router