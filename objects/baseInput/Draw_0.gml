/// @description Insert description here
// You can write your code in this editor

var phOffset = placeholder == "" ? 0 : 2;

var drawX = x + finalXOff;

draw_sprite_ext(sprite_index, 0, drawX, y, image_xscale, image_yscale, 0, c_white, 1);
draw_sprite_ext(sprite_index, 1, drawX, y, image_xscale, image_yscale, 0, c_white, selectedBlend);
draw_sprite_ext(sprite_index, 2, drawX, y, image_xscale, image_yscale, 0, c_white, correctBlend);
draw_sprite_ext(sprite_index, 3, drawX, y, image_xscale, image_yscale, 0, c_white, incorrectBlend);

if (!surface_exists(displaySurface)) {
	displaySurface = surface_create(ww * definitionScale, hh * definitionScale);
}

surface_set_target(displaySurface);

draw_clear_alpha(c_white, 0);

draw_set_font(secondaryFont);
draw_set_alpha(1);
draw_set_valign(fa_center);
draw_set_halign(fa_left);
draw_set_color(c_black);

if (cursorCooldown < cursorInterval && selected) {
	var dist = (string_width(string_copy(displayText, 1, cursorPosition)) - string_width("|")/2) * totalSize;
	draw_text_transformed(definitionScale * (dist - textOffset), definitionScale * (hh/2 + phOffset),
	"|", definitionScale, definitionScale, 0)
}
draw_text_transformed(- textOffset * definitionScale, definitionScale * (hh/2 + phOffset), displayText, definitionScale * totalSize, definitionScale * totalSize, 0);

//placeholder
var phy = lerp(hh/2, phOffset, placeholderBlend) * definitionScale;
var phsize = lerp(totalSize, totalSize * 0.4, placeholderBlend) * definitionScale;
var phalph = .8;

draw_set_alpha(phalph);
if (string_length(placeholder) > 0) draw_text_transformed(0, phy, placeholder, phsize, phsize, 0);
draw_set_alpha(1);

if (hasSelection) {
	draw_set_color(c_grey)
	draw_set_alpha(0.8);
	var startX = - textOffset + string_width(string_copy(displayText, 1, selectionStart)) * totalSize,
		endX = - textOffset + string_width(string_copy(displayText, 1, selectionEnd)) * totalSize;
	draw_rectangle(startX * definitionScale, 0, endX * definitionScale, hh * definitionScale, false);
	draw_set_alpha(1);
}

surface_reset_target();

draw_surface_ext(displaySurface, drawX - ww/2, y - hh/2, 1/definitionScale, 1/definitionScale, 0, c_white, .6);
