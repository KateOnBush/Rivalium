// @description Insert description here
// You can write your code in this editor

playerSurf = -1;

invisible = false;
invisible_blend = 1;
free_blend = 0;

sortedframe = [];
rotation_offset = 0;
length_before_dash = 0;
cdir = 1;


viewmat = matrix_build_lookat(0, 0, 0, 0, 0, 0, 0, 1, 0);
projmat = matrix_build_projection_perspective_fov(90, 16/9, 3, 8000);

playerInitShader();

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

state = PLAYER_STATE.FREE;

slide_side = 1;



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

shoot_dir = 0;

animation_blend_speed = 0.2;

ssx = 0;
ssy = 0;
ftimer = 0;
screenshake = {
	
	intensity: 0,
	frequency: 0,
	duration: 0
	
}

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

filters = [];

wall_side = 0;

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
k_move = false;

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