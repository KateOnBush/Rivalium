/// @description Insert description here
// You can write your code in this editor

event_inherited()

trail = part_type_create();
part_type_shape(trail, pt_shape_line)
part_type_color2(trail, c_orange, c_red)
part_type_alpha2(trail, 0.5, 0)
part_type_size(trail, 0.05, 0.05, 0, 0);

on_collision = function(){

	screen_shake_position(5, 100, 0.05, x, y);

}
