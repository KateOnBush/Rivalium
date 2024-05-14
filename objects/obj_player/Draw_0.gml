/// @description Insert description here
// You can write your code in this editor

var hitcol = merge_color(c_white, c_red, hitind);

if dir==0 dir=1;

//draw_circle(rec_x, rec_y, 5, false);

if global.debugmode { 
	
	if mask_index draw_sprite(mask_index, 0, x, y);
	draw_set_color(c_aqua)
	draw_arrow(x, y, x+movvec.x*10, y+movvec.y*10, 5);

}

draw_set_color(c_red)
if state == PlayerState.GRAPPLED or state == PlayerState.GRAPPLE_THROW {
	var grapple_dist = point_distance(x, y - 12, grappling_coords[0],grappling_coords[1]);
	var grapple_dir = point_direction(x, y - 12, grappling_coords[0],grappling_coords[1]);
	draw_sprite_ext(defaultRope, 0, x, y - 12, 1, grapple_dist/42, grapple_dir - 90, c_white, 1);
}

//mesh.test.Render(sprite_get_texture(big_man_ting, 0));

if not dead {
	playerDraw(#80ba1c, 0);
}

