event_inherited();

radius = 0;

shot = part_type_create();
part_type_sprite(shot, base_character_lenya_ult_shot_particle, false, false, true);
part_type_alpha2(shot, 0.4, 0);
part_type_direction(shot, 0, 360, 0, 0);
part_type_orientation(shot, 0, 0, 0, 0, true);
part_type_speed(shot, 3, 15, 0, 0);
part_type_size(shot, 1, 2, -0.01, 0);
part_type_life(shot, 150, 210);

border = part_type_create();
part_type_sprite(border, base_character_lenya_ult_flare, false, false, true);
part_type_direction(border, 0, 360, 0, 0);
part_type_speed(border, 0.2, 5, -0.02, 0);
part_type_size(border, 1, 4, -0.01, 0);
part_type_alpha2(border, 0.8, 0);
part_type_life(border, 50, 180);

part_particles_create(global.partSystemBehind, x, y, shot, 40);