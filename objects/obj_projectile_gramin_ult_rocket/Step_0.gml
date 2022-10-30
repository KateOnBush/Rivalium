/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

part_type_life(trail, 15/global.dt, 15/global.dt)

part_type_orientation(trail, dir, dir,0, 0, false)

part_type_speed(trail, 1*dtime, 1.5*dtime, 0, 0);

part_type_life(trail, fpstime*2, fpstime*3)

part_type_size(trail, 0.4, 0.2, -0.01*dtime, 0);

if spd>0 {
	part_particles_create(global.partSystem, x, y, trail, 1)
}
