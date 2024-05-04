/// @description Insert description here
// You can write your code in this editor

draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_font(mainFont);
draw_set_color(COLOR_DARK);
draw_set_alpha(1);

if (playerOwnCard.loadedCharacter) {

	draw_text_transformed(x, y, string_upper(playerOwnCard.char.name), 2, 2, 0);
	draw_set_alpha(0.8);
	draw_text_transformed(x, y + 38, playerOwnCard.char.desc, 0.75, 0.75, 0);

}



