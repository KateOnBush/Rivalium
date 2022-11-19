/// @description Insert description here
// You can write your code in this editor

life -= global.dt/60;

if life<0 instance_destroy();

if col and spd > 0{
	
	var pl = checkPlayer();
	var plSelf = checkPlayerSelf();
	
	if plSelf {
	
		visible = false;
		createEvent(0.5, visibleTimeout, self);
	
	}
	
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
		if !pl while(!place_meeting(px+lengthdir_x(n,dir), py+lengthdir_y(n,dir), obj_solid) and n<spd){
			n++;
		}
		
		var collidedBlock = instance_place(px+lengthdir_x(n+1,dir), py+lengthdir_y(n+1,dir), obj_solid);
		
		if !bounce and !pl{
		
			if collidedBlock && collidedBlock.object_index == obj_obstacle_entity {
			
				collidedBlock.componentTo.damage(damage);
			
			}
		
			px += lengthdir_x(n,dir);
			py += lengthdir_y(n,dir);
			spd = 0;
		
		} else if !pl {

			if !buffer_exists(dataBuffer) dataBuffer = buffer_create(global.dataSize, buffer_fixed, 1);
	
			if !instance_exists(collidedBlock) exit;
			var orientation = collidedBlock.image_angle;
			orientation = angle_difference(orientation, floor(orientation/90)*90);
			
			var s = 0;
			while(place_meeting(px+lengthdir_x(s,dir + 180), py+lengthdir_y(s,dir + 180), obj_solid)){
				s++;
			}
			px += lengthdir_x(s, dir + 180);
			py += lengthdir_y(s, dir + 180);
			
			var kx = 3*sign(lengthdir_x(1,dir));
			var ky = 3*sign(lengthdir_y(1,dir));
			
			var kx_x = lengthdir_x(kx, orientation);
			var kx_y = lengthdir_y(kx, orientation);
			
			var ky_x = lengthdir_x(ky, orientation);
			var ky_y = lengthdir_y(ky, orientation);
		
			var side = place_meeting(px+kx_x, py+kx_y, obj_solid); //Side
			var topbot = place_meeting(px+ky_y, py+ky_y, obj_solid);
			
			var newdir;

			if side { newdir = orientation - angle_difference(dir, orientation); }
			else { newdir = 90 + orientation - angle_difference(dir, 90 + orientation); }
			
			dir = newdir + 180;
			
			bounce_count++;
			spd *= 0.7;
			
			buffer_seek(dataBuffer, buffer_seek_start, 0);
			buffer_write(dataBuffer, buffer_u8, 13);
			buffer_write(dataBuffer, buffer_u16, real(ID));
			buffer_write(dataBuffer, buffer_s32, round(px*100));
			buffer_write(dataBuffer, buffer_s32, round(py*100));
			buffer_write(dataBuffer, buffer_s32, round(lengthdir_x(spd, dir)*100));
			buffer_write(dataBuffer, buffer_s32, round(lengthdir_y(spd, dir)*100));
	
			network_send_raw(obj_network.server, dataBuffer, global.dataSize);
		
		}
		
		collided = true;
		on_collision();
		if dieoncol or pl instance_destroy();
	
	} else {
	
		px += lengthdir_x(spd, dir)*global.dt;
		py += lengthdir_y(spd, dir)*global.dt;
	
	} 

} else if !col and spd > 0 {
	
	px += lengthdir_x(spd, dir)*global.dt;
	py += lengthdir_y(spd, dir)*global.dt;

}

if !collided or bounce {

	var _x = lengthdir_x(spd, dir);
	var _y = lengthdir_y(spd, dir);

	dir = point_direction(0, 0, _x, _y+dtime*grav);
	spd = point_distance(0, 0, _x, _y+dtime*grav); 
	
}

image_angle = dir;

x = dtlerp(x, px, 0.8);
y = dtlerp(y, py, 0.8);