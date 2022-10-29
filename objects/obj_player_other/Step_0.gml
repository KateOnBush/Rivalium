/// @description Insert description here
// You can write your code in this editor

char = characters[character_id-1];
spd = char.speed;
sprite = char.sprite
offset = [sprite_get_xoffset(sprite),sprite_get_yoffset(sprite)]
base = char.base;

health_blend = dtlerp(health_blend, playerhealth/playerhealthmax, 0.5);
health_blend_red = dtlerp(health_blend_red, health_blend, 0.04);
ultimatecharge_blend = dtlerp(ultimatecharge_blend, ultimatecharge/ultimatechargemax, 0.08);

char = characters[character_id-1];
spd = char.speed;
sprite = char.sprite
offset = [sprite_get_xoffset(sprite),sprite_get_yoffset(sprite)]

hitind = dtlerp(hitind, 0, 0.05);

/*  -----------------------------

MOVEMENT

--------------------------------- */

if !grappling && !grappled grappling_len = 0;

if grappling && !grappled{

	grappling_len += 25*global.dt;
	var d = point_direction(x,y-16,grappling_coords_init[0],grappling_coords_init[1]);
	
	grappling_coords = [x+lengthdir_x(grappling_len, d),y+lengthdir_y(grappling_len, d)]
	
	if grappling_len > point_distance(x,y-16,grappling_coords_init[0],grappling_coords_init[1]){
	
		grappling_coords[0] = grappling_coords_init[0];
		grappling_coords[1] = grappling_coords_init[1];
	
	}

}

if grappled {

	grappling_coords[0] = grappling_coords_init[0];
	grappling_coords[1] = grappling_coords_init[1];

}

if current_time - updated >= 40 {

	var gravityvec = new Vector2(0, grav*global.dt)

	gravityvec.multiply(wall_slide==1 ? 0.1 : 1)

	if !grappled movvec.add(gravityvec);

	var slope_moving = false;
	var slope_angle = 0;

	if place_meeting(x+movvec.x*global.dt,y,obj_solid){

		if on_ground {
	
			var aplus = 0;
			var angle = 45;
			var dist = movvec.length();
			while (place_meeting(x+global.dt*sign(movvec.x)*lengthdir_x(dist,aplus),y+global.dt*lengthdir_y(dist,aplus),obj_solid) && aplus <= angle) aplus += 1;
	
			if !place_meeting(x+sign(movvec.x)*lengthdir_x(dist,aplus),y+lengthdir_y(dist,aplus),obj_solid){
	
				movvec.x = sign(movvec.x)*lengthdir_x(dist,aplus);
				movvec.y = lengthdir_y(dist,aplus);
				slope_angle = aplus;
				slope_moving = true;
	
			}
		}
	
		for(var n =1; n <= 10; n++){

			if(!place_meeting(x+global.dt*movvec.x*(10-n)/10,y,obj_solid)) && !slope_moving{
	
				movvec.x *= (10-n)/10;
				break;
	
			}

		}
	
	}

	if place_meeting(x+movvec.x*global.dt,y+movvec.y*global.dt,obj_solid){

		if on_ground {
			var b = 1;
			if !place_meeting(x-1,y,obj_solid) b = -1;
			var aplus = -89;
			var angle = slide ? -5 : -46;
			var dist = movvec.length();
			while (place_meeting(x+b*lengthdir_x(dist,aplus),y+lengthdir_y(dist,aplus),obj_solid) && aplus <= angle) aplus += 1;
	
			if !place_meeting(x+b*lengthdir_x(dist,aplus),y+lengthdir_y(dist,aplus),obj_solid){

				movvec.x = b*lengthdir_x(dist,aplus-1);
				movvec.y = lengthdir_y(dist,aplus-1);
				slope_angle = abs(aplus);
				slope_moving = true;
				slide = 1;

			}
		}
	
		for(var n =1; n <= 10; n++){

			if(!place_meeting(x+movvec.x*global.dt,y+global.dt*movvec.y*(10-n)/10,obj_solid)) && !slope_moving{
	
				movvec.y *= (10-n)/10;
				break;
	
			}
	
		}

	}

	x += movvec.x*global.dt;
	y += movvec.y*global.dt;

}

if place_meeting(x,y+1,obj_solid){

	on_ground = true;

}


char.abilities.basic_attack.step();
char.abilities.ability1.step();
char.abilities.ability2.step();
char.abilities.ultimate.step();

/* -----------------------------------

ANIMAITON

--------------------------------- */

playerEffects = process_effects(playerEffects);

var lerpspd = 1;
for(var t = 0; t < array_length(playerEffects); t++){
	
	var l = playerEffects[t];
	if (l.type == effecttype.boost) lerpspd *= l.data.multiplier;
	if (l.type == effecttype.slow) lerpspd /= l.data.multiplier;
	
}

spdboost = dtlerp(spdboost, lerpspd, 0.2);

for(var s = 0; s < array_length(filters); s++){

	if filters[s].removing filters[s].alpha = dtlerp(filters[s].alpha, 0, 0.1);
	else filters[s].alpha = dtlerp(filters[s].alpha, 1, 0.1);

	if filters[s].alpha < 0.05 and filters[s].removing array_delete(filters, s, 1);

}

function perform_flip(_forward, _start){

	flipping = true;
	flipping_forward = _forward;
	flip = _start;

}

var fxflip=0;

if flipping {

	flip = clamp(flip+0.025*global.dt,0,1);
	fxflip = flip < 0.5 ? 2 * flip * flip : 1 - power(-2 * flip + 2, 2) / 2;

}

dash_blend = dtlerp(dash_blend, dash>0 ? 1 : 0, 0.4);

if flipping flip_blend = dtlerp(flip_blend,1,0.1);
else flip_blend = dtlerp(flip_blend,0,0.1);

if (flip == 1) flipping = false;

if on_ground flipping = false;

run = dtlerp(run,clamp(movvec.length()/6,0,1),0.2)

run = clamp(run,0,1)

ani = ani + spdboost*global.dt/60;

currentframe = animation_get_frame(char.anims.animation_idle, ani*0.6 mod 1, true);

currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_run,ani*(1.8*spd/27) mod 1,false), run);

if !on_ground {
	
	jump_blend = dtlerp(jump_blend,1,0.1)

} else jump_blend = dtlerp(jump_blend,0,0.1);

jump_prep = clamp(jump_prep-0.1*global.dt,0,1)

jump_prep_blend = dtlerp(jump_prep_blend,jump_prep,0.6)

wall_blend = dtlerp(wall_blend,wall_slide,0.3)

var jump_prog = clamp(1-(1+clamp(-movvec.y/4,-1,1))/2,0,0.99);

slide_blend = dtlerp(slide_blend,slide,0.25);

jump_fast_prog = dtlerp(jump_fast_prog,clamp(abs(movvec.x/10),0,1),0.2)

grapple_blend = dtlerp(grapple_blend,grappled,0.2);

grounded_blend = dtlerp(grounded_blend,grounded == 0 ? 0 : 1, 0.2)

var _gdir = point_direction(x,y,grappling_coords[0],grappling_coords[1])

grapple_throw_blend = dtlerp(grapple_throw_blend, grappling ? 1 : 0, 0.4)

if jump_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_jump,jump_prog,true),jump_blend)

if jump_fast_prog*jump_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_jump_fast,jump_prog,true),jump_fast_prog*jump_blend)

if jump_prep_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_jump_prep,0,false),jump_prep_blend)

animation_played_prog += global.dt*animation_played_speed/60; 

animation_playing_blend = dtlerp(animation_playing_blend, animation_playing, 0.4);

if animation_playing_blend > 0.01{

	if animation_played_type = animation_type_full {
	
		currentframe = animation_blend(currentframe, animation_get_frame(animation_played, animation_played_prog, animation_played_quadratic), animation_playing_blend);
		
	} else if animation_played_type = animation_type_partial{
	
		currentframe = animation_blend_partial(currentframe, animation_get_frame(animation_played, animation_played_prog, animation_played_quadratic), animation_playing_blend, animation_played_bones);
	
	}

	if animation_played_prog >= 1 {
	
		animation_playing = 0;
		animation_played_prog = 1;
	
	}

}

if flip_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_flip,flipping_forward ? fxflip : (1 - fxflip),false),flip_blend)

if dash_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_dash,0,false),dash_blend)

if wall_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_wall,0,false),wall_blend)

if slide_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_slide,slope_blend,false),slide_blend)

if grapple_throw_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_grapple_throw,abs(angle_difference(-90,_gdir))/180,false),grapple_throw_blend);

if grapple_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_grapple,dir == 1 ? (_gdir mod 360)/360 : (540 - _gdir mod 360)/360,false),grapple_blend)

if grounded_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_grounded,0,false),grounded_blend)