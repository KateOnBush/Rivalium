/// @description Insert description here
// You can write your code in this editor

health_blend = dtlerp(health_blend, playerhealth/playerhealthmax, 0.5);
health_blend_red = dtlerp(health_blend_red, health_blend, 0.04);
ultimatecharge_blend = dtlerp(ultimatecharge_blend, ultimatecharge/ultimatechargemax, 0.08);

char = characters[character_id-1];
if (array_length(base) != array_length(char.base)) {
	spd = char.speed;
	sprite = char.sprite
	offset = [sprite_get_xoffset(sprite),sprite_get_yoffset(sprite)]
	currentframe = animation_get_frame(char.anims.animation_idle, 0);
	base = char.base;
}

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

if current_time - updated >= 18 {

	var gravityvec = new Vector2(0, grav*global.dt)

	gravityvec.multiply(wall_slide==1 ? 0.1 : 1)

	if !grappled movvec = movvec.add(gravityvec);

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

} else {

	x = dtlerp(x, ux, 0.82);
	y = dtlerp(y, uy, 0.82);

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

playerProcessAnimations();