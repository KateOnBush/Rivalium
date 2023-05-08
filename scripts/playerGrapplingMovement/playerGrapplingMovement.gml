function playerGrapplingMovement(){
	
	if !k_grapple state = PLAYER_STATE.FREE;

	grappling_len += 25*global.dt;
	var d = point_direction(x,y-16,grappling_coords_init[0],grappling_coords_init[1]);
	
	grappling_coords = [x+lengthdir_x(grappling_len, d),y+lengthdir_y(grappling_len, d)]
	
	var de = point_direction(x,y-16,grappling_coords[0],grappling_coords[1]);
	dir = -sign(angle_difference(-90,de));
	
	if collision_line(x,y,grappling_coords[0],grappling_coords[1],obj_solid,true,true){
	
		while(collision_line(x,y,grappling_coords[0],grappling_coords[1],obj_solid,true,true)){
		
			grappling_len -= 1;
			grappling_coords = [x+lengthdir_x(grappling_len, d),y+lengthdir_y(grappling_len, d)]
			if !collision_line(x,y,grappling_coords[0],grappling_coords[1],obj_solid,true,true){
				grappling_len += 1;
				grappling_coords = [x+lengthdir_x(grappling_len, d),y+lengthdir_y(grappling_len, d)]
				break;
			}
			
		}
		
		var _len = movvec.length();
		var _de = point_direction(x,y,grappling_coords[0],grappling_coords[1]);
		var _ray = point_distance(x,y,grappling_coords[0],grappling_coords[1]);
		
		var _nlen = _len * dsin(angle_difference(movvec.dir(),_de))
		
		vel = - 2.65 * darcsin(_nlen/(2*_ray));
		
		if global.connected {
	
			var buff = buffer_create(global.dataSize, buffer_fixed, 1);
			buffer_seek(buff, buffer_seek_start, 0);
			buffer_write(buff, buffer_u8, SERVER_REQUEST.GRAPPLING_POSITION);
			buffer_write(buff, buffer_s32, round(grappling_coords[0]*100))
			buffer_write(buff, buffer_s32, round(grappling_coords[1]*100))
			buffer_write(buff, buffer_u8, 1);
			network_send_raw(obj_network.server, buff, buffer_get_size(buff));
			
			buffer_delete(buff);
	
		}
		
		state = PLAYER_STATE.GRAPPLED;
		
	}
	
	if grappling_len > point_distance(x,y-16,grappling_coords_init[0],grappling_coords_init[1]) or on_ground {
	
		grapple_cooldown = 20;
		state = PLAYER_STATE.FREE
	
	}

}