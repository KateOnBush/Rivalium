/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isFpsFrame repeat(random_range(1, 3)){
	part_particles_create(global.partSystemBehind, x, y, trail, 1)
}