/// @description Insert description here
// You can write your code in this editor

var len = 400;

var dd = sign(parameters[0]), dir1 = 90 - 20 * dd, dir2 = -dir1;

part_type_direction(wind1, dir1, dir1, dd * 1.4, 0.03);
part_type_direction(wind2, dir2, dir2, -dd * 1.4, 0.03);

if isFpsFrame {

	if random(1) > 0.75 part_particles_create(global.partSystemBehind, 
	x + 10 * dd + random_range(-10, 10), 
	y + random_range(-(len + 20)/2, (len + 20)/2), trail, 1)
	
	repeat(5) {
		
		part_particles_create(global.partSystemBehind, x + random_range(-10, 10), y + len/2, wind1, 1)
		part_particles_create(global.partSystemBehind, x + random_range(-10, 10), y - len/2, wind2, 1)
		
	}
		

}

wallobj.x = dtlerp(wallobj.x, x + 15 * dd, 0.8);
wallobj.image_yscale = dtlerp(wallobj.image_yscale, len/32, 0.05);

// Inherit the parent event
event_inherited();