/// @description Insert description here
// You can write your code in this editor

depth = 100;

vbuff = vertex_create_buffer()

vertex_begin(vbuff, global.v_format)

var pos = new Vector3(-16*image_xscale, -16*image_yscale, -50);

var pos2 = new Vector3(16*image_xscale, 16*image_yscale, 50);

vertex_add_cube_repeated_tex(vbuff, pos, pos2, c_white, 160, 160);

vertex_end(vbuff);
