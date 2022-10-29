/// @description Insert description here
// You can write your code in this editor

life -= global.dt/60;

if life<0 instance_destroy();

if col and spd > 0{

	var check = function(){
		
		return collision_line(x, y, x+lengthdir_x(spd, dir)*global.dt, y+lengthdir_y(spd, dir)*global.dt, obj_solid, false, true);
		
	}
	
	var checkPlayer = function(){
		
		if ownerID != global.playerid return false;
		return collision_line(x, y, x+lengthdir_x(spd, dir)*global.dt, y+lengthdir_y(spd, dir)*global.dt, obj_player_other, false, true);
		
	}
	
	var pl = checkPlayer();
	
	if check() or pl{
	
		if pl {
		
			var b = buffer_create(global.dataSize, buffer_fixed, 1)
			buffer_seek(b, buffer_seek_start, 0);
			buffer_write(b, buffer_u8, 7);
			buffer_write(b, buffer_u16, real(ID))
			buffer_write(b, buffer_u32, id)
			buffer_write(b, buffer_u16, real(pl.ID))
			network_send_raw(obj_network.server, b, global.dataSize)
			buffer_delete(b)
			
			on_hit(pl);
			pl.hit();
		
		}
	
		n = 0;
		if !pl while(!place_meeting(x+lengthdir_x(n+1,dir), y+lengthdir_y(n+1,dir), obj_solid)){
			n++;
		}
		
		x += lengthdir_x(n,dir);
		y += lengthdir_y(n,dir);
		spd = 0;
		collided = true;
		on_collision();
		if dieoncol or pl instance_destroy();
	
	} else {
	
		x += lengthdir_x(spd, dir)*global.dt;
		y += lengthdir_y(spd, dir)*global.dt;
	
	} 

} else if !col and spd > 0 {
	
	x += lengthdir_x(spd, dir)*global.dt;
	y += lengthdir_y(spd, dir)*global.dt;

}

if !collided {

	var _x = lengthdir_x(spd, dir);
	var _y = lengthdir_y(spd, dir);

	dir = point_direction(0, 0, _x, _y+dtime*grav);
	spd = point_distance(0, 0, _x, _y+dtime*grav); 
	
}

image_angle = dir;