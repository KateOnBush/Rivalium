/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

part_type_life(trail, 15/global.dt, 15/global.dt)

part_type_orientation(trail, dir, dir,0, 0, false)

part_type_speed(bleedpart, 1*dtime, 1.5*dtime, 0, 0);

part_type_life(bleedpart, 60/dtime, 60/dtime)

part_type_speed(spark, 1.2*dtime, 1.3*dtime, 0, 0.1*dtime);
part_type_direction(spark, 0, 359, 5*dtime, 6*dtime);


part_type_life(spark, 60/dtime, 60/dtime);

if spd>0 {
	part_particles_create(global.partSystem, x, y, trail, 1)
	part_particles_create(global.partSystem, x, y, bleedpart, irandom(8));
}

if choose(true, false) part_particles_create(global.partSystem, x, y, spark, 1)
