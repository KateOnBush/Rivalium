function playerGroundedMovement(){

	movvec.x = 0;
	movvec.y = 0;
	
	grounded -= dtime;
	if (grounded < 0) state = PlayerState.FREE;

}
