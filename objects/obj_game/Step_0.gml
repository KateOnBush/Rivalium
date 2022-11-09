/// @description Insert description here
// You can write your code in this editor

global.dt = min(delta_time*60/1000000 , 5)*global.gamespeed;

global.__fps = 1000000/delta_time;

if keyboard_check_released(vk_f1) global.debugmode = !global.debugmode;

processEvents();