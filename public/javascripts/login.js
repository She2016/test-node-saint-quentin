//Submit login or registration form using AJAX
//Store a user information in the sessionStorage
//Display Error messages if exists

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
		// If the submitted form is login
		if (formType == 'login') {
			login(user)
				.then(result => {
					setLocalStorage(result.user)
				}).catch(error => {
					displayErrorMessage(error)
				})
		} else {
			// If the submitted form is signup
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
	return $.post('/auth/login', user) // send a post AJAX request to the server with a user info
}

function signup(user) {
	return $.post('/auth/signup', user) // send a post AJAX request to the server with a user info
}

function setLocalStorage(user) { // Set session variables
	sessionStorage.setItem('user_id', user.id)
	sessionStorage.setItem('user_name', user.name)
	sessionStorage.setItem('user_type', user.type)
	if (user.type == 'admin') {
		window.location = `/buildings`
	} else {
		window.location = `/`
	}
}

//Displaying error messages
function displayErrorMessage(error) {
	const $errorMessage = $('#errorMessage')
	$errorMessage.text(error.responseJSON.message)
	$errorMessage.show()
}

