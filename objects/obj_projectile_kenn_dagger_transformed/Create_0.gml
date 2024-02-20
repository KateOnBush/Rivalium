/// @description Insert description here
// You can write your code in this editor

event_inherited()

trail = part_type_create();
part_type_sprite(trail, base_character_kenn_dagger_trail_transformed, 0, 0, 1);
part_type_color2(trail, c_white, #cccccc);
part_type_life(trail, 15, 15)
part_type_alpha2(trail, 0.5, 0.1)
part_type_size(trail, 2, 1.2, 0, 0);

spark = part_type_create();
part_type_sprite(spark, fire_particle, false, false, true);
part_type_color2(spark, #990303, #990303);
part_type_life(spark, 60, 60);
part_type_gravity(spark, 0.1, 90);
part_type_alpha2(spark, 0.8, 0.1);
part_type_size(spark, 1.2, 1.4, 0, 0);

on_collision = function(){

	screen_shake_position(0.1, 1, 0.05, x, y);

}
