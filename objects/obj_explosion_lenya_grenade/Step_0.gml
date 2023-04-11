/// @description Insert description here
// You can write your code in this editor


part_type_size(trail, 0.5, 0.8, -0.01*dtime, 0);
part_type_life(trail, fpstime*2.8, fpstime*3)
part_type_speed(trail, 8.7*dtime, 9.3*dtime, -.06*dtime, .002*dtime);
part_type_direction(trail, 0, 360, 0, 20*dtime);


if !hits {

	repeat(40){
	
		part_particles_create(global.partSystem, x+random_range(-3,3), y+random_range(-3,3), trail, random(10))
	
	}

}

event_inherited();
