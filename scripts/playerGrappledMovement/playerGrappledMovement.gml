function playerGrappledMovement(){

	var ray = point_distance(x,y,grappling_coords[0],grappling_coords[1])
	var d = point_direction(grappling_coords[0],grappling_coords[1],x,y)
	
	grap_grav += grav*global.dt;
	
	var _accel = -0.1* dcos(d);
	vel += _accel*global.dt;
	d += vel*global.dt;
	vel *= power(sqrt(0.98), global.dt);
	
	dir = sign(vel)
	
	movvec.x = (grappling_coords[0] + lengthdir_x(ray, d) - x)/global.dt;
	movvec.y = grap_grav + (grappling_coords[1] + lengthdir_y(ray, d) - y)/global.dt;
	
	if point_distance(x+movvec.x*global.dt,y+movvec.y*global.dt,grappling_coords[0],grappling_coords[1])>grappling_len{
		
		var dis = sign(vel)*movvec.length();
		ray = grappling_len;
		d = point_direction(grappling_coords[0],grappling_coords[1],x,y)
		
		var _ang = 2.65 * darcsin(dis/(2*ray));
		
		movvec.x = (grappling_coords[0] + lengthdir_x(ray, d+_ang*global.dt) - x)/global.dt;
		movvec.y = (grappling_coords[1] + lengthdir_y(ray, d+_ang*global.dt) - y)/global.dt;
		
		grap_grav = 0;
		
	}
	
	if on_ground or !k_grapple {
	
		var _d = point_direction(grappling_coords[0],grappling_coords[1],x,y)
		var _e = clamp(sign(vel)*angle_difference(270, _d),0,180)
		
		if !on_ground and movvec.length()>8 perform_flip(false, _e/360)
		
		state = PLAYER_STATE.FREE;
		
		grapple_cooldown = 20;
	
	}

}