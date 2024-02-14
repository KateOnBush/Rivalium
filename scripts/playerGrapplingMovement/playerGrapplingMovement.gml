function playerGrapplingMovement(){
	
	if !k_grapple state = PlayerState.FREE;

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
	
			var grapplingPos = new UReqGrapplingPosition();
			grapplingPos.x = grappling_coords[0];
			grapplingPos.y = grappling_coords[1];
			grapplingPos.grappled = true;
			gameserver_send(grapplingPos);
	
		}
		
		state = PlayerState.GRAPPLED;
		
	}
	
	if grappling_len > point_distance(x,y-16,grappling_coords_init[0],grappling_coords_init[1]) or on_ground {
	
		grapple_cooldown = 20;
		state = PlayerState.FREE
	
	}

}