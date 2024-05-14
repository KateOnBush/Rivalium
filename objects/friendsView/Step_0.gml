/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var data = userdata_get_self();
var friendList = struct_get_key_failsafe(data, "friendManager.friendList") ?? [];

if array_length(friendList) != array_length(friends) {

	clear();
	
	friends = friendList;
	
	var currentY = y;

	for(var i = 0; i < array_length(friends); i++) {
	
		var s = object_get_sprite(friendsViewItem);
		var o = add(friendsViewItem, x, currentY);
		o.image_xscale = sprite_width/sprite_get_width(s);
		o.image_yscale = 64/sprite_get_height(s);
		o.userId = friends[i];
	
		currentY += 64 + 8;
	
	}

	maxY = currentY;

}