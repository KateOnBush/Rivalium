/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

text = "CONNECTING"
state = buttonState.LOADING;

onClick = function() {

	loginAccessText.state = TextState.NORMAL;
	loginAccessText.state = TextState.NORMAL;
	loginAccessText.text = "";
	loginPasswordText.text = "";

	if checkLoginFormat() account_server_send_message("client.login", {
		access: loginAccessInput.content,
		password: loginPasswordInput.content,
		autologin: loginStayLoggedIn.checked
	} ,, loginTimeout);
	else return;

	state = buttonState.LOADING;
	text =  "LOGGING IN";

} 

reset = function(){
	state = buttonState.ON;
	text = "LOG IN"
}
