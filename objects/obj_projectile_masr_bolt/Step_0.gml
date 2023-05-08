/// @description Insert description here
// You can write your code in this editor

part_type_orientation(trail, dir - 40, dir + 40, 0, 0, 0);
part_type_orientation(line, dir, dir, 0, 0, 0);

if isFpsFrame {
	
	repeat(irandom(10)){

		bolttime = 0.2;
		var t = random_range(-10, 10);
		var r = random_range(0, spd);
		if random(1) > .4 part_particles_create(global.partSystemBehind, 
		x + lengthdir_x(t, dir + 90) - lengthdir_x(r, dir), 
		y + lengthdir_y(t, dir + 90) - lengthdir_y(r, dir),
		trail, 1)
	}
	
	part_particles_create(global.partSystemBehind, 
		x,
		y,
		line, 1)
	
}




// Inherit the parent event
event_inherited();

