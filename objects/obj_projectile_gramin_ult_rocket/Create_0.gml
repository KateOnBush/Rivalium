/// @description Insert description here
// You can write your code in this editor

event_inherited()

trail = part_type_create();
part_type_sprite(trail, base_character_gramin_ult_bullet_trail, 0, 0, true)
part_type_color3(trail, #612622, c_white, c_white)
part_type_alpha3(trail, 1, 0.8, 0)
part_type_life(trail, 60, 120);
part_type_size(trail, 0.5, 0.6, 0.02, 0.001);
part_type_speed(trail, 0.14, 0.12, 0, 0);
part_type_direction(trail, 90, 90, 0, 0);

on_collision = function(){

	screen_shake_position(1, 0.2, 0.5, x, y);

}
