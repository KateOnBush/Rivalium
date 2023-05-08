/// @description Insert description here
// You can write your code in this editor

depth = 100;

vbuff = vertex_create_buffer()

vertex_begin(vbuff, global.v_format)

var z = random_range(10, 140);

var dz = random_range(-z/2, z/2);

var pos = new Vector3(-16*image_xscale, -16*image_yscale, -z + dz);

var pos2 = new Vector3(16*image_xscale, 16*image_yscale, z + dz);

vertex_add_cube_repeated_tex(vbuff, pos, pos2, c_white, 160, 4 * image_yscale);

vertex_end(vbuff);
