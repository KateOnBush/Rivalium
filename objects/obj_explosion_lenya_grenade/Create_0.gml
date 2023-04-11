/// @description Insert description here
// You can write your code in this editor

trail = part_type_create();
part_type_shape(trail, pt_shape_snow)
part_type_color2(trail, #950aab, #f2b0ff)
part_type_alpha2(trail, 0.8, 0)

screen_shake_position(100, 100, 0.2, x, y);

// Inherit the parent event
event_inherited();

