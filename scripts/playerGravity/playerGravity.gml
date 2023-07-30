function playerGravity(n = 1){
	
	var gravityvec = new Vector2(0, grav*dtime)

	if (n != 1) gravityvec = gravityvec.multiply(n);
	
	if (!on_ground or k_left or k_right) movvec = movvec.add(gravityvec);

}

function playerOtherGravity(n = 1){

	var gravityvec = new Vector2(0, grav*dtime)

	if (n != 1) gravityvec = gravityvec.multiply(n);
	
	if (!on_ground) movvec = movvec.add(gravityvec);

}