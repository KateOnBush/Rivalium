/// @description Insert description here
// You can write your code in this editor

global.inWardrobe = false;

start_loading();

account_server_send_message("fetch.self", {}, finish_loading);

wardrobe_blend = 0;
outmain_animation_blend = 0;
inwardrobe_animation_blend = 0;