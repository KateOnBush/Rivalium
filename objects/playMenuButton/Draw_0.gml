/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var d = 4;

if sprite_exists(image) {
	
	var iw = sprite_get_width(image),
		ih = sprite_get_height(image);
	var ww = sprite_width - 2*d,
		hh = sprite_height - 2*d;
		
	var ar = ww/hh;
	
	draw_sprite_part_ext(image, 0, 
	iw/2 - ar*ih/2, 0, ar*ih, ih, 
	x - ww/2, y - hh/2, 
	hh/ih, hh/ih, c_white, .9 - hoverBlend * .2);

}

draw_set_alpha(1);

draw_set_color(c_white)
draw_set_valign(fa_bottom)
draw_set_halign(fa_left)

draw_text_transformed(x - sprite_width/2 + 3 * d, y + sprite_height/2 - 2 * d, bigText, size * 0.7, size * 0.7, 0);