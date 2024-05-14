/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

spawned = 1;
spawned_size = 0;
fire_size = 0;
rot = 0;

color = c_white; //#2d60d6; //#de4f35;

image_speed = 0;

pickedup = noone;
pickup_blend = 0;
lifespan = 50;

mov_x = 0;
mov_y = 0;

dist_lerp = 0;
dir_lerp = 0;

time_before_pos_lerp = 5;

type = OrbType.LETHALITY;

solidComponent = entity_create_solid_component(x, y, self, obj_obstacle_orbstone);

parts = part_type_create();
part_type_sprite(parts, spr_orb_particles, 0, 0, true);
part_type_size(parts, 1.2, 1.5, -0.005, 0);
part_type_life(parts, 300, 400);
part_type_direction(parts, 100, 80, 0, 0)
part_type_orientation(parts, 0, 360, 0.002, 0, 0);
part_type_speed(parts, 0.8, 1.5, -0.0016, 0);
part_type_alpha3(parts, 0, 0.9, 0);