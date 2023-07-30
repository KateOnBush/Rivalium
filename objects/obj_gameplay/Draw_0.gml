/// @description Insert description here
// You can write your code in this editor

if (!instance_exists(obj_player)) exit;

for(var i = 0; i < array_length(map.backgrounds); i++){

	var _back = map.backgrounds[i];
	var perx = - clamp(obj_player.camera.x/room_width, 0, 1) + .5,
		pery = - clamp(obj_player.camera.y/room_height, 0, 1) + .5;

	matrix_set(matrix_world, matrix_build(
	obj_player.camera.x + perx * i * parallax_off, 
	obj_player.camera.y + pery * i * parallax_off * ratio, 
	-obj_player.camera.z, 0,0,1,1,1,1))

	vertex_submit(background_vbuffs[i], pr_trianglelist, sprite_get_texture(_back, -1));

	matrix_set(matrix_world, matrix_build(0,0,0,0,0,0,1,1,1))
	
}