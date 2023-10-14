/// @description Insert description here
// You can write your code in this editor

var ww = display_get_gui_width(),
	hh = display_get_gui_height();

draw_set_color(c_black)
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

draw_set_font(secondaryFont);
draw_text_transformed(4, hh - 4, $"Client Version: {VERSION} | Status: {STATUS[ClientStatus.connection]} | FPS: {fps}", 0.4, 0.4, 0);
draw_set_alpha(1);

draw_set_color(c_black)
draw_set_alpha(.8);
draw_rectangle(0, 0, ww-1, hh-1, true);
draw_set_alpha(1);
