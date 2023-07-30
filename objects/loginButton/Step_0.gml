/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (ClientStatus.connection == ConnectionStatus.CONNECTING) {

	state = buttonState.LOADING;
	text = "CONNECTING"

} else if (ClientStatus.connection == ConnectionStatus.CONNECTED){
	
	if (ClientStatus.authentication == AuthenticationStatus.UNAUTHORIZED) {
	
		state = buttonState.LOADING;
		text = "UPDATING"
	
	} else {
		
		state = buttonState.ON;
		text = "LOGIN"
		
	}
	
} else {
	
	state = buttonState.UNAVAILABLE;
	text = "UNAVAILABLE"
	
}

