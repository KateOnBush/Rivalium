/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

global.loginSide = true;

text = "CREATE AN ACCOUNT"
state = buttonState.ON;

onClick = function() {

	global.loginSide = 1 - global.loginSide;

}

