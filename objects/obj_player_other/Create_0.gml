// @description Insert description here
// You can write your code in this editor

setupCharacterData();

character_id = 1;

playerhealth = 100;
playerhealthmax = 100;

ultimatecharge = 0;
ultimatechargemax = 100;

health_blend_red = 0;
health_blend = 0;
ultimatecharge_blend = 0;

mousex = 0;
mousey = 0;

playerEffects = [];

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

updated = 0;

char = characters[character_id-1];

_x = 0;
_y = 0;

spd = char.speed;
sprite = char.sprite
offset = [sprite_get_xoffset(sprite),sprite_get_yoffset(sprite)]

run = 0

ani = 0;

currentframe = animation_get_frame(char.anims.animation_idle, 0, false);

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

animation_playing = 0;
animation_playing_blend = 0;
animation_played = [];
animation_played_prog = 0;
animation_played_speed = 1;
animation_played_type = 0;
animation_played_quadratic = false;
animation_played_bones = [];

function play_animation(animation, speed, type, quadratic, bones = []){

	animation_playing = 1;
	animation_played_speed = speed;
	animation_played_prog = 0;
	animation_played_type = type;
	animation_played = animation;
	animation_played_bones = bones;

}

double_jump = false;

hitind = 0;

function hit(){

	hitind = 1;

}

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

filters = [];

spdboost = 1;

mousex = 0;
mousey = 0;

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

movvec = new Vector2(0,0);

dir = 1;