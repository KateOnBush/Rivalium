/// @description Insert description here
// You can write your code in this editor

z = 0;
followUI = false;
viewParent = noone;

width = -1;
height = -1;

set_width = function(_width) {
	image_xscale = _width/sprite_get_width(sprite_index);
}

set_height = function(_height) {
	image_yscale = _height/sprite_get_width(sprite_index);
}