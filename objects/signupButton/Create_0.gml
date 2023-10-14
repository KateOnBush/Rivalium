/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

text = "SIGN UP"
state = buttonState.ON;

onClick = function() {
	
	signupText.text = "";
	signupText.state = TextState.NORMAL;

	if checkSignupFormat() account_server_send_message("client.signup", {
		username: signupUsernameInput.content,
		email: signupEmailInput.content,
		password: signupPasswordInput.content,
		passwordConfirm: signupPasswordConfirmInput.content,
		acceptedTOS: signupAcceptTOS.checked
	},, signupTimeout);
	else return;

	state = buttonState.LOADING;
	text = "SIGNING UP"
	
}

reset = function(){
	state = buttonState.ON;
	text = "SIGN UP"
}
