/// @description Insert description here
// You can write your code in this editor

depth = 1;

global.partSystem = part_system_create();

global.partSystemBehind = part_system_create();

part_system_automatic_draw(global.partSystem, false);

part_system_automatic_draw(global.partSystemBehind, false);

part_system_automatic_update(global.partSystem, false);

part_system_automatic_update(global.partSystemBehind, false);

setupParticles();

lastTime = 0;
