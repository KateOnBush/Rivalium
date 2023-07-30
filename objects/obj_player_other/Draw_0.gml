/// @description Insert description here
// You can write your code in this editor

if dir==0 dir=1;

//HEHE BITCH

draw_set_color(c_red)
if grappling draw_line(x,y,grappling_coords[0],grappling_coords[1])

var hitcol = merge_color(c_white, c_red, hitind);

if global.debugmode { 
	
	draw_set_color(c_aqua)
	draw_arrow(x, y, x+movvec.x*10, y+movvec.y*10, 5);

}

playerDraw(#ff2937, 1);