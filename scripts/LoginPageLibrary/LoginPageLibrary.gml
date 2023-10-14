#macro UsernameRequirementMessage "Username must be between 5 and 16 characters long, must include only characters, numbers, underscore and hyphen."
#macro EmailRequirementMessage "Doesn't seem like a correct email."
#macro PasswordRequirementMessage "Password must be between 8 and 30 characters long, must include at least one letter, number and special character."
#macro PasswordConfirmRequirementMessage "Passwords don't match, maybe a typo?"
#macro AcceptTOSRequirementMessage "You need to accept Terms of Service in order to create an account."

function checkLoginFormat() {
	
	var username = loginAccessInput.content;
	var password = loginPasswordInput.content;
	
	if string_length(username) < 5 or (string_length(username) > 16 && string_pos("@", username) == 0) {
		loginAccessInput.state = InputState.INCORRECT;
		loginAccessText.text = "Doesn't seem like a correct username/email.";
		loginAccessText.state = TextState.ERROR;
		return false;
	}
	
	if string_length(password) < 8 or string_length(password) > 30 {
		loginPasswordInput.state = InputState.INCORRECT;
		loginPasswordText.text = "You might have mistyped your password.";
		loginPasswordText.state = TextState.ERROR;
		return false;
	}
	
	return true;
	
}

function checkSignupFormat() {

	var username = signupUsernameInput.content,
		email = signupEmailInput.content,
		password = signupPasswordInput.content,
		passwordConfirm = signupPasswordConfirmInput.content,
		acceptedTOS = signupAcceptTOS.checked;
		
	if (!acceptedTOS) {
		signupText.text = AcceptTOSRequirementMessage;
		signupText.state = TextState.ERROR;
		return false;
	}
	
	if string_length(username) < 5 or string_length(username) > 16 {
		signupUsernameInput.state = InputState.INCORRECT;
		signupText.text = UsernameRequirementMessage;
		signupText.state = TextState.ERROR;
		return false;
	}
	
	if string_length(email) < 6 or string_pos("@", email) == 0 {
		signupEmailInput.state = InputState.INCORRECT;
		signupText.text = EmailRequirementMessage;
		signupText.state = TextState.ERROR;
		return false;
	}
	
	if string_length(password) < 8 or string_length(password) > 30 {
		signupPasswordInput.state = InputState.INCORRECT;
		signupText.text = PasswordRequirementMessage;
		signupText.state = TextState.ERROR;
		return false;
	}
	
	if password != passwordConfirm {
		signupPasswordConfirmInput.state = InputState.INCORRECT;
		signupText.text = PasswordConfirmRequirementMessage;
		signupText.state = TextState.ERROR;
		return false;
	}
	
	return true;

}

function loginTimeout() {

	loginButton.state = buttonState.ON;
	loginButton.text = "LOG IN";
	loginAccessText.state = TextState.NORMAL;
	loginAccessText.text = "Login timed out, please try again.";

}

function signupTimeout() {
	
	signupButton.state = buttonState.ON;
	signupButton.text = "SIGN UP";
	signupText.state = TextState.NORMAL;
	signupText.text = "Sign up timed out, please try again.";
	
}