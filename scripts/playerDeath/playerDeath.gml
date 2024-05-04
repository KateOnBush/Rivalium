function playerDeath(){
	
	deaths++;
	var limbs = [];

	for(var i = 0; i < array_length(pos); i++) {
		var currentPos = pos[i];
		var currentX = x + currentPos[0], currentY = y + currentPos[1], currentDir = currentPos[2];
		
		var o = instance_create_depth(currentX, currentY, depth, obj_player_limb);
		o.rotation = currentDir;
		o.sprite_index = sprite;
		o.image_index = i;
		o.image_xscale = cdir;
		limbs[i] = o;
		o.movvec = new Vector2(movvec.x + random(1), movvec.y + random(1));
	}
	
	for(var i = 0; i < array_length(pos); i++) {
		var currentLimb = limbs[i];
		var currentBone = base[i];
		if (currentBone[2] != -1) {
			var parentBone = base[currentBone[2]];
			currentLimb.parentBone = limbs[currentBone[2]];
			var diffX = currentBone[0] - parentBone[0], diffY = currentBone[1] - parentBone[1];
			currentLimb.diffX = diffX;
			currentLimb.diffY = diffY;
		}
	}
	
	state = PlayerState.DEAD;

}