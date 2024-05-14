/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (array_length(currentRequests) == 0) {

	draw_set_font(font_game);
	draw_set_color(c_white);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	draw_text_transformed(x + sprite_width/2, y + sprite_height/2, "No requests", 0.4, 0.4, 0);

}