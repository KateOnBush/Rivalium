function playerWallSlideMovement(){

	movvec.x = 0;
	movvec.y *= power(0.99, dtime);
	double_jump_boost = false;
	dir = -wall_side;
	if k_jump {		
		movvec.x = -35*wall_side;
		movvec.y = -12;
		state = PlayerState.FREE;
	}
	
	if on_ground state = PlayerState.FREE;
	
	if !place_meeting(x + wall_side * 3, y + movvec.y * dtime + 32, obj_solid) or 
		!place_meeting(x + wall_side * 3, y + movvec.y * dtime - 32, obj_solid) {	
		state = PlayerState.FREE;
	}
	
	
	if (wall_side < 0 && !k_left) or (wall_side > 0 && !k_right) state = PlayerState.FREE;
}