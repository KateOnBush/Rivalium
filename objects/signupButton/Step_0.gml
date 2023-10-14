/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();


if (ClientStatus.connection == ConnectionStatus.DISCONNECTED) 
|| (ClientStatus.connection == ConnectionStatus.ERROR) {
	
	state = buttonState.UNAVAILABLE;
	text = "UNAVAILABLE"
	
}