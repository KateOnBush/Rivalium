function playerOtherFreeCollision(){

	if place_meeting(ux + movvec.x * dtime, uy + movvec.y * dtime, obj_solid) {
		
		var vdir = movvec.dir();
		var dist = movvec.length();
		var langle = 0, rangle = 0;
		while(place_meeting(
		ux + lengthdir_x(dcos(langle) * dist, vdir + langle),
		uy + lengthdir_y(dcos(langle) * dist, vdir + langle), obj_solid) and langle < 90) langle++;
		
		while(place_meeting(
		ux + lengthdir_x(dcos(rangle) * dist, vdir - rangle),
		uy + lengthdir_y(dcos(rangle) * dist, vdir - rangle), obj_solid) and rangle < 90) rangle++;
		
		var actual_angle = min(langle, rangle);
		if (actual_angle == rangle) actual_angle *= -1;
		
		movvec.x = lengthdir_x(dcos(actual_angle) * movvec.length(), vdir + actual_angle);
		movvec.y = lengthdir_y(dcos(actual_angle) * movvec.length(), vdir + actual_angle);
	
	}
	
	ux += movvec.x * dtime;
	uy += movvec.y * dtime;
	
	if place_meeting(ux, uy, obj_solid){
	
		var s = 64;
		for(var i = 1; i <= s; i++){
		
			if !place_meeting(ux + i, uy, obj_solid) { ux+=i; break; }
			if !place_meeting(ux - i, uy, obj_solid) { ux-=i; break; }
			if !place_meeting(ux, uy + i, obj_solid) { uy+=i; break; }
			if !place_meeting(ux, uy - i, obj_solid) { uy-=i; break; }
		
		}
	
	}

}