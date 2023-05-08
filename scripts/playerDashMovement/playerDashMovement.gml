function playerDash(direc, time, mult = 1){

	state = PLAYER_STATE.DASHING;
	length_before_dash = movvec.length();
	dash_target = new Vector2(
		lengthdir_x(5, direc),
		lengthdir_y(5, direc)
	).normalize().multiply(30 * spdboost * mult);
	dash = time;
	dash_cooldown = PLAYER_DASH_COOLDOWN;

}


function playerDashMovement(){

	if movvec.length() < 0.1 or dash == 0 {
		state = PLAYER_STATE.FREE;
		var ll = length_before_dash, dd = movvec.dir();
		movvec.x = lengthdir_x(ll, dd);
		movvec.y = lengthdir_y(ll, dd);
	}
	movvec.x = dtlerp(movvec.x, dash_target.x, 0.2);
	movvec.y = dtlerp(movvec.y, dash_target.y, 0.2);
	dir = sign(movvec.x);
	dash = max(dash-dtime/60,0);
	dash_cooldown = 60;
}