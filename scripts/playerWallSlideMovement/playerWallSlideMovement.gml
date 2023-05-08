function playerWallSlideMovement(){

	movvec.x = 0;
	double_jump_boost = false;
	dir = -wall_side;
	if k_jump {		
		movvec.x = -35*wall_side;
		movvec.y = -12;
		state = PLAYER_STATE.FREE;
	}
	
	if on_ground state = PLAYER_STATE.FREE;
	
	if (wall_side < 0 && !k_left) or (wall_side > 0 && !k_right) state = PLAYER_STATE.FREE;
}