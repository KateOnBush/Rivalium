/// @description Insert description here
// You can write your code in this editor

matrix_set(matrix_world, matrix_build(x,y,0,0,0,image_angle,1,1,1))

vertex_submit(vbuff, pr_trianglelist, sprite_get_texture(tMbow, -1));

matrix_set(matrix_world, matrix_build(0,0,0,0,0,0,1,1,1))
