/// @description Insert description here
// You can write your code in this editor

game_set_speed(60, gamespeed_fps);

sprite = base_character_kenn;

pos = [];

global.animation = [[array_create(sprite_get_number(sprite)+2,0),0]]

global.selected_keyframe = 0

global.playing = false

global.selected_bone = 0

objs = [];

moveTemp = 0;

base = base_character(1)

show_bones = false;

move_coords=[0,0]
init_coords=[0,0]

offset = [sprite_get_xoffset(sprite),sprite_get_yoffset(sprite)]

selected = 1;

play_quad = false

animspd=1;

dir = 1;

animfr=0;

clicked_coords = [0,0]

starting_angle = 0;

clicked_keyframe = -1;

currentframe = array_create(sprite_get_number(sprite)+2,0)