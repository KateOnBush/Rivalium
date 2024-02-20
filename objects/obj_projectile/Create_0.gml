/// @description Insert description here
// You can write your code in this editor

bounceFriction = 0.7;
hasGrav = true;
ID = 0;

px = 0;
py = 0;

spd = 0;

dir = 0;

col = true;

collided = false;

bounce = false;

bounce_count = 0;

life = 1;

dieoncol = false

mass = 1;

on_collision = NULLFUNC;

on_hit = NULLFUNC;

on_destroy = NULLFUNC;

lastUpdated = current_time;

can_leave_trail = false;
distance_traveled = 0;

check = function(){
		
	return collision_line(x, y, x+lengthdir_x(spd, dir)*global.dt, y+lengthdir_y(spd, dir)*global.dt, obj_impenetrable, false, true);
		
}
	
checkPlayer = function(){
		
	if ownerID != global.playerid return false;
	return collision_line(x, y, x+lengthdir_x(spd, dir)*global.dt, y+lengthdir_y(spd, dir)*global.dt, obj_player_other, false, true);
		
}

checkPlayerSelf = function(){

	if ownerID == global.playerid return false;
	return collision_line(x, y, x+lengthdir_x(spd, dir)*global.dt, y+lengthdir_y(spd, dir)*global.dt, obj_player, false, true);

}

visibleTimeout = function(){

	visible = true;

}

on_destroy = NULLFUNC;

destroy = function(){
	
	instance_destroy();

}

dataBuffer = buffer_create(global.dataSize, buffer_fixed, 1)