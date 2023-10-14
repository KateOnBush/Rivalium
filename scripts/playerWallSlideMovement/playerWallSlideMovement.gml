function playerWallSlideMovement(){

	movvec.x = 0;
	double_jump_boost = false;
	dir = -wall_side;
	if k_jump {		
		movvec.x = -35*wall_side;
		movvec.y = -12;
		state = PlayerState.FREE;
	}
	
	if on_ground state = PlayerState.FREE;
	
	if (wall_side < 0 && !k_left) or (wall_side > 0 && !k_right) state = PlayerState.FREE;
}