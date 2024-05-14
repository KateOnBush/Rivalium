/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if count > 0 {

	var xx = bbox_right - 4, yy = bbox_top + 4, s = 24;
	draw_set_alpha(0.8);
	draw_sprite_stretched_ext(HUD_DEF, 0, xx - s/2, yy - s/2, s, s, #a82916, 0.8);
	draw_set_color(c_white)
	draw_set_font(secondaryFont);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	draw_text_transformed(xx, yy, count, 0.4, 0.4, 0);

}

