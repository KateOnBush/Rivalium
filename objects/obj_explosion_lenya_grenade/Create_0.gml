/// @description Insert description here
// You can write your code in this editor

smoke = part_type_create();
part_type_sprite(smoke, base_character_lenya_explosion_smoke, false, false, true)
part_type_size(smoke, 4, 5, -0.2, 0);
part_type_direction(smoke, 0, 360, 0, 5);
part_type_speed(smoke, 5, 13, -0.25, 0);
part_type_life(smoke, 60, 70);
part_type_alpha3(smoke, 0.2, 0.05, 0);

rumble = part_type_create();
part_type_sprite(rumble, base_character_lenya_explosion_rumble, false, false, true);
part_type_size(rumble, 1.3, 1.5, -0.03, 0);
part_type_direction(rumble, 0, 180, 0, 0)
part_type_speed(rumble, 3, 15, 0, 0);
part_type_gravity(rumble, grav, -90);
part_type_life(rumble, 80, 80);
part_type_alpha3(rumble, 1, 1, 0);

flare = part_type_create();
part_type_shape(flare, pt_shape_flare);
part_type_color1(flare, #da7dff)
part_type_size(flare, 20, 20, 4, 0);
part_type_life(flare, 5, 8);
part_type_alpha2(flare, 0.5, 0);

screen_shake_position(0.5, 0.2, 0.2, x, y);

// Inherit the parent event
event_inherited();

