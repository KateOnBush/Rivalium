/// @description Insert description here
// You can write your code in this editor

event_inherited()

imangle = random(360);

trail = part_type_create();
part_type_shape(trail, pt_shape_line)
part_type_color2(trail, c_white, c_ltgray)
part_type_alpha2(trail, 0.5, 0)
part_type_size(trail, 0.05, 0.08, 0, 0);

on_collision = function(){

	screen_shake_position(50, 100, 0.25, x, y);
	if ownerID == global.playerid explosion_create_request(obj_explosion_gramin, x, y, 150, 20);

}
