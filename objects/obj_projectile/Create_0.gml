/// @description Insert description here
// You can write your code in this editor

ID = 0;

spd = 0;

dir = 0;

col = true;

collided = false;

bounce = false;

bounce_count = 0;

life = 1;

dieoncol = false

mass = 1;

on_collision = function(){};

on_hit = function(player){}

lastUpdated = current_time;

check = function(){
		
	return collision_line(x, y, x+lengthdir_x(spd, dir)*global.dt, y+lengthdir_y(spd, dir)*global.dt, obj_solid, false, true);
		
}
	
checkPlayer = function(){
		
	if ownerID != global.playerid return false;
	return collision_line(x, y, x+lengthdir_x(spd, dir)*global.dt, y+lengthdir_y(spd, dir)*global.dt, obj_player_other, false, true);
		
}

destroy = function(){

	var b = buffer_create(global.dataSize, buffer_fixed, 1)
	buffer_seek(b, buffer_seek_start, 0);
	buffer_write(b, buffer_u8, 7);
	buffer_write(b, buffer_u16, real(ID))
	network_send_raw(obj_network.server, b, global.dataSize)
	buffer_delete(b)
	
	instance_destroy();

}

dataBuffer = buffer_create(global.dataSize, buffer_fixed, 1)