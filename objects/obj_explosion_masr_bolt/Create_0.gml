/// @description Insert description here
// You can write your code in this editor

trail = part_type_create();
part_type_sprite(trail, base_character_masr_slash_part, false, false, true)
part_type_alpha2(trail, 0.8, 0.2)
part_type_speed(trail, 24, 25, 0.01, 0);
part_type_size(trail, 0.1, 1.4, 0, 0);
part_type_direction(trail, 0, 360, 0, 5);
part_type_orientation(trail, 0, 360, 0, 0, true);
part_type_life(trail, 10, 10);

trail2 = part_type_create();
part_type_shape(trail2, pt_shape_flare)
part_type_size(trail2, 15, 20, 1, 0);
part_type_color2(trail2, #deeaff, #deeaff)
part_type_alpha2(trail2, 0.8, 0)
part_type_life(trail2, 5, 5);

screen_shake_position(0.4, 0.3, 0.2, x, y);

// Inherit the parent event
event_inherited();

