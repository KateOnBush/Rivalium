/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

text = global.loginSide ? "CREATE AN ACCOUNT" : "ALREADY HAVE AN ACCOUNT";

if loginButton.state != buttonState.ON or signupButton.state != buttonState.ON {
	state = buttonState.UNAVAILABLE;	
} else {
	state = buttonState.ON;	
}