/// @description Insert description here
// You can write your code in this editor

draw_self();
draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, 0, c_white, selectedBlend);
draw_sprite_ext(sprite_index, 2, x, y, image_xscale, image_yscale, 0, c_white, correctBlend);
draw_sprite_ext(sprite_index, 3, x, y, image_xscale, image_yscale, 0, c_white, incorrectBlend);

if (!surface_exists(displaySurface)) {
	displaySurface = surface_create(ww * definitionScale, hh * definitionScale);
}

surface_set_target(displaySurface);

draw_clear_alpha(c_white, 0);

draw_set_font(mainFont);
draw_set_alpha(1);
draw_set_valign(fa_center);
draw_set_halign(fa_left);
draw_set_color(c_black);

if (cursorCooldown < cursorInterval && selected) {
	var dist = (string_width(string_copy(displayText, 1, cursorPosition)) - string_width("|")/2) * totalSize;
	draw_text_transformed(definitionScale * (dist + textOffset), definitionScale * hh/2,
	"|", definitionScale, definitionScale, 0)
}
draw_text_transformed(0, definitionScale * hh/2, displayText, definitionScale * totalSize, definitionScale * totalSize, 0);

if (hasSelection) {
	draw_set_color(c_grey)
	draw_set_alpha(0.8);
	var startX = textOffset + string_width(string_copy(displayText, 1, selectionStart)) * totalSize,
		endX = textOffset + string_width(string_copy(displayText, 1, selectionEnd)) * totalSize;
	draw_rectangle(startX * definitionScale, 0, endX * definitionScale, hh * definitionScale, false);
	draw_set_alpha(1);
}

surface_reset_target();

draw_surface_ext(displaySurface, x - ww/2, y - hh/2, 1/definitionScale, 1/definitionScale, 0, c_white, .6);
