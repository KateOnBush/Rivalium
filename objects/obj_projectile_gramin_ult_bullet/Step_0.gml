/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

part_type_orientation(trail, dir, dir,0, 0, false)

if spd>0 and isFpsFrame {
	part_particles_create(global.partSystem, x, y, trail, 1)
}
