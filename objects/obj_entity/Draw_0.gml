/// @description Insert description here
// You can write your code in this editor

if global.debugmode {
	
	draw_set_font(font_debug);
	
	draw_set_color(c_blue);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	
	draw_text(x, y - 48, "Entity ID: " + string(ID));
	
	draw_circle(x, y, 2, false);


}