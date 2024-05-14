/// @description Insert description here
// You can write your code in this editor

_angle+=10 * dtime;

loaded = userdata_other_loaded(userId);
if loaded {
	user = userdata_other_get(userId);	
	name = struct_get_key_failsafe(user, "username") ?? "----";
	online =  struct_get_key_failsafe(user, "connected") ?? false;
}

var offset = 8;

if !instance_exists(acceptButton) {
	var button_w = sprite_width * 0.25, button_h = (sprite_height - 3 * offset)/2; 
	acceptButton = viewParent.add(acceptFriendButton, 
	x + sprite_width - offset - button_w/2, 
	y + offset + button_h/2);
	acceptButton.set_width(button_w);
	acceptButton.set_height(button_h);
	acceptButton.userId = userId;
}

if !instance_exists(declineButton) {
	var button_w = sprite_width * 0.25, button_h = (sprite_height - 3 * offset)/2; 
	declineButton = viewParent.add(declineFriendButton, 
	x + sprite_width - offset - button_w/2, 
	y + 2 * offset + button_h* 3/2);
	declineButton.set_width(button_w);
	declineButton.set_height(button_h);
	declineButton.userId = userId;
}