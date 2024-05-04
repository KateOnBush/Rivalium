/// @description Insert description here
// You can write your code in this editor

var hitcol = merge_color(c_white, c_red, hitind);

if dir==0 dir=1;

draw_circle(rec_x, rec_y, 5, false)

if global.debugmode { 
	
	if mask_index draw_sprite(mask_index, 0, x, y);
	draw_set_color(c_aqua)
	draw_arrow(x, y, x+movvec.x*10, y+movvec.y*10, 5);

}

draw_set_color(c_red)
if state == PlayerState.GRAPPLED or state == PlayerState.GRAPPLE_THROW draw_line(x, y, grappling_coords[0],grappling_coords[1])

//mesh.test.Render(sprite_get_texture(big_man_ting, 0));

if state != PlayerState.DEAD {
	playerDraw(#80ba1c, 0);
}
