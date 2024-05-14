/// @description Insert description here
// You can write your code in this editor

global.partSystem = part_system_create();

part_system_depth(global.partSystem, 0);

part_system_automatic_draw(global.partSystem, false);

part_system_automatic_update(global.partSystem, false);

setupParticles();

lastTime = 0;
