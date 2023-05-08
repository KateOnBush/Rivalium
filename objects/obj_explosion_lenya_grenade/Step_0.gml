/// @description Insert description here
// You can write your code in this editor

part_type_size(trail, 0.5, 0.8, -0.01*dtime, 0);
part_type_life(trail, fpstime*2.8, fpstime*3)
part_type_speed(trail, 9.3*dtime, 9.3*dtime, -.06*dtime, .002*dtime);
part_type_direction(trail, 0, 360, 0, 20*dtime);

part_type_size(trail2, 0.5, 0.8, -0.01*dtime, 0);
part_type_life(trail2, fpstime*2.8, fpstime*3)
part_type_speed(trail2, 1*dtime, 1.2*dtime, -.02*dtime, .002*dtime);
part_type_direction(trail2, 45, 135, 0, 20*dtime);
part_type_gravity(trail2, 0.03*dtime, -90);


if !hits {

	repeat(40){
	
		part_particles_create(global.partSystemBehind, x+random_range(-3,3), y+random_range(-3,3), trail, random(10))
	
	
	}
	
	repeat(80){
		
		part_particles_create(global.partSystemBehind, x+random_range(-3,3), y+random_range(-3,3), trail2, random(10))
	
	}

}

event_inherited();
