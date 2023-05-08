/// @description Insert description here
// You can write your code in this editor

depth = -5;

wind1 = part_type_create();
part_type_shape(wind1, pt_shape_cloud);
part_type_size(wind1, 0.02, 0.1, 0.002, 0);
part_type_scale(wind1, 13, 1.2);
part_type_alpha3(wind1, 0.3, .6, 0);
part_type_speed(wind1, 10, 14, .01, 0);
part_type_life(wind1, 35, 35)
part_type_orientation(wind1, 0, 0, 0, 0, true);

wind2 = part_type_create();
part_type_shape(wind2, pt_shape_cloud);
part_type_size(wind2, 0.02, 0.1, 0.002, 0);
part_type_scale(wind2, 13, 1.2);
part_type_alpha3(wind2, 0.3, .6, 0);
part_type_speed(wind2, 10, 14, .01, 0);
part_type_orientation(wind2, 0, 0, 0, 0, true);
part_type_life(wind2, 35, 35)

trail = part_type_create();
part_type_sprite(trail, base_character_masr_slash_part, false, false, true);
part_type_alpha3(trail, .8, 0.6, 0)
part_type_size(trail, .01, .65, 0, 0)
part_type_life(trail, 30, 30)
part_type_orientation(trail, 0, 360, 0, 0, 0);


wallobj = entity_create_solid_component(x, y, self);

event_inherited()