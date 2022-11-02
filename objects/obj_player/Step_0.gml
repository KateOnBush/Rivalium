/// @description Insert description here
// You can write your code in this editor

//Really Cool!


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

mousex = global.mouse.get_x();
mousey = global.mouse.get_y();

part_type_size(ult,0.8,1.5,0,0.05*global.dt)
part_type_life(ult, fps*2, fps*3)
part_type_speed(ult, 0.35*global.dt, 0.6*global.dt, 0, 0.01*global.dt)
part_type_direction(ult, 80, 100, 0, 5);
part_type_color3(ult, col1, col2, col3)
part_type_alpha3(ult, 0.2, 0.8, 0)
part_type_orientation(ult, -10, 10, 0, 4*global.dt, false)

part_type_speed(linepart, 16*global.dt, 20*global.dt, 0, 0);

linespeedblend = dtlerp(linespeedblend, dash>0 or (spdboost>1 && movvec.length()>10), 0.4);

part_type_life(linespeed, fpstime*0.2, fpstime*0.25)
part_type_orientation(linespeed, movvec.dir(), movvec.dir(), 0, 0, 0);

if surf_refresh_rate <= 0 && linespeedblend > 0.01 {
	surf_refresh_rate = 2.5;
	repeat(5){
		var _e = random(40)-20;
		part_particles_create(global.partSystemBehind, x+lengthdir_x(_e, movvec.dir()+90), y+lengthdir_y(_e, movvec.dir()+90), linespeed, 1);
	}
}

linethreshold = dtlerp(linethreshold, movvec.length()>12 ? min((movvec.length()-12)/15,1)*0.9+0.1 : 0, 0.08);

part_type_alpha3(linepart, 0, 0, 0.8*linethreshold)
part_type_life(linepart, fps*1.3, fps*1.7)

surf_refresh_rate -= global.dt;

/*if surf_refresh_rate <= 0 && linespeedblend > 0.01 {
	
	surf_refresh_rate = 5;
	
	surface_set_target(surf_behind);
	
	draw_clear_alpha(c_white, 0);
	
	for(var i = sprite_get_number(sprite)-1; i >= 0;i--){
		
		//gpu_set_fog(true, c_white, 0, 0)
		draw_sprite_ext(sprite,i,48+pos[i][0],48+pos[i][1],dir,1,pos[i][2]*dir,c_white,1)
		//gpu_set_fog(false, c_white, 0, 0)

	}
	
	surface_reset_target()

	var s = sprite_create_from_surface(surf_behind, 0, 0, 96, 96, false, false, 48, 48);
	part_type_sprite(linespeed, s, false, false, false)
	part_particles_create(global.partSystemBehind, x, y, linespeed, 1)
	sprite_delete(s);

}*/

ultimatecharge = min(ultimatecharge, ultimatechargemax)

#region Networking

if global.connected and current_time - last_update >= 15 {

	if (!buffer_exists(updateDataBuffer)) updateDataBuffer = buffer_create(global.dataSize, buffer_fixed, 1);

	buffer_seek(updateDataBuffer, buffer_seek_start, 0);
	buffer_write(updateDataBuffer, buffer_u8, 2)
	buffer_write(updateDataBuffer, buffer_s32, round(x*100))
	buffer_write(updateDataBuffer, buffer_s32, round(y*100))
	buffer_write(updateDataBuffer, buffer_s32, round(movvec.x*100))
	buffer_write(updateDataBuffer, buffer_s32, round(movvec.y*100))
	buffer_write(updateDataBuffer, buffer_u8, on_ground)
	buffer_write(updateDataBuffer, buffer_u8, round(jump_prep*100))
	buffer_write(updateDataBuffer, buffer_u8, wall_slide)
	buffer_write(updateDataBuffer, buffer_u8, grappling)
	buffer_write(updateDataBuffer, buffer_u8, grappled)
	buffer_write(updateDataBuffer, buffer_s8, dir)
	buffer_write(updateDataBuffer, buffer_u8, dash>0 ? 1 : 0)
	buffer_write(updateDataBuffer, buffer_u8, slide)
	buffer_write(updateDataBuffer, buffer_u8, grounded)
	buffer_write(updateDataBuffer, buffer_u8, round(slope_blend*100))
	buffer_write(updateDataBuffer, buffer_s32, round(mousex*100));
	buffer_write(updateDataBuffer, buffer_s32, round(mousey*100));
	network_send_raw(obj_network.server, updateDataBuffer, buffer_get_size(updateDataBuffer));
	
	last_update = current_time;

}

#endregion


#region Movement

var gravityvec = new Vector2(0, grav*global.dt)

gravityvec = gravityvec.multiply(wall_slide==1 ? 0.1: 1);

if !grappled movvec = movvec.add(gravityvec);

if slide==0 && !grappled {
	if on_ground {
	
		var l = movvec.length()
		l = dtlerp(l,0,0.1);
		movvec.x = lengthdir_x(l,movvec.dir());
		movvec.y = lengthdir_y(l,movvec.dir());
	
	} else {
		movvec.x = dtlerp(movvec.x,0,0.035)
	}

} else if !grappled movvec.x = dtlerp(movvec.x,0,0.04)

var djratio = 1.5;
var spddj = (double_jump_boost ? djratio : 1);

var k_right = keyboard_check(ord("D")) && !casting;
var k_left = keyboard_check(ord("Q")) && !casting;
var k_dash = keyboard_check(vk_lshift) && !casting;
var k_jump = keyboard_check_pressed(ord("Z")) && !casting;
var k_slide = keyboard_check(ord("S")) && !casting;
var k_grapple = keyboard_check(vk_space) && !casting;

if (k_right || k_left || slide) and movvec.length()>0.01 dir = sign(movvec.x);
if (dir==0) dir = 1;


if k_right and slide==0 and !grappled and grounded == 0 {

	movvec.x = dtlerp(movvec.x,spd*spddj*spdboost,on_ground ? 0.08 : 0.02);

} 
if k_left and slide==0 and !grappled and grounded == 0 {

	movvec.x = dtlerp(movvec.x,-spd*spddj*spdboost,on_ground ? 0.08 : 0.02);

}

if !on_ground and (k_right or k_left){

	var t = k_right ? 1 : -1;
	
	if place_meeting(x+t,y,obj_obstacle_wall){
	
		if wall_slide == 0 movvec.y *= 0.05
		wall_slide = 1;
		double_jump_boost = false;
		dir = -t;
		if k_jump {	
				
			movvec.x = -20*t;
			movvec.y = -12;
				
		}
	
	} else wall_slide = 0;
	
} else {

	wall_slide = 0;

}

if slide and slope_angle > 3 {

	var l = movvec.length();
	var b = 0;
	if movvec.y<0 b = 180;

	l = dtlerp(l,80,slope_angle/4000)

	movvec.x = lengthdir_x(l,b+movvec.dir());
	movvec.y = lengthdir_y(l,b+movvec.dir());

}

if k_grapple && !grappling && !grappled && grapple_cooldown == 0 && !on_ground and grounded ==0{

	grappling_coords_init = [global.mouse.get_x(), global.mouse.get_y()]
	if global.connected {
	
		var buff = buffer_create(global.dataSize, buffer_fixed, 1);
		buffer_seek(buff, buffer_seek_start, 0);
		buffer_write(buff, buffer_u8, 3);
		buffer_write(buff, buffer_s32, round(grappling_coords_init[0]*100))
		buffer_write(buff, buffer_s32, round(grappling_coords_init[1]*100))
		buffer_write(buff, buffer_u8, 0);
		network_send_raw(obj_network.server, buff, buffer_get_size(buff));
		
		buffer_delete(buff);
	
	}

	grappling_coords = [x,y]
	grappling = true;
	grappled = false
	grappling_len = 0;
	

}

if k_grapple && grappled && !on_ground and grounded == 0{
	
	var ray = point_distance(x,y,grappling_coords[0],grappling_coords[1])
	var d = point_direction(grappling_coords[0],grappling_coords[1],x,y)
	
	grap_grav += grav*global.dt;
	
	var _accel = -0.1* dcos(d);
	vel += _accel*global.dt;
	d += vel*global.dt;
	vel *= power(sqrt(0.98), global.dt);
	
	dir = sign(vel)
	
	movvec.x = (grappling_coords[0] + lengthdir_x(ray, d) - x)/global.dt;
	movvec.y = grap_grav + (grappling_coords[1] + lengthdir_y(ray, d) - y)/global.dt;
	
	if point_distance(x+movvec.x*global.dt,y+movvec.y*global.dt,grappling_coords[0],grappling_coords[1])>grappling_len{
		var dis = sign(vel)*movvec.length();
		var ray = grappling_len;
		var d = point_direction(grappling_coords[0],grappling_coords[1],x,y)
		
		var _ang = 2.65 * darcsin(dis/(2*ray));
		
		movvec.x = (grappling_coords[0] + lengthdir_x(ray, d+_ang*global.dt) - x)/global.dt;
		movvec.y = (grappling_coords[1] + lengthdir_y(ray, d+_ang*global.dt) - y)/global.dt;
		
		grap_grav = 0;
		
	}
	
	

} else if (!k_grapple or on_ground) && grappled{
	
	var _d = point_direction(grappling_coords[0],grappling_coords[1],x,y)
	var _e = clamp(sign(vel)*angle_difference(270, _d),0,180)
	grappled = false;
	grappling = false;	
	if !on_ground and movvec.length()>8 perform_flip(false, _e/360)
	grapple_cooldown = 40;
	
	
}

grapple_cooldown = max(grapple_cooldown-1,0);

if grappling && !grappled{

	grappling_len += 25*global.dt;
	var d = point_direction(x,y-16,grappling_coords_init[0],grappling_coords_init[1]);
	
	grappling_coords = [x+lengthdir_x(grappling_len, d),y+lengthdir_y(grappling_len, d)]
	
	var de = point_direction(x,y-16,grappling_coords[0],grappling_coords[1]);
	dir = -sign(angle_difference(-90,de));
	
	if collision_line(x,y,grappling_coords[0],grappling_coords[1],obj_solid,true,true){
	
		while(collision_line(x,y,grappling_coords[0],grappling_coords[1],obj_solid,true,true)){
		
			grappling_len -= 1;
			grappling_coords = [x+lengthdir_x(grappling_len, d),y+lengthdir_y(grappling_len, d)]
			if !collision_line(x,y,grappling_coords[0],grappling_coords[1],obj_solid,true,true){
				grappling_len += 1;
				grappling_coords = [x+lengthdir_x(grappling_len, d),y+lengthdir_y(grappling_len, d)]
				break;
			}
			
		}
		
		grappled = true;
		var _len = movvec.length();
		var _de = point_direction(x,y,grappling_coords[0],grappling_coords[1]);
		var _ray = point_distance(x,y,grappling_coords[0],grappling_coords[1]);
		
		var _nlen = _len * dsin(angle_difference(movvec.dir(),_de))
		
		vel = - 2.65 * darcsin(_nlen/(2*_ray));
		
		if global.connected {
	
			var buff = buffer_create(global.dataSize, buffer_fixed, 1);
			buffer_seek(buff, buffer_seek_start, 0);
			buffer_write(buff, buffer_u8, 3);
			buffer_write(buff, buffer_s32, round(grappling_coords[0]*100))
			buffer_write(buff, buffer_s32, round(grappling_coords[1]*100))
			buffer_write(buff, buffer_u8, 1);
			network_send_raw(obj_network.server, buff, buffer_get_size(buff));
			
			buffer_delete(buff);
	
		}

		
		
	}
	
	if grappling_len > point_distance(x,y-16,grappling_coords_init[0],grappling_coords_init[1]) && !grappled{
	
		grappling = false;
		grappled = false;
		grapple_cooldown = 40;
	
	}
	

}


slope_angle = 0;

var slope_moving = false;

on_ground = false;

if place_meeting(x,y+4,obj_solid){

	on_ground = true;
	double_jump = false;
	double_jump_boost = false;

}

#endregion 


#region Collision System


if place_meeting(x+movvec.x*global.dt,y,obj_solid){

	if on_ground {
	
		var aplus = 0;
		var angle = 45;
		var dist = movvec.length();
		while (place_meeting(x+sign(movvec.x)*lengthdir_x(dist,aplus),y+lengthdir_y(dist,aplus),obj_solid) && aplus <= angle) aplus += 1;
	
		if !place_meeting(x+sign(movvec.x)*lengthdir_x(dist,aplus),y+lengthdir_y(dist,aplus),obj_solid){
	
			movvec.x = sign(movvec.x)*lengthdir_x(dist,aplus);
			movvec.y = lengthdir_y(dist,aplus);
			slope_angle = aplus;
			slope_moving = true;
			if k_jump{
			
				movvec.y = -13;
			
			}
	
		}
	}
	
	for(var n =1; n <= 10; n++){

		if(!place_meeting(x+movvec.x*(10-n)*global.dt/10,y,obj_solid)) && !slope_moving{
	
			movvec.x *= (10-n)/10;
			break;
	
		}

	}
	
}

slide_cooldown = clamp(slide_cooldown-1*global.dt,0,slide_cooldown+1)

if place_meeting(x+movvec.x*global.dt,y+movvec.y*global.dt,obj_solid){

	if on_ground or slide {
		var b = 1;
		if !place_meeting(x-1,y,obj_solid) b = -1;
		var aplus = -89;
		var angle = slide ? -5 : -46;
		var dist = movvec.length();
		while (place_meeting(x+b*lengthdir_x(dist,aplus),y+lengthdir_y(dist,aplus),obj_solid) && aplus <= angle) aplus += 1;
		
		if !place_meeting(x+b*lengthdir_x(dist,aplus),y+lengthdir_y(dist,aplus),obj_solid){

			movvec.x = b*lengthdir_x(dist,aplus-1);
			movvec.y = lengthdir_y(dist,aplus-1);
			slope_angle = abs(aplus-1);
			slope_moving = true;
			slide = 1;

		}
	}

	if movvec.y>0 and !on_ground{
	
		jumping = false;
		jump_prep = clamp(abs(movvec.y)/10,0,1);
	
	}
	
	if movvec.y>25 and !on_ground and !slide{
	
		grounded = 30;
	
	}
	
	for(var n =1; n <= 10; n++){

		if(!place_meeting(x+movvec.x*global.dt,y+movvec.y*(10-n)*global.dt/10,obj_solid)) && !slope_moving{
	
			movvec.y *= (10-n)/10;
			break;
	
		}
	
	}

}

x += movvec.x*global.dt;
y += movvec.y*global.dt;

var slid = slide;

if k_slide and movvec.length()>1 and on_ground and slide_cooldown == 0 and grounded == 0{

	slide = 1;

} else if !slope_moving{
	
	slide = 0;
	if slid slide_cooldown = 60;
	
}

if k_dash and dash_cooldown==0 and wall_slide == 0 and !grappled and !grappling and !slide and grounded == 0 and movvec.length() > 0{

	dash = 1;
	dash_cooldown = 60;
	if k_left movvec.x = -abs(movvec.x);
	if k_right movvec.x = abs(movvec.x);

}

if on_ground flip = 0;

dash_cooldown = max(dash_cooldown-1*global.dt,0);

dash = max(dash-0.05*global.dt,0);

if dash>0 {

	movvec.y = 0;
	movvec.x = sign(movvec.x)*25*spdboost-dash*5
	if movvec.length() < 0.1 dash = 0;

}

dash_blend = dtlerp(dash_blend, dash>0 ? 1 : 0, 0.4);

if on_ground and k_jump and wall_slide == 0 and !grounded{

	on_ground = false;
	if slide == 1 and slope_angle != 0{
	
		movvec.x += lengthdir_x(13, 90 - dir*slope_angle)*global.dt;
		movvec.y = lengthdir_y(13, 90 - dir*slope_angle)
		slide = 0;
	
	} else movvec.y = -13;

} else if !on_ground and !double_jump and dash==0 and k_jump and wall_slide == 0{
	
	double_jump = true;
	double_jump_boost = true;
	movvec.y = -11;
	movvec.x *= djratio;
	if random(1) < 0.3 and movvec.length() > 13 perform_flip(true, 0);

}

#endregion


#region Animation System

playerEffects = process_effects(playerEffects);

var lerpspd = 1;
effects_str = "";
for(var t = 0; t < array_length(playerEffects); t++){
	
	var l = playerEffects[t];
	if (l.type == effecttype.boost) lerpspd *= l.data.multiplier;
	if (l.type == effecttype.slow) lerpspd /= l.data.multiplier;
	
	var efnms = ["Healing","Bleeding","Acceleration","Slowed","Invisible"];
	
	effects_str += efnms[l.type] + " : " + string(round(100*l.elapsed/l.duration)) + "%\n";
	
}

spdboost = dtlerp(spdboost, lerpspd, 0.2);


for(var s = 0; s < array_length(filters); s++){

	if filters[s].removing filters[s].alpha = dtlerp(filters[s].alpha, 0, 0.1);
	else filters[s].alpha = dtlerp(filters[s].alpha, 1, 0.1);

	if filters[s].alpha < 0.05 and filters[s].removing array_delete(filters, s, 1);

}

var fxflip=0;

if flipping {

	flip = clamp(flip+0.025*global.dt,0,1);
	fxflip = flip < 0.5 ? 2 * flip * flip : 1 - power(-2 * flip + 2, 2) / 2;

}

if flipping flip_blend = dtlerp(flip_blend,1,0.1);
else flip_blend = dtlerp(flip_blend,0,0.1);

if (flip == 1) flipping = false;

if on_ground flipping = false;


run = dtlerp(run,clamp(movvec.length()/6,0,1),0.2)

run = clamp(run,0,1)

ani = ani + spdboost*global.dt/60;

currentframe = animation_get_frame(char.anims.animation_idle, ani*0.4 mod 1, true);

currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_run,ani*(1.8*spd/27) mod 1,false), run);

if !on_ground {
	
	jump_blend = dtlerp(jump_blend,1,0.1)

} else jump_blend = dtlerp(jump_blend,0,0.1);

jump_prep = clamp(jump_prep-0.1,0,1)

jump_prep_blend = dtlerp(jump_prep_blend,jump_prep,0.6)

wall_blend = dtlerp(wall_blend,wall_slide,0.3)

var jump_prog = clamp(1-(1+clamp(-movvec.y/4,-1,1))/2,0,0.99);

slide_blend = dtlerp(slide_blend,slide,0.25);

slope_blend = dtlerp(slope_blend,slope_angle/90,0.3)

jump_fast_prog = dtlerp(jump_fast_prog,clamp(abs(movvec.x/10),0,1),0.2)

grapple_blend = dtlerp(grapple_blend,grappled,0.2);

grounded_blend = dtlerp(grounded_blend,grounded == 0 ? 0 : 1, 0.2)

grounded = max(grounded - 1*global.dt,0);

pushed_blend = dtlerp(pushed_blend, movvec.x*dir<-1.5, 0.3);

var _gdir = point_direction(x,y,grappling_coords[0],grappling_coords[1])

grapple_throw_blend = dtlerp(grapple_throw_blend, grappling ? 1 : 0, 0.4)

if jump_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_jump,jump_prog,true),jump_blend)

if jump_fast_prog*jump_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_jump_fast,jump_prog,true),jump_fast_prog*jump_blend)

if jump_prep_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_jump_prep,0,false),jump_prep_blend)

animation_played_prog += global.dt*animation_played_speed/60;

animation_playing_blend = dtlerp(animation_playing_blend, animation_playing, 0.2);

if animation_playing_blend > 0.01 and !animation_played_priority step_animation();

if pushed_blend>0.01 currentframe = animation_blend(currentframe, animation_get_frame(char.anims.animation_pushed, ani*0.5 mod 1, true), pushed_blend);

if flip_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_flip,flipping_forward ? fxflip : (1 - fxflip),false),flip_blend)

if dash_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_dash,0,false),dash_blend)

if wall_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_wall,0,false),wall_blend)

if slide_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_slide,slope_blend,false),slide_blend)

if grapple_throw_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_grapple_throw,abs(angle_difference(-90,_gdir))/180,false),grapple_throw_blend);

if grapple_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_grapple,dir == 1 ? (_gdir mod 360)/360 : (540 - _gdir mod 360)/360,false),grapple_blend)

if grounded_blend>0.01 currentframe = animation_blend(currentframe,animation_get_frame(char.anims.animation_grounded,0,false),grounded_blend)

if animation_playing_blend > 0.01 and animation_played_priority step_animation();

#endregion


#region Character data

char = characters[character_id-1];
spd = char.speed;
sprite = char.sprite
offset = [sprite_get_xoffset(sprite),sprite_get_yoffset(sprite)]
base = char.base;

char.abilities.basic_attack.step();
char.abilities.ability1.step();
char.abilities.ability2.step();
char.abilities.ultimate.step();

casting = 
char.abilities.basic_attack.iscasting || 
char.abilities.ability1.iscasting || 
char.abilities.ability2.iscasting || 
char.abilities.ultimate.iscasting;

if !casting {

	if mouse_check_button_released(mb_left){

		castedAbility = 0;
		char.abilities.basic_attack.cast(); 

	} else if mouse_check_button_released(mb_right){

		castedAbility = 0;
		char.abilities.basic_attack.cast(1);

	}

	if keyboard_check_pressed(ord("X")){

		castedAbility = 3;
		char.abilities.ultimate.cast()

	}

	if keyboard_check_pressed(ord("A")){

		castedAbility = 1;
		char.abilities.ability1.cast()	

	}
	
	if keyboard_check_pressed(ord("E")){

		castedAbility = 2;
		char.abilities.ability2.cast()	

	}

}



#endregion


#region Camera


var cam = camera.id;
var camw = camera_get_view_width(cam);
var camh = camera_get_view_height(cam)	
var camx = camera_get_view_x(cam) + camw/2;
var camy = camera_get_view_y(cam) + camh/2;

var speedy = max(movvec.length()-6,0)*3.5*sin(ani * 8);
var speedyx = lengthdir_x(speedy, ani*180/pi);
var speedyy = lengthdir_y(speedy, ani*180/pi);
var windx = 15*dsin(ani*1.1*180/pi)	
var windy = 4*dsin(ani*0.3*180/pi)	

var speedlarg = max(movvec.length()-6.5,0)*18;

spdlarg = dtlerp(spdlarg, speedlarg, 0.05);

screenshake.duration = max(screenshake.duration - global.dt/60, 0);

ftimer = max(ftimer - global.dt/60, 0);

if screenshake.duration > 0 and screenshake.frequency != 0 and ftimer == 0{

	var d = irandom(360);
	ftimer = 1/screenshake.frequency;
	var l = screenshake.intensity;
	
	ssx = lengthdir_x(l, d);
	ssy = lengthdir_y(l, d);

} else if screenshake.duration == 0{

	ssx *= 0.9;
	ssy *= 0.9;
	screenshake.intensity = 0;
	screenshake.frequency = 0;

} 

var dir_camera = false;

camera.x = dtlerp(camera.x, x+windx+speedyx+ssx+(dir_camera ? movvec.x*10 : 0), 0.1);
camera.y = dtlerp(camera.y, y+windy+speedyy+ssy+(dir_camera ? movvec.y*10 : 0), 0.1);

zoom -= 0.2*(mouse_wheel_down()-mouse_wheel_up())*dtime

zoom = clamp(zoom, 0, 1)

var z = (690+spdlarg*0.8)*(0.2 + (1-zoom)*0.8);

var t = ultimate_zoom.time
var ein = ultimate_zoom.easeintime;
var eout = ultimate_zoom.easeouttime;
var _in = ultimate_zoom._in;
var _out = ultimate_zoom._out;

if t > 0 {
	
	HUDalpha = dtlerp(HUDalpha, 0, 0.3);
	
	ultimate_zoom._in = min(ultimate_zoom._in + dtime/60, ein);
	var k = 0;
	
	k = ultimate_zoom.easeinf(_in/ein);
	
	if t <= eout{
		
		var k = 1 - ultimate_zoom.easeoutf(_out/eout);
		ultimate_zoom._out = min(ultimate_zoom._out + dtime/60, eout);
	
	}
	
	camera.z = dtlerp(camera.z, z - k * ultimate_zoom.amount, 0.95);
	

} else {
	
	camera.z = dtlerp(camera.z, z, 0.1);
	if HUDalpha < 1 HUDalpha = dtlerp(HUDalpha, 1, 0.3);
}



ultimate_zoom.time -= dtime/60;
ultimate_zoom.time = max(ultimate_zoom.time, 0);


camera.tilt = dtlerp(camera.tilt, clamp(movvec.x/8, -1, 1), 0.05)

var viewmat = matrix_build_lookat(camera.x, camera.y, -camera.z, camera.x, camera.y, 0, 0.015*camera.tilt, 1, 0);
var projmat = matrix_build_projection_perspective_fov(camera.fov, camw/camh, 3, 3000);

camera_set_view_mat(camera.id, viewmat);
camera_set_proj_mat(camera.id, projmat);

camera_apply(camera.id);

/*layer_background_xscale(background, camw/bg.width);
layer_background_yscale(background, camh/bg.height);
layer_x(backgroundlay, camx)
layer_y(backgroundlay, camy)*/


#endregion
