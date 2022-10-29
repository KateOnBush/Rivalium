/// @description Insert description here
// You can write your code in this editor

global.dt = min(delta_time*60/1000000 , 5)*global.gamespeed;

global.__fps = 1000000/delta_time;

processEvents();