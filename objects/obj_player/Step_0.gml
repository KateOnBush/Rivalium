playerInputs()

var wasOnGround = on_ground,
	initialVelocity = movvec.length();

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
invisible_blend_eff = dtlerp(invisible_blend_eff, invisible, 0.05);

if keyboard_check_released(vk_enter) {
	playerDeath();
}

if obj_gameplay.currentState == GameState.PREROUND or obj_gameplay.currentState == GameState.STARTING {
	state = PlayerState.BLOCKED;
	preroundBlend = dtlerp(preroundBlend, 1, 0.1);
	timeText = string(obj_gameplay.startingIn);
} else {
	preroundBlend = dtlerp(preroundBlend, 0, 0.1);
	timeText = "BATTLE!";
}

switch(state){

	case PlayerState.FREE: {
	
		playerGravity();
		playerFreeMovement();
		playerFreeCollision();
		playerCheckCast();
		break;
	
	}
	
	case PlayerState.WALL_SLIDING: {
	
		playerWallSlideMovement();
		playerGravity(0.1);
		break;
	
	}
	
	case PlayerState.GRAPPLE_THROW: {
	
		playerGravity()
		playerGrapplingMovement();
		playerCollision();
		break;
	
	}
	
	case PlayerState.GRAPPLED: {
	
		playerGrappledMovement();
		playerCollision();
		break;
		
	}
	
	case PlayerState.DASHING: {
	
		playerDashMovement();
		playerCollision();
		break;
	
	}
	
	case PlayerState.GROUNDED: {
		
		playerGroundedMovement();
		break;
		
	}
	
	
}

playerPostState();

playerProcessAbilities();

ppfx_id.SetEffectParameter(FX_EFFECT.MOTION_BLUR, PP_MOTION_BLUR_ANGLE, movvec.dir());
ppfx_id.SetEffectParameter(FX_EFFECT.MOTION_BLUR, PP_MOTION_BLUR_RADIUS, dash_blend * 0.18);

//invisible effect
ppfx_id.SetEffectParameter(FX_EFFECT.CHROMATIC_ABERRATION, PP_CHROMABER_INTENSITY, invisible_blend_eff * 22);
ppfx_id.SetEffectParameter(FX_EFFECT.VIGNETTE, PP_VIGNETTE_INTENSITY, invisible_blend_eff * 0.6);
ppfx_id.SetEffectParameter(FX_EFFECT.LENS_DISTORTION, PP_LENS_DISTORTION_AMOUNT, invisible_blend_eff * -0.28);
ppfx_id.SetEffectParameter(FX_EFFECT.SHOCKWAVES, PP_SHOCKWAVES_AMOUNT, invisible_blend_eff * 0.75);

ppfx_id.SetEffectParameter(FX_EFFECT.SPEEDLINES, PP_SPEEDLINES_CONTRAST, lerp(0.35, 0.55, min(abs(movvec.length() / 40), 1)));


playerProcessEffects();

if state != PlayerState.DEAD {
	playerProcessAnimations();
}

playerCalculateFrame(rotation_offset);

playerUpdateServer();

playerProcessCamera();

var new_run_dust = (run_ani * 2) mod 1;
if movvec.length() > 8 && on_ground && (new_run_dust < run_dust)  {
	part_particles_create(global.partSystem, x, y + 32, gParts.dust, 3 + irandom(3));
}
run_dust = (run_ani * 2) mod 1;

if (wasOnGround ^ on_ground) {
	part_particles_create(global.partSystem, x, y + 32, gParts.dust, initialVelocity + irandom(initialVelocity));
}
