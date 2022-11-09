/// @description Insert description here
// You can write your code in this editor

depth = 100;

vbuff = vertex_create_buffer()

vertex_begin(vbuff, global.v_format)

var pos = new Vector3(0, 0, -40);

var pos2 = new Vector3(32*image_xscale, 32*image_yscale, 40);

vertex_add_cube_repeated_tex(vbuff, pos, pos2, c_white, 256, 256);

vertex_end(vbuff);
