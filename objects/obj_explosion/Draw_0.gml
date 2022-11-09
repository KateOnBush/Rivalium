/// @description Insert description here
// You can write your code in this editor

if sprite_index draw_self()

if global.debugmode{

	draw_set_color(c_red)
	draw_circle(x, y, radius, true)
	draw_set_color(c_blue)
	draw_circle(x, y, radius*2, true)

}