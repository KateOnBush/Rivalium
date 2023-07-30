


playerInputs()

health_blend = dtlerp(health_blend, playerhealth/playerhealthmax, 0.5);

if healthbefore != playerhealth {
	healthbefore = playerhealth
	health_red_go = 0.5;
} else {
	health_red_go = max(0, health_red_go - dtime/60);
	if health_red_go == 0 health_blend_red = dtlerp(health_blend_red, health_blend, 0.04);

}

health_blend_red = max(health_blend_red, health_blend);

hitind = dtlerp(hitind, 0, 0.05);

ultimatecharge_blend = dtlerp(ultimatecharge_blend, ultimatecharge/ultimatechargemax, 0.08);
invisible_blend = dtlerp(invisible_blend, invisible ? 0.2 : 1, 0.1);

if keyboard_check_released(vk_enter) {
	playerDeath();
}

switch(state){

	case PLAYER_STATE.FREE: {
	
		playerGravity();
		playerFreeMovement();
		playerFreeCollision();
		playerCheckCast();
		break;
	
	}
	
	case PLAYER_STATE.WALL_SLIDING: {
	
		playerWallSlideMovement();
		playerGravity(0.1);
		break;
	
	}
	
	case PLAYER_STATE.GRAPPLE_THROW: {
	
		playerGravity()
		playerGrapplingMovement();
		playerCollision();
		break;
	
	}
	
	case PLAYER_STATE.GRAPPLED: {
	
		playerGrappledMovement();
		playerCollision();
		break;
		
	}
	
	case PLAYER_STATE.DASHING: {
	
		playerDashMovement();
		playerCollision();
		break;
	
	}
	
	case PLAYER_STATE.GROUNDED: {
		
		playerGroundedMovement();
		break;
		
	}
	
	
}

playerPostState();

playerProcessAbilities();

//ppfx_id.SetEffectParameter(FX_EFFECT.MOTION_BLUR, PP_MOTION_BLUR_ANGLE, movvec.dir());
//ppfx_id.SetEffectParameter(FX_EFFECT.MOTION_BLUR, PP_MOTION_BLUR_RADIUS, dash_blend * 0.2);

playerProcessEffects();

if state != PLAYER_STATE.DEAD {
	playerProcessAnimations();
}

playerCalculateFrame(rotation_offset);

playerUpdateServer();

playerProcessCamera();
