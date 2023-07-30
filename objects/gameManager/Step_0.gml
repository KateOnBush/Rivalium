/// @description Insert description here
// You can write your code in this editor

global.dt = min(delta_time*60/1000000 , 5)*global.gamespeed;

global.__fps = 1000000/delta_time;

global.lasttime += delta_time;
if (global.lasttime >= 16000) {

	global.__fpsframe = true;
	global.lasttime = 0;
	
} else global.__fpsframe = false;

if keyboard_check_released(vk_f1) global.debugmode = !global.debugmode;

processEvents();

if (keyboard_check(vk_control) && keyboard_check_released(ord("R"))) game_restart();