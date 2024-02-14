function playerFreeMovement(){
	
	if casting return;
		
	if (on_ground and !slide) {
		
		if k_slide and movvec.length() > 10 {
			slide = 1;
		}
	
		var l = movvec.length()
		l = dtlerp(l, 0, 0.1);
		movvec.x = lengthdir_x(l,movvec.dir());
		movvec.y = lengthdir_y(l,movvec.dir());
	
	} else if (on_ground && slide) {
		
		var l = movvec.length(), _dir = movvec.dir();
		var s = abs(angle_difference(_dir, -90)) - 90;
		l = dtlerp(l, s > SLOPE_NOT_FORCED_INTERVAL ? - 40 * dsin(s) : 40 * (0.4 - 0.6 * dsin(s)), 0.01);
		movvec.x = lengthdir_x(l,_dir);
		movvec.y = lengthdir_y(l,_dir);
		
		if k_slide_release or movvec.length() < 5 {
			slide = 0;	
		}
		
	} else {
		movvec.x = dtlerp(movvec.x,0,0.035)
		slide = 0;
	}
	
	var djratio = 1.5;
	var spddj = (double_jump_boost ? djratio : 1);
	var movmag = spd*spddj*spdboost;
	
	if (k_left || k_right) && !slide {
		
		movvec.x = dtlerp(movvec.x, k_right ? movmag : -movmag, on_ground ? 0.12 : 0.03);	
	
	}
	
	if ((k_right || k_left) and movvec.length()>0.01) or slide dir = sign(movvec.x);
	if (dir==0) dir = 1;
	
	if k_grapple && !on_ground {
		
		state = PlayerState.GRAPPLE_THROW;

		grappling_coords_init = [mousex, mousey]
	
		if global.connected {
	
			var grapplingPos = new UReqGrapplingPosition();
			grapplingPos.x = mousex;
			grapplingPos.y = mousey;
			grapplingPos.grappled = false;
			gameserver_send(grapplingPos);
	
		}

		grappling_coords = [x,y]
		grappling_len = 0;

	}
	
	if k_dash and dash_cooldown==0 and movvec.length() > 0 {

		var __dir = k_left ? -180 : (k_right ? 0 : (mousex - x < 0 ? - 180 : 0));
		
		playerDash(__dir, 0.35);

	}
	
	if on_ground flip = 0;
	
	if on_ground and k_jump {

		on_ground = false;
		movvec.y = -13;

	} else if !on_ground and !double_jump and k_jump {
	
		double_jump = true;
		double_jump_boost = true;
		movvec.y = -11;
		movvec.x *= djratio;
		if choose(true, false) and movvec.length() > 13 perform_flip(true, 0);

	}
	
	dash_cooldown = max(dash_cooldown-1*dtime,0);
	grapple_cooldown = max(grapple_cooldown-dtime,0);

}