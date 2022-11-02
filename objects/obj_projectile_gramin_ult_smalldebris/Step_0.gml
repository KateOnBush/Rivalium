/// @description Insert description here
// You can write your code in this editor

imangle += 5*dtime;

// Inherit the parent event
event_inherited();

image_angle = dir + imangle;

part_type_life(trail, 15/global.dt, 15/global.dt)

part_type_orientation(trail, dir, dir,0, 0, false)

part_type_speed(trail, 1*dtime, 1.5*dtime, 0, 0);

part_type_life(trail, 60/dtime, 60/dtime)

if ID != 0 and !timer{

	timer++;

	var anon = function(){
	
		screen_shake_position(50, 100, 0.25, x, y);
		if ownerID == global.playerid explosion_create_request(obj_explosion_gramin, x, y, 150, 20);
	
		self.destroy();
	
	}
	
	createEvent(1, anon);
	
}

/*if spd>0 {
	part_particles_create(global.partSystem, x+random_range(-2, 2), y+random_range(-2, 2), trail, 1)
}
