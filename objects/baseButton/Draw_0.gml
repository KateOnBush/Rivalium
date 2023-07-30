/// @description Insert description here
// You can write your code in this editor

draw_self();

draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, 0, c_white, unavailableBlend);

draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_set_font(mainFont);

var tw = string_width(text);
var hei = string_height("0") * 0.75;
var s = hei/sprite_get_width(loadingSymbol) * loadingBlend;
draw_sprite_ext(loadingSymbol, 0, x - tw/2 - s, y, s, s, _angle, c_white, loadingBlend);

draw_set_alpha(textAlpha);
draw_text(displayTextX, displayTextY, displayText);

draw_set_alpha(1);

