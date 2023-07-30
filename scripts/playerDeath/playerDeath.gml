function playerDeath(){

	var o = instance_create_depth(x, y, depth, obj_player_death);
	o.deadPlayer = self;
	
	state = PLAYER_STATE.DEAD;

}