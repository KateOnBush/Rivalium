// @description Insert description here
// You can write your code in this editor 

//INPUTS

input_left = get_input(input.keyboard, ord("Q"));
input_right = get_input(input.keyboard, ord("D"));
input_up = get_input(input.keyboard, ord("Z"));
input_down = get_input(input.keyboard, ord("S"));

input_grapple = get_input(input.keyboard, vk_space);
input_dash = get_input(input.keyboard, vk_shift);

input_basicAttack = get_input(input.mouse, mb_left);
input_basicAttackAlternate = get_input(input.mouse, mb_right);

input_ability1 = get_input(input.keyboard, ord("A"));
input_ability2 = get_input(input.keyboard, ord("E"));
input_ultimate = get_input(input.keyboard, ord("X"));

rec_mx = 0;
rec_my = 0;

//----------



characters = setupCharacterData();

character_id = 1;

function bone_depth_sorting(bone1, bone2){

	return currentframe[bone2][4] - currentframe[bone1][4];

}

last_update = current_time;

zoom = 3;

pushed_blend = 0;

hitind = 0;

rec_x = 0;
rec_y = 0;

health_red_go = 0;

effects_str = "";

hitind = 1;

function hit(){

	hitind = 1;
	screen_shake(10, 100, 0.05);

}

castedAbility = 0;

zoom = 0;

inUltimate = false;

playerEffects = [];

mousex = 0;
mousey = 0;

updateDataBuffer = buffer_create(global.dataSize, buffer_fixed, 1);

animation_playing = 0;
animation_playing_blend = 0;
animation_played = [];
animation_played_prog = 0;
animation_played_speed = 1;
animation_played_type = 0;
animation_played_quadratic = false;
animation_played_bones = [];
animation_played_priority = false;

HUDalpha = 1;

casting = false;

camera = {

	id: view_camera[0],
	x: 0,
	y: 0,
	z: 0,
	tilt: 0,
	fov: 80

}

ultimate_zoom = {

	amount: 0,
	time: 0,
	easeinf: function(n){},
	easeoutf: function(n){},
	easeintime: 0,
	_in: 0,
	easeouttime: 0,
	_out: 0

}

spdlarg = 0;

p = 0;

surf_refresh_rate = 0;
surf_behind = -1;

function perform_flip(_forward, _start){

	flipping = true;
	flipping_forward = _forward;
	flip = _start;
	
	if global.connected {
	
		var buff = buffer_create(global.dataSize, buffer_fixed, 1);
		buffer_seek(buff, buffer_seek_start, 0);
		buffer_write(buff, buffer_u8, SERVER_REQUEST.FLIP);
		buffer_write(buff, buffer_u8, _forward);
		buffer_write(buff, buffer_u8, round(_start*100))
		network_send_raw(obj_network.server, buff, buffer_get_size(buff));
	
	}

}

shoot_dir = 0;

animation_blend_speed = 0.2;

function play_animation(animation, speed, type, bones = [], priority = false, blendspeed = 0.2){

	animation_playing = 1;
	animation_played_speed = speed;
	animation_played_prog = 0;
	animation_played_type = type;
	animation_played = animation;
	animation_played_bones = bones;
	animation_played_priority = priority;
	animation_blend_speed = blendspeed;

}

function setup_character(n){
	
	character_id = n;
	char = characters[character_id-1];
	spd = char.speed;
	sprite = char.sprite
	offset = [sprite_get_xoffset(sprite),sprite_get_yoffset(sprite)]
	currentframe = animation_get_frame(char.anims.animation_idle, 0);
	base = char.base;
	
}

function step_animation(){

	if animation_played_type = animation_type_full {
	
		currentframe = animation_blend(currentframe, animation_get_frame(animation_played, animation_played_prog), animation_playing_blend);
		
	} else if animation_played_type = animation_type_partial{
	
		currentframe = animation_blend_partial(currentframe, animation_get_frame(animation_played, animation_played_prog), animation_playing_blend, animation_played_bones);
	
	}

	if animation_played_prog >= 0.99 {
	
		animation_playing = 0;
		animation_played_prog = 0.99;
	
	}

}

ssx = 0;
ssy = 0;
ftimer = 0;
screenshake = {
	
		intensity: 0,
		frequency: 0,
		duration: 0
	
	}

/*backgroundlay = layer_create(50)
background = layer_background_create(backgroundlay, Sprite27);
bg = {

	width: sprite_get_width(Sprite27),
	height: sprite_get_height(Sprite27)

}*/

mesh = penguin_load("COOLSTUFF.derg", global.v_format);

healthbefore = 0;

playerhealth = 100;
playerhealthmax = 100;

ultimatecharge = 0;
ultimatechargemax = 100;

ultimatecharge_blend = 0;

health_blend = 0;
health_blend_red = 0;

char = characters[character_id-1];

ultimatePart = part_system_create();
ult = part_type_create();
part_system_depth(ultimatePart, 5)

part_system_automatic_draw(ultimatePart, false)
part_type_sprite(ult, fire_particle, false, false, true)

lines = part_system_create();
linepart = part_type_create();
linethreshold = 0;

show_debug_overlay(true)

part_type_sprite(linepart,line_particle,false,false,false);
part_type_alpha3(linepart,0, 0, 0)
part_type_direction(linepart, 0, 360, 0, 0)
part_type_orientation(linepart, 0, 0, 0, 0, true)

linespeed = part_type_create();

part_type_sprite(linespeed,line_particle,false,false,false);
part_type_size(linespeed, 0.4, 0.6, 0, 0)
part_type_color2(linespeed, c_white, c_ltgray)
part_type_alpha2(linespeed, 0.3, 0)

linespeedblend = 0;

part_system_automatic_draw(lines, false)

filters = [];

function Filter(asprite, adepth, aalpha) constructor{

	sprite = asprite;
	depth = adepth;
	alpha = 0;
	maxalpha = aalpha;
	removing = false;

}

function addFilter(filter, depth, maxalpha){

	var f = new Filter(filter, depth, maxalpha);

	if !array_contains_compare(filters, f, function(a, b){ if a.sprite == b.sprite return true; return false;}){
	
		array_push(filters, f);
	
	}
	
	array_sort(filters, function(a, b){ return b.depth - a.depth; })

}

function removeFilter(filter){

	var struct = {filter: filter};
	var ind = array_find_by_function(filters, method(struct, function(a){ return a.sprite == filter; }));
	if ind != -1 filters[ind].removing = true;

}

spdboost = 1;
spd = char.speed;
sprite = char.sprite
offset = [sprite_get_xoffset(sprite),sprite_get_yoffset(sprite)]

var c = char.abilities.ultimate.color;
var h, s, v;
h = color_get_hue(c);
s = color_get_saturation(c)
v = color_get_value(c);

col1 = c;
col2 = make_color_hsv(h+5,s*2/3,v+2);
col3 = make_color_hsv(h+10,s*1/3,v+5);

run = 0

pos = [];

ani = 0;

currentframe = animation_get_frame(char.anims.animation_idle, 0);

base = char.base;

vel = 0;

grounded = 0;
grounded_blend = 0;

jumping = false;

jump_prep = 0;

jump_prep_blend = 0;

jump_fast_prog = 0;

on_ground = false;

jump_blend = 0;

flip = 0

flipping = false

flip_blend = 0

dash = 0;

dash_blend = 0;

dash_cooldown = 0;

wall_slide = 0;

wall_blend = 0;

double_jump_boost = false;
slope_angle = 0;

slide = 0;
slide_blend = 0;
slide_cooldown = 0;
slope_blend = 0;

function cast_ability(a, n){

	with(self){

		switch(a){
			
			case 0:
					
				char.abilities.basic_attack.cast(n);
				break;
					
			case 1:
					
				char.abilities.ability1.cast(n);
				break;
					
			case 2:
					
				char.abilities.ability2.cast(n);
				break;
					
			case 3:
					
				char.abilities.ultimate.cast(n);
				break;
				
					
			
	}
	
	}

}

double_jump = false;

grappling_coords_init = [0,0];
grappling_coords = [0,0];
grappling_len = 0;
grappled = 0;
grappling = 0;
grapple_throw_blend = 0;

grapple_cooldown = 0;

grapple_blend = 0;

flipping_forward = 0;

grap_grav = 0;

movvec = new Vector2(0,0);

dir = 1;