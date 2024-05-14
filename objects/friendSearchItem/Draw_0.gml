/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_white)
draw_set_valign(fa_middle);
draw_set_halign(fa_left);
draw_set_alpha(1);
draw_set_font(font_game);
draw_sprite_stretched(fieldSprite, 0, x, y, sprite_width, sprite_height);
var offset = 12;
draw_text_transformed(x + offset, y + sprite_height/2, name, 0.4, 0.4, 0);