/// @description Insert description here
// You can write your code in this editor


part_type_gravity(trail, grav*dtime/130, 270);
part_type_size(trail, 0.6, 0.5, -0.015*dtime, 0);
part_type_life(trail, fpstime*2, fpstime*3)
part_type_speed(trail, 8*dtime, 0.4*dtime, 0, 0);


if !hits {

	repeat(15){
	
		part_particles_create(global.partSystem, x+random_range(-3,3), y+random_range(-3,3), trail, random(30))
	
	}

}

event_inherited();
