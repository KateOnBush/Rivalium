/// @description Insert description here
// You can write your code in this editor

var offset = 8;

if !instance_exists(addButton) {
	var button_w = sprite_width * 0.25, button_h = (sprite_height - 4 * offset);
	addButton = viewParent.add(addSearchedUserButton, 
	x + sprite_width - offset - button_w/2, 
	y + sprite_height/2);
	addButton.set_width(button_w);
	addButton.set_height(button_h);
	addButton.userId = userId;
}