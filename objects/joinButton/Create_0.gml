/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

text = "PLAY"
size = 1.05;
onClick = function(){

	if !inQueue queue_kinded_message("playMatch");
	else {
		text = "LEAVING QUEUE"
		state = buttonState.LOADING;
		account_server_send_message("party.leave.queue", {}, function(){
			inQueue = false;
			reset();
	}, function() {
		queue_normal_message("Unable to leave queue. Please try again.", "OK", false);
	})
	}

}

localInQueue = false;

reset = function() {
	text = inQueue ? "LEAVE QUEUE" : "PLAY";
	state = buttonState.ON;
}

inQueue = false;