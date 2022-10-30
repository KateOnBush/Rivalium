/// @description Insert description here
// You can write your code in this editor

event_inherited()

trail = part_type_create();
part_type_shape(trail, pt_shape_line)
part_type_color3(trail, c_orange, c_red, c_yellow)
part_type_alpha3(trail, 0.6, 0.4, 0)

on_collision = function(){

	screen_shake_position(5, 100, 0.05, x, y);

}
