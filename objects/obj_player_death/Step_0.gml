/// @description Insert description here
// You can write your code in this editor

greying = dtlerp(greying, 1, 0.09);
if greying > 0.99 {
	
	repeat(irandom(300)) {
		part_particles_create(global.partSystem, x + random_range(-12, 12), y + random_range(-28, 28), gParts.death, irandom(4))
	}
	instance_destroy();
	
}