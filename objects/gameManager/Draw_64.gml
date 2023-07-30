/// @description Insert description here
// You can write your code in this editor

var ww = display_get_gui_width(),
	hh = display_get_gui_height();

draw_set_color(c_black)
draw_set_valign(fa_bottom)
draw_set_halign(fa_left)
draw_set_alpha(.8)

var VERSION = GAMEVERSION.major + "."
			  + GAMEVERSION.minor + "."
			  + GAMEVERSION.build + "."
			  + GAMEVERSION.bugfix;

var STATUS = [
	"Disconnected from server",
	"Connecting to server",
	"Connected to server",
	"Error occured"
]

draw_set_font(secondaryFont);
draw_text_transformed(8, hh - 8, $"Client Version: {VERSION} | Status: {STATUS[ClientStatus.connection]}", 0.6, 0.6, 0);
draw_set_alpha(1);





