/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var data = userdata_get_self();

var sentReqs = struct_get_key_failsafe(data, "friendManager.sentFriendRequests") ?? [];

var added = array_contains(sentReqs, userId);

if loading {

	state = buttonState.LOADING;
	text = "ADDING"

} else if added {

	state = buttonState.UNAVAILABLE;
	text = "SENT"

} else {

	state = buttonState.ON;
	text = "ADD"

}