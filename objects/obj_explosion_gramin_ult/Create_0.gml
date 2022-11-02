/// @description Insert description here
// You can write your code in this editor

trail = part_type_create();
part_type_shape(trail, pt_shape_smoke)
part_type_color3(trail, c_red, c_yellow, c_maroon)
part_type_alpha2(trail, 0.5, 0)
part_type_size(trail, 0.6, 0.4, 0, 0);
part_type_direction(trail, 0, 360, 0, 0);

screen_shake_position(200, 120, 0.4, x, y);

// Inherit the parent event
event_inherited();

