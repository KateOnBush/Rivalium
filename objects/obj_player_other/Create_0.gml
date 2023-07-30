// @description Insert description here
// You can write your code in this editor

state = PLAYER_STATE.FREE;
invisible = false;
invisible_blend = 0;
sortedframe = [];
rotation_offset = 0;
free_blend = 1;

ux = 0;
uy = 0;

playerSurf = -1;

characters = setupCharacterData();

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

updated = 0;

char = characters[character_id-1];

_x = 0;
_y = 0;

spd = char.speed;
sprite = char.sprite
offset = [sprite_get_xoffset(sprite),sprite_get_yoffset(sprite)]

run = 0

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

cdir = 1;

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
animation_blend_speed = 0.2;

animation_played_priority = 0;

double_jump = false;

hitind = 0;

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
pushed_blend = 0;

movvec = new Vector2(0,0);

dir = 1;