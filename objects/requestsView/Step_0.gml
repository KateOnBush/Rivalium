/// @description Insert description here
// You can write your code in this editor

_angle += 20 * dtime;

// Inherit the parent event
event_inherited();

requests = struct_get_key_failsafe(userdata_get_self(), "friendManager.receivedFriendRequests") ?? [];

if array_length(currentRequests) != array_length(requests) {

	clear();
	
	currentRequests = requests;
	
	var currentY = y;

	for(var i = 0; i < array_length(currentRequests); i++) {
	
		var s = object_get_sprite(requestsFriendItem);
		var o = add(requestsFriendItem, x, currentY);
		o.image_xscale = sprite_width/sprite_get_width(s);
		o.image_yscale = 48/sprite_get_height(s);
		o.userId = currentRequests[i];
	
		currentY += 48 + 8;
	
	}

	maxY = currentY;

}