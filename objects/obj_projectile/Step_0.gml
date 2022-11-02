/// @description Insert description here
// You can write your code in this editor

life -= global.dt/60;

if life<0 instance_destroy();

if col and spd > 0{
	
	var pl = checkPlayer();
	
	if check() or pl{
	
		if pl {
		
			buffer_seek(dataBuffer, buffer_seek_start, 0);
			buffer_write(dataBuffer, buffer_u8, 7);
			buffer_write(dataBuffer, buffer_u16, real(ID))
			buffer_write(dataBuffer, buffer_u32, id)
			buffer_write(dataBuffer, buffer_u16, real(pl.ID))
			network_send_raw(obj_network.server, dataBuffer, global.dataSize)
			
			on_hit(pl);
			pl.hit();
		
		}
	
		var n = 0;
		if !pl while(!place_meeting(x+lengthdir_x(n,dir), y+lengthdir_y(n,dir), obj_solid)){
			n++;
		}
		if !bounce and !pl{
		
			x += lengthdir_x(n,dir);
			y += lengthdir_y(n,dir);
			spd = 0;
		
		} else if !pl {

			if !buffer_exists(dataBuffer) dataBuffer = buffer_create(global.dataSize, buffer_fixed, 1);
	
			var collidedBlock = instance_place(x+lengthdir_x(n+1,dir), y+lengthdir_y(n+1,dir), obj_solid);
			if !instance_exists(collidedBlock) exit;
			var orientation = collidedBlock.image_angle;
			orientation = angle_difference(orientation, floor(orientation/90)*90);
			
			var s = 0;
			while(place_meeting(x+lengthdir_x(s,dir + 180), y+lengthdir_y(s,dir + 180), obj_solid)){
				s++;
			}
			x += lengthdir_x(s, dir + 180);
			y += lengthdir_y(s, dir + 180);
			
			var kx = 3*sign(lengthdir_x(1,dir));
			var ky = 3*sign(lengthdir_y(1,dir));
			
			var kx_x = lengthdir_x(kx, orientation);
			var kx_y = lengthdir_y(kx, orientation);
			
			var ky_x = lengthdir_x(ky, orientation);
			var ky_y = lengthdir_y(ky, orientation);
		
			var side = place_meeting(x+kx_x, y+kx_y, obj_solid); //Side
			var topbot = place_meeting(x+ky_y, y+ky_y, obj_solid);
			
			var newdir;

			if side { newdir = orientation - angle_difference(dir, orientation); }
			else { newdir = 90 + orientation - angle_difference(dir, 90 + orientation); }
			
			dir = newdir + 180;
			
			bounce_count++;
			spd *= 0.7;
			
			buffer_seek(dataBuffer, buffer_seek_start, 0);
			buffer_write(dataBuffer, buffer_u8, 13);
			buffer_write(dataBuffer, buffer_u16, real(ID));
			buffer_write(dataBuffer, buffer_s32, round(x*100));
			buffer_write(dataBuffer, buffer_s32, round(y*100));
			buffer_write(dataBuffer, buffer_s32, round(lengthdir_x(spd, dir)*100));
			buffer_write(dataBuffer, buffer_s32, round(lengthdir_y(spd, dir)*100));
	
			network_send_raw(obj_network.server, dataBuffer, global.dataSize);
		
		}
		
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

if !collided or bounce {

	var _x = lengthdir_x(spd, dir);
	var _y = lengthdir_y(spd, dir);

	dir = point_direction(0, 0, _x, _y+dtime*grav);
	spd = point_distance(0, 0, _x, _y+dtime*grav); 
	
}

image_angle = dir;