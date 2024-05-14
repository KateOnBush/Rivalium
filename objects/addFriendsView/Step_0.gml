/// @description Insert description here
// You can write your code in this editor

_angle += 20 * dtime;

// Inherit the parent event
event_inherited();

if array_length(currentResult) != array_length(result) {

	clear();
	
	currentResult = result;
	
	var currentY = y;

	for(var i = 0; i < array_length(currentResult); i++) {
	
		var thisItem = currentResult[i];
		if (!is_struct(thisItem)) thisItem = {};
	
		var s = object_get_sprite(friendSearchItem);
		var o = add(friendSearchItem, x, currentY);
		o.image_xscale = sprite_width/sprite_get_width(s);
		o.image_yscale = 48/sprite_get_height(s);
		o.userId = struct_get_key_failsafe(thisItem, "id");
		o.name = struct_get_key_failsafe(thisItem, "username");
	
		currentY += 48 + 8;
	
	}

	maxY = currentY;

}