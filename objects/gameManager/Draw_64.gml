/// @description Insert description here
// You can write your code in this editor

var ww = display_get_gui_width(),
	hh = display_get_gui_height();

draw_set_color(c_white)
draw_set_valign(fa_bottom)
draw_set_halign(fa_left)
draw_set_alpha(.6);

var VERSION = GAMEVERSION.major + "."
			  + GAMEVERSION.minor + "."
			  + GAMEVERSION.build + "."
			  + GAMEVERSION.bugfix;

var STATUS = [
	"Disconnected",
	"Connecting",
	"Connected",
	"Error"
]

draw_set_font(font_game);
draw_text_transformed(4, hh - 4, $"Client Version: {VERSION} | Status: {STATUS[ClientStatus.connection]} | FPS: {fps}", 0.3, 0.3, 0);
draw_set_alpha(1);

draw_set_color(c_black)
draw_set_alpha(.8);
draw_rectangle(0, 0, ww-1, hh-1, true);
draw_set_alpha(1);

if backBlend > 0.01 {

	draw_set_font(font_game);
	draw_set_color(c_white);
	draw_set_valign(fa_middle)
	draw_set_halign(fa_center)
	draw_set_alpha(backBlend);
	var tw = string_width(displayMessage) * 0.5 + 16, th = string_height(displayMessage) + 16; 
	draw_sprite_stretched(fieldSpriteDark, 0, ww * 0.5 - tw/2, hh * 0.85 - th/2, tw, th);
	draw_set_alpha(backBlend * textBlend);
	draw_text_transformed(ww * 0.5, hh * 0.85, displayMessage, 0.5, 0.5, 0);

}
