function playerCollision(){

	move_and_collide(movvec.x * dtime, movvec.y * dtime, obj_solid);

}

function playerOtherCollision() {

	if place_meeting(ux + movvec.x * dtime, uy + movvec.y * dtime, obj_solid) {
		
		var i = 10;
		
		while(place_meeting(ux + movvec.x * dtime * i/10, uy + movvec.y * dtime * i/10, obj_solid) and i>=0) i--;
		
		movvec.x *= i/10;
		movvec.y *= i/10;
	
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