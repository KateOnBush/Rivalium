/// @description Insert description here
// You can write your code in this editor

if !hits {

	repeat(40){
		part_particles_create(global.partSystem, x, y, rumble, random(5))	
	}

	repeat(10){
		part_particles_create(global.partSystem, x, y, smoke, random(10))
	}

	repeat(10){
		part_particles_create(global.partSystem, x, y, impact, random(10))
	}

}

event_inherited();
