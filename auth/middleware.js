function ensureLoggedIn(req, res, next) {
	if (req.signedCookies.user_id) {
		next()
	} else {
		res.status(401)
		next(new Error('Un-Authorized You have to Login!'))
	}
}

function allowAccess(req, res, next) {
	if (req.signedCookies.user_id == req.params.id) {
		next()
	} else {
		res.status(401)
		next(new Error('Un-Authorized You do not have the right to access this page!'))
	}
}

function allowAdmins(req, res, next) {
	if(req.signedCookies.user_type == 'admin') {
				next()
	} else {
		res.status(401)
		next(new Error('Un-Authorized You do not have to be admin to access this page!'))
	}
}

module.exports = {
	ensureLoggedIn,
	allowAccess,
	allowAdmins
}