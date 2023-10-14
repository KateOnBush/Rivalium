/// @description Insert description here
// You can write your code in this editor

alpha = dtlerp(alpha, isMessageOpen, 0.2);

draw_set_color(c_black);
draw_set_alpha(.5 * alpha);
draw_rectangle(0, 0, room_width, room_height, false);

draw_set_alpha(1);