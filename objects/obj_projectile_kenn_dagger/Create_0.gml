/// @description Insert description here
// You can write your code in this editor

event_inherited()

trail = part_type_create();
part_type_sprite(trail, base_character_kenn_dagger_trail, 0, 0, 1);
part_type_color2(trail, c_white, #cccccc);
part_type_life(trail, 15, 15)
part_type_alpha2(trail, 0.9, 0)
part_type_size(trail, 2, 1.2, 0, 0);

on_collision = function(){

	screen_shake_position(0.1, 1, 0.05, x, y);

}
