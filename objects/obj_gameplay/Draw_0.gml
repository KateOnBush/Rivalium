/// @description Insert description here
// You can write your code in this editor

for(var i = 0; i < array_length(map.backgrounds); i++){

	var _back = map.backgrounds[i];
	var perx = - clamp(obj_camera.view.x/room_width, 0, 1) + .5,
		pery = - clamp(obj_camera.view.y/room_height, 0, 1) + .5;
		
	var ww = background_data[i][0], hh = background_data[i][1], dep = background_data[i][2];

	var xx = obj_camera.view.x + perx * i * parallax_off - ww/2,
		yy = obj_camera.view.y + pery * i * parallax_off * ratio - hh/2, 
		zz = dep - obj_camera.view.z;

	gpu_set_depth(zz);
	
	draw_sprite_stretched(_back, 0, xx, yy, ww, hh);
	
	gpu_set_depth(0);
	
}