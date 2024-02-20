/// @description Insert description here
// You can write your code in this editor

radius = dtlerp(radius, parameters[0], parameters[1]);

if isFpsFrame repeat(50) {

	var angle = random_range(0, 360);
	var _x = lengthdir_x(radius, angle), _y = lengthdir_y(radius, angle);
	part_particles_create(global.partSystemBehind, x + _x, y + _y, border, 1);
	
}

event_inherited();