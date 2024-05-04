/// @description Insert description here
// You can write your code in this editor

game_set_speed(60, gamespeed_fps);

view_set_visible(1, false);
view_set_visible(0, true);

gpu_set_tex_filter(false);

show_rig = false;

clicked_scale = 1;

sprite = base_character_kenn;

pos = [];

presets = [
	[0, 1, "Kenn"],
	[1, 2, "Gramin"],
	[2, 3, "Lenya"],
	[3, 4, "Masr"]
]


function pop_message(msg){

	var o = instance_create_depth(mouse_x, mouse_y, -1, animator_message, { message: msg});

}

// animation = [keyframes = [pos[], time] ]

global.animation = empty_animation(sprite);

global.selected_keyframe = 0;

global.playing = false

global.selected_bone = 0

global.hovered = -1;

global.boneSetup = false

global.message = "";

delayidkwhy = 0;

show_org = false;

init_coord_list = [];

temporary_base = empty_bone_base(sprite_get_number(sprite));

controlled = 0;

objs = [];

moveTemp = 0;

base = empty_bone_base(sprite_get_number(sprite));

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

currentframe = empty_frame(sprite);