/// @description Insert description here
// You can write your code in this editor

event_inherited()

trail = part_type_create();
part_type_shape(trail, pt_shape_smoke)
part_type_color2(trail, #1f1f1f, c_black)
part_type_alpha2(trail, 0.5, 0)
part_type_size(trail, 0.1, 0.25, 0, 0);

bleedpart = part_type_create();
part_type_shape(bleedpart, pt_shape_flare);
part_type_color2(bleedpart, #d10000, #9c5611);
part_type_direction(bleedpart, 0, 359, 0, 0);
part_type_alpha2(bleedpart, 0.3, 0.1);
part_type_size(bleedpart, 0.1, 0.15, 0, 0);

spark = part_type_create();
part_type_sprite(spark, fire_particle, false, false, true);
part_type_color2(spark, #990303, #990303);
part_type_alpha2(spark, 0.1, 0);
part_type_size(spark, 1.2, 1.4, 0, 0);

on_collision = function(){

	screen_shake_position(50, 100, 0.05, x, y);

}
