/// @description Insert description here
// You can write your code in this editor

#macro isFpsFrame global.__fpsframe 
#macro GAMEVERSION global.__game_version

global.selectedInput = -1;

GAMEVERSION = {
	major: "pre-release",
	minor: "0",
	build: "0",
	bugfix: "0"
}

gpu_set_texfilter(true);

depth = 10000;

randomize();

game_set_speed(99999, gamespeed_fps)

global.gamespeed = 1;

global.dt = 1;

global.__fps = 10;

global.debugmode = true;

global.__fpsframe = false;

global.lasttime = 0;

room_goto_next();