$(() => {
	$('form').submit((event) => {
		event.preventDefault()
		var formType = event.target.id
		const name = $('#name').val()
		const email = $('#email').val()
		const password = $('#password').val()

		const user = {
			name,
			email,
			password
		}

		if (formType == 'login') {
			login(user)
				.then(result => {
					setLocalStorage(result.user)
				}).catch(error => {
					displayErrorMessage(error)
				})
		} else {
			signup(user)
				.then(result => {
					setLocalStorage(result.user)
				}).catch(error => {
					displayErrorMessage(error)
				})
		}

	})	
})


function login(user) {
	return $.post('/auth/login', user)
}

function signup(user) {
	return $.post('/auth/signup', user)
}

function setLocalStorage(user) {
	sessionStorage.setItem('user_id', user.id)
	sessionStorage.setItem('user_name', user.name)
	sessionStorage.setItem('user_type', user.type)
	if (user.type == 'admin') {
		window.location = `/buildings`
	} else {
		window.location = `/users/${user.id}`
	}
}

function displayErrorMessage(error) {
	const $errorMessage = $('#errorMessage')
	$errorMessage.text(error.responseJSON.message)
	$errorMessage.show()
}