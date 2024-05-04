/// @description Insert description here
// You can write your code in this editor

event_inherited();

if !noBox {
	draw_self();
	draw_sprite_ext(hoverButtonSprite, 0, x, y, image_xscale, image_yscale, 0, c_white, hoverBlend * .3);
	draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, 0, c_white, unavailableBlend);
}

draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_set_font(mainFont);

var spr = sprite_exists(icon) ? icon : loadingSymbol;
var tw = string_width(text);
var hei = string_height("0") * 0.75;
var s = (sprite_exists(icon) ? iconSize : 1) * hei/sprite_get_width(spr) * loadingBlend;
loadingDisplay = dtlerp(loadingDisplay, tw/2 - s, .1);
draw_sprite_ext(spr, 0, x - loadingDisplay, y, s * sign(image_xscale), s * sign(image_yscale), _angle, color, loadingBlend * alpha);

draw_set_alpha(textAlpha);
draw_set_color(color);
draw_text_transformed(x + displayTextX, y + displayTextY, displayText, size, size, 0);

draw_set_color(c_white);
draw_set_alpha(1);

