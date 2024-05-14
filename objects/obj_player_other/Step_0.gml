/// @description Insert description here
// You can write your code in this editor

var wasOnGround = on_ground,
initialVelocity = movvec.length();

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
		
		playerOtherFreeCollision();
		playerOtherGravity();
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
		playerOtherCollision();
		break;
	
	}
	
	case PlayerState.WALL_SLIDING: {
		playerOtherGravity(0.1);
		playerOtherCollision();
		break;
	}
	
	case PlayerState.DASHING:
	case PlayerState.GROUNDED: {
		playerOtherCollision();
		break;
	}
	
	case PlayerState.GRAPPLED: {
	
		grappling_coords[0] = grappling_coords_init[0];
		grappling_coords[1] = grappling_coords_init[1];
		playerOtherCollision();
		break;
	
	}

}

on_ground = place_meeting(x - 2, y + 10, obj_solid) && place_meeting(x + 2, y + 10, obj_solid);

var amt = 0.9 - ping/500; amt = clamp(amt, 0.05, 0.9);
x = dtlerp(x, ux, amt);
y = dtlerp(y, uy, amt);

playerStepAbilities();

if dead {
	movvec.x = 0;
	movvec.y = 0;
	mask_index = -1;
} else {
	playerProcessAnimations();
	mask_index = player_collision_mask;
} 

playerCalculateFrame(rotation_offset);

playerProcessEffects();

var new_run_dust = (run_ani * 2) mod 1;
if movvec.length() > 8 && on_ground && (new_run_dust < run_dust)  {
	part_particles_create(global.partSystem, x, y + 28, gParts.dustRun, 3 + irandom(3));
}
run_dust = (run_ani * 2) mod 1;

if (!wasOnGround and on_ground) {
	part_particles_create(global.partSystem, x, y + 28, gParts.dustGround, round(initialVelocity/3));
}

if (slide > 0 and on_ground and isFpsFrame and movvec.length() > 8) {
	part_particles_create(global.partSystem, x, y + 28, gParts.dustRun, irandom(2));
}
