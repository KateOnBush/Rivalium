/// @description Insert description here
// You can write your code in this editor

for(var i = 0; i < array_length(map.backgrounds); i++){

	var _back = map.backgrounds[i];
	var perx = - clamp(obj_camera.view.x/room_width, 0, 1) + .5,
		pery = - clamp(obj_camera.view.y/room_height, 0, 1) + .5;

	matrix_set(matrix_world, matrix_build(
	obj_camera.view.x + perx * i * parallax_off, 
	obj_camera.view.y + pery * i * parallax_off * ratio, 
	-obj_camera.view.z, 0,0,1,1,1,1))

	vertex_submit(background_vbuffs[i], pr_trianglelist, sprite_get_texture(_back, -1));

	matrix_set(matrix_world, matrix_build(0,0,0,0,0,0,1,1,1))
	
}