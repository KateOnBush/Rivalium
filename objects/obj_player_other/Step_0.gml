/// @description Insert description here
// You can write your code in this editor

health_blend = dtlerp(health_blend, playerhealth/playerhealthmax, 0.5);
health_blend_red = dtlerp(health_blend_red, health_blend, 0.04);
ultimatecharge_blend = dtlerp(ultimatecharge_blend, ultimatecharge/ultimatechargemax, 0.08);


invisible_blend = dtlerp(invisible_blend, !invisible, 0.1);

healing_timer -= dtime/60;
if healing_timer < 0 healing_timer = 0;
burning_timer -= dtime/60;
if burning_timer < 0 burning_timer = 0;
hitind = dtlerp(hitind, burning_timer > 0, 0.01);

respawn_time -= dtime/60;
respawn_time = max(0, respawn_time);

/*  -----------------------------

MOVEMENT

--------------------------------- */

switch(state) {

	case PlayerState.FREE: {
		
		grappling_len = 0;
		break;
	}
	
	case PlayerState.GRAPPLE_THROW: {
	
		grappling_len += 25 * dtime;
		var d = point_direction(x,y-16,grappling_coords_init[0],grappling_coords_init[1]);
	
		grappling_coords = [x+lengthdir_x(grappling_len, d),y+lengthdir_y(grappling_len, d)]
	
		if grappling_len > point_distance(x,y-16,grappling_coords_init[0],grappling_coords_init[1]){
	
			grappling_coords[0] = grappling_coords_init[0];
			grappling_coords[1] = grappling_coords_init[1];
	
		}
		break;
	
	}
	
	case PlayerState.GRAPPLED: {
	
		grappling_coords[0] = grappling_coords_init[0];
		grappling_coords[1] = grappling_coords_init[1];
		break;
	
	}

}

if current_time - updated >= 18 {

	move_and_collide(movvec.x * dtime, movvec.y * dtime, obj_solid);
	playerOtherGravity();
	
	if current_time - updated >= 400 state = PlayerState.FREE;

} else {

	x = dtlerp(x, ux, 0.82);
	y = dtlerp(y, uy, 0.82);

}

playerStepAbilities();

playerProcessAnimations();

playerCalculateFrame(rotation_offset);

playerProcessEffects();

