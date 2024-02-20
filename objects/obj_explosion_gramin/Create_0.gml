/// @description Insert description here
// You can write your code in this editor

impact = part_type_create();
part_type_sprite(impact, base_character_gramin_explosion_impact, false, false, true)
part_type_color3(impact, c_white, c_white, c_gray);
part_type_size(impact, 1, 4, -0.2, 0);
part_type_direction(impact, 0, 360, 0, 5);
part_type_speed(impact, 4, 9, -0.5, 0);
part_type_life(impact, 15, 20);
part_type_alpha3(impact, 1, 0.9, 0);

smoke = part_type_create();
part_type_sprite(smoke, base_character_gramin_ult_bullet_trail, false, false, true)
part_type_color3(smoke, c_red, c_white, c_white);
part_type_size(smoke, 4, 5, -0.15, 0);
part_type_direction(smoke, 0, 360, 0, 5);
part_type_speed(smoke, 5, 13, -0.25, 0);
part_type_life(smoke, 40, 30);
part_type_alpha3(smoke, 1, 0.5, 0);

rumble = part_type_create();
part_type_sprite(rumble, base_character_gramin_rumble, false, false, true);
part_type_size(rumble, 0.6, 0.8, -0.008, 0);
part_type_direction(rumble, 0, 180, 0, 0)
part_type_speed(rumble, 12, 15, 0, 0);
part_type_gravity(rumble, grav, -90);
part_type_life(rumble, 60, 60);
part_type_alpha3(rumble, 1, 1, 0);

screen_shake_position(1, 0.5, 0.2, x, y);

// Inherit the parent event
event_inherited();

