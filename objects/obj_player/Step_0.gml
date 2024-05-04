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

healing_timer -= dtime/60;
if healing_timer < 0 healing_timer = 0;
burning_timer -= dtime/60;
if burning_timer < 0 burning_timer = 0;

hitind = dtlerp(hitind, burning_timer > 0, 0.01);
healind = dtlerp(healind, healing_timer > 0, 0.01);

hitblend = dtlerp(hitblend, hitind, 0.5);
healblend = dtlerp(healblend, healind, 0.5);

lethalityBlend = dtlerp(lethalityBlend, lethality/10, 0.05);
resistanceBlend = dtlerp(resistanceBlend, resistance/10, 0.05);
hasteBlend = dtlerp(hasteBlend, haste/10, 0.05);

respawn_time -= dtime/60;
respawn_time = max(0, respawn_time);

ultimatecharge_blend = dtlerp(ultimatecharge_blend, ultimatecharge/ultimatechargemax, 0.08);
invisible_blend = dtlerp(invisible_blend, invisible ? 0 : 1, 0.1);
invisible_blend_eff = dtlerp(invisible_blend_eff, invisible, 0.05);
gem_holder_blend = dtlerp(gem_holder_blend, gem_holder, 0.08);

leaderboard_blend = dtlerp(leaderboard_blend, input_leaderboard.check(), 0.1);

dead_blend = dtlerp(dead_blend, state == PlayerState.DEAD, 0.1);

if (obj_gameplay.type == GameType.CASUAL) {
	preroundBlend = dtlerp(preroundBlend, obj_gameplay.currentState == CasualGameState.PREROUND, 0.1);
} else {
	preroundBlend = 0;
}

timer_real -= dtime/60;
timer = max(ceil(timer_real), 0);

switch(timer_type) {
	case TimerType.PRE_ROUND:
		timer_text = string(timer);
		timer_desc = "ROUND STARTING";
		break;
	case TimerType.NEXT_SHRINE_SPAWNS:
		timer_text = string_format_time(timer);
		timer_desc = "UNTIL ORBSTONES SPAWN";
		break;
	case TimerType.ROUND_END:
		timer_text = string_format_time(timer);
		timer_desc = "UNTIL ROUND END";
		break;
	default:
		timer_text = "";
		timer_desc = "";
		break;
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
		playerFreeCollision();
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

global.ppfx.SetEffectParameter(FX_EFFECT.MOTION_BLUR, PP_MOTION_BLUR_ANGLE, movvec.dir());
global.ppfx.SetEffectParameter(FX_EFFECT.MOTION_BLUR, PP_MOTION_BLUR_RADIUS, dash_blend * 0.18);

//invisible effect
global.ppfx.SetEffectParameter(FX_EFFECT.CHROMATIC_ABERRATION, PP_CHROMABER_INTENSITY, invisible_blend_eff * 22);
global.ppfx.SetEffectParameter(FX_EFFECT.LENS_DISTORTION, PP_LENS_DISTORTION_AMOUNT, invisible_blend_eff * -0.28);
global.ppfx.SetEffectParameter(FX_EFFECT.SHOCKWAVES, PP_SHOCKWAVES_AMOUNT, invisible_blend_eff * 0.75);

global.ppfx.SetEffectParameter(FX_EFFECT.SPEEDLINES, PP_SPEEDLINES_CONTRAST, lerp(0.35, 0.55, min(abs(movvec.length() / 40), 1)));
var vignette_color = make_color_rgb_ppfx(192 * hitblend * invisible_blend, 192 * healblend * invisible_blend, 0);
global.ppfx.SetEffectParameter(FX_EFFECT.VIGNETTE, PP_VIGNETTE_COLOR, make_color_rgb_ppfx(192 * hitblend, 192 * healblend, 0));
global.ppfx.SetEffectParameter(FX_EFFECT.VIGNETTE, PP_VIGNETTE_INTENSITY, min(1, healblend + hitblend * 0.5 + (1 - invisible_blend)) * 0.4);

global.ppfx.SetEffectParameter(FX_EFFECT.SATURATION, PP_SATURATION, 1 - 0.5 * dead_blend);

playerProcessEffects();

if state != PlayerState.DEAD {
	playerProcessAnimations();
}

playerCalculateFrame(rotation_offset);

playerUpdateServer();

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