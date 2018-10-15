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
					localStorage.setItem('user_id',result.id) 
					window.location = `/users/${result.id}`
				}).catch(error => {
					const $errorMessage = $('#errorMessage')
					$errorMessage.text(error.responseJSON.message)
					$errorMessage.show()
				})
		} else {
			//user.type = "user"
			signup(user)
				.then(result => {
					localStorage.setItem('user_id',result.id) 
					window.location = `/users/${result.id}`
				}).catch(error => {
					const $errorMessage = $('#errorMessage')
					$errorMessage.text(error.responseJSON.message)
					$errorMessage.show()
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