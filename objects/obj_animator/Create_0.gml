/// @description Insert description here
// You can write your code in this editor

sprite = base_character_gramin

global.animation = [[array_create(sprite_get_number(sprite)+2,0),0]]

global.selected_keyframe = 0

global.playing = false

global.selected_bone = 0

objs = [];

base = base_character(2)

show_bones = false;

move_coords=[0,0]
init_coords=[0,0]

offset = [sprite_get_xoffset(sprite),sprite_get_yoffset(sprite)]

selected = 1;

play_quad = false

animspd=1;

animfr=0;

clicked_coords = [0,0]

starting_angle = 0;

clicked_keyframe = -1;

currentframe = array_create(sprite_get_number(sprite)+2,0)