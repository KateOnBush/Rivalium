	/// @description Insert description here
// You can write your code in this editor

randomize();

game_set_speed(99999,gamespeed_fps)

global.gamespeed = 1;

global.dt = 1;

global.__fps = 10;


model = buffer_load("3zi zwin.vbx");

global.modelzwin = vertex_create_buffer_from_buffer(model, global.v_format);