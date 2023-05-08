/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

part_type_speed(trail, 1.2*dtime, 1.2*dtime, -.01*dtime, 0);
part_type_direction(trail, 85, 95, 0, 10*dtime);
part_type_life(trail, 2*fpstime, 2.5*fpstime)

repeat(random_range(1, 3)){
	part_particles_create(global.partSystemBehind, x + random_range(-4, 4), y, trail, 1)
}