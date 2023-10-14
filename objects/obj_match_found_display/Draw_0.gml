/// @description Insert description here
// You can write your code in this editor

var ww = 1280, hh = 720;;

draw_set_color(COLOR_DARK);
draw_set_alpha(.6 * al);
draw_rectangle(0, hh * 0.3, ww, hh * 0.7, false);


draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(COLOR_RED);
draw_set_alpha(1 * power(al, 1/4));
draw_text_transformed(disp1, hh * 0.45, "FOUND MATCH", 4, 4, 0);
draw_text_transformed(disp2, hh * 0.6, "JOINING IN " + string(ceil((1 - progress) * 3)) + "...", 2, 2, 0);