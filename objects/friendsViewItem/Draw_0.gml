/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_white)
draw_set_valign(fa_middle);
draw_set_halign(fa_left);
draw_set_alpha(1);
draw_set_font(font_game);
draw_sprite_stretched(fieldSprite, 0, x, y, sprite_width, sprite_height);
var offset = 12, border_size = sprite_height - 2 * offset;
draw_text_transformed(x + border_size + 2 * offset, y + sprite_height/2 - 8, loaded ? name : "", 0.42, 0.42, 0);
draw_set_font(secondaryFont);
draw_set_color(loaded and online ? #36ff4d : #a6a6a6);
draw_set_alpha(0.5)
draw_text_transformed(x + border_size + 2 * offset, y + sprite_height/2 + 10, loaded and online ? "ONLINE" : "OFFLINE", 0.32, 0.32, 0);

if loaded {
	
	var icon = struct_get_key_failsafe(user, "wardrobe.selectedIcon") ?? 0;
	draw_sprite_stretched(IconList[icon], 0, x + offset, y + offset, border_size, border_size);
	draw_sprite_stretched(defaultIconBorder, 0, x + offset, y + offset, border_size, border_size);

} else {

	draw_sprite_stretched(defaultIconBorder, 0, x + offset, y + offset, border_size, border_size);
	draw_sprite_ext(loadingSymbol, 0, x + offset + border_size/2, y + offset + border_size/2, 0.3, 0.3, _angle, c_white, 1);

}