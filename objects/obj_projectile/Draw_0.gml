/// @description Insert description here
// You can write your code in this editor

if global.debugmode {
	if sprite_exists(mask_index) draw_sprite(mask_index, 0, x, y);	
}
draw_self()

if global.debugmode {

	draw_set_color(c_red)

	var _x = x, _y = y;

	var sx = lengthdir_x(spd, dir);
	var sy = lengthdir_y(spd, dir);
	
	repeat(10){
	
		_x += sx*2;
		_y += sy*2;
		sy += grav*2;
		
		draw_line(_x, _y, _x + sx*2, _y + sy*2 + grav*2);
		
	
	}



}