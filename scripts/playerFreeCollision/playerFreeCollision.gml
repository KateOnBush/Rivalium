function forcedSlope(slope){
	
	return abs(slope) < SLOPE_NOT_FORCED_INTERVAL ? (movvec.x > 0 ? slope : slope + 180) : (slope > 0 ? slope + 180 : slope);
	
}


function playerFreeCollision(){

	if !on_ground and (k_right or k_left){

		var t = k_right ? 1 : -1;
	
		if place_meeting(x + movvec.x * dtime + t * 3, y + movvec.y * dtime, obj_solid){
		
			wall_side = t;
			movvec.y *= 0.05;
			state = PlayerState.WALL_SLIDING;
		
		}
	
	}
	
	if place_meeting(x + movvec.x * dtime, y + movvec.y * dtime, obj_solid) {
		
		var vdir = movvec.dir();
		var dist = movvec.length();
		var langle = 0, rangle = 0;
		while(place_meeting(
		x + lengthdir_x(dcos(langle) * dist, vdir + langle),
		y + lengthdir_y(dcos(langle) * dist, vdir + langle), obj_solid) and langle < 90) langle++;
		
		while(place_meeting(
		x + lengthdir_x(dcos(rangle) * dist, vdir - rangle),
		y + lengthdir_y(dcos(rangle) * dist, vdir - rangle), obj_solid) and rangle < 90) rangle++;
		
		var actual_angle = min(langle, rangle);
		if (actual_angle == rangle) actual_angle *= -1;
		
		movvec.x = lengthdir_x(dcos(actual_angle) * movvec.length(), vdir + actual_angle);
		movvec.y = lengthdir_y(dcos(actual_angle) * movvec.length(), vdir + actual_angle);
	
	}
	
	x += movvec.x * dtime;
	y += movvec.y * dtime;
	
	if place_meeting(x, y, obj_solid){
	
		var s = 32;
		for(var i = 1; i <= s; i++){
		
			if !place_meeting(x + i, y, obj_solid) { x+=i; break; }
			if !place_meeting(x - i, y, obj_solid) { x-=i; break; }
			if !place_meeting(x, y + i, obj_solid) { y+=i; break; }
			if !place_meeting(x, y - i, obj_solid) { y-=i; break; }
		
		}
	
	}

}