/// @description Insert description here
// You can write your code in this editor

event_inherited();

draw_set_color(c_black)
draw_set_valign(fa_middle)
draw_set_halign(fa_left);

draw_set_font(mainFont)

draw_sprite(sprite_index, 0, x, y);
draw_sprite_ext(sprite_index, 1, x, y, 1, 1, 0, c_white, checkedBlend);

draw_set_alpha(0.5)
draw_text_transformed(x + sprite_width*1.2, y, text, 0.7, 0.7, 0);
draw_set_alpha(1)






