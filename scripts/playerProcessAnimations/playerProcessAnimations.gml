function playerProcessAnimations(){

var fxflip=0;
var _gdir = point_direction(x, y - 10, grappling_coords[0],grappling_coords[1]);

if flipping && state == PLAYER_STATE.FREE {

	flip = clamp(flip + 0.025*dtime, 0, 1);
	fxflip = easeInOutSine(flip);
	rotation_offset = (flipping_forward ? 1 - fxflip : fxflip) * 360;

} else if slide && state == PLAYER_STATE.FREE {

	rotation_offset = abs(angle_difference(movvec.dir(), -90)) - 90;

} else if state == PLAYER_STATE.GRAPPLED {
	
	rotation_offset = dir > 0 ? _gdir : 180 - _gdir;

} else rotation_offset -= angle_difference(rotation_offset, 0) * (1 - power(0.1, dtime));

if flipping flip_blend = dtlerp(flip_blend,1,0.1);
else flip_blend = dtlerp(flip_blend,0,0.1);

if (flip == 1) flipping = false;

if on_ground flipping = false;

run = dtlerp(run,clamp(movvec.length()/6,0,1),0.2)

run = clamp(run,0,1)

ani = ani + spdboost*global.dt/60;

if !on_ground {
	
	jump_blend = dtlerp(jump_blend,1,0.1)

} else jump_blend = dtlerp(jump_blend,0,0.1);

jump_prep = clamp(jump_prep-0.1,0,1)

jump_prep_blend = dtlerp(jump_prep_blend,jump_prep,0.6)

wall_blend = dtlerp(wall_blend, state == PLAYER_STATE.WALL_SLIDING, 0.3);

jump_fast_prog = dtlerp(jump_fast_prog,clamp(abs(movvec.x/15),0,1),0.08)

grapple_blend = dtlerp(grapple_blend, state == PLAYER_STATE.GRAPPLED ,0.2);

grounded_blend = dtlerp(grounded_blend, state == PLAYER_STATE.GROUNDED, 0.2)

grounded = max(grounded - 1*dtime,0);

pushed_blend = dtlerp(pushed_blend, movvec.x*dir<-1.5, 0.3);

grapple_throw_blend = dtlerp(grapple_throw_blend, state == PLAYER_STATE.GRAPPLE_THROW, 0.4)

animation_played_prog += global.dt*animation_played_speed/60;

animation_playing_blend = dtlerp(animation_playing_blend, animation_playing, animation_blend_speed);

dash_blend = dtlerp(dash_blend, dash>0 ? 1 : 0, 0.2);

if state == PLAYER_STATE.FREE {
	free_blend = dtlerp(free_blend, 1, 0.01);
} else free_blend = 0;

switch(state){

	case PLAYER_STATE.FREE: {
		
		var jump_prog = clamp(1-(1+clamp(-movvec.y/4,-1,1))/2,0,0.99);
		slide_blend = dtlerp(slide_blend, slide, 0.25);
		
		if free_blend > 0.99 {
			currentframe = animation_get_frame(char.anims.animation_idle, ani*0.4 mod 1);
		} else currentframe = animation_blend(currentframe, animation_get_frame(char.anims.animation_idle, ani*0.4 mod 1), free_blend);

		if run > 0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_run,ani*(1.35*spd/27) mod 1), run * free_blend);
		if jump_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_jump,jump_prog),jump_blend * free_blend);
		if jump_fast_prog*jump_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_jump_fast,jump_prog),jump_fast_prog * jump_blend * free_blend);
		if animation_playing_blend > 0.01 and !animation_played_priority step_animation();
		if pushed_blend>0.01 currentframe = animation_blend(currentframe, animation_get_frame(char.anims.animation_pushed, ani*0.5 mod 1), pushed_blend * free_blend);
		if flip_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_flip, 0), flip_blend * free_blend)
		if slide_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_slide, 0), slide_blend * free_blend)
	
		if animation_playing_blend > 0.01 and animation_played_priority step_animation();
	
		break;
	
	}
	
	case PLAYER_STATE.DASHING: {
	
		if dash_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_dash,0), dash_blend);
		break;	

	}

	case PLAYER_STATE.WALL_SLIDING: {
	
		if wall_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_wall,0),wall_blend);
		break;
	
	}
	
	case PLAYER_STATE.GRAPPLE_THROW: {
	
		if grapple_throw_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_grapple_throw, abs(angle_difference(-90,_gdir))/180),grapple_throw_blend);
		break;
	
	}
	
	case PLAYER_STATE.GROUNDED: {
	
		if grounded_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_grounded,0),grounded_blend)
		break;
	
	}

	case PLAYER_STATE.GRAPPLED: {
	
		if grapple_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_grapple, 0) ,grapple_blend);
		break;
	
	}

}




}