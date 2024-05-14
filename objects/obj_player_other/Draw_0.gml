/// @description Insert description here
// You can write your code in this editor

if dir==0 dir=1;

//HEHE BITCH

if state == PlayerState.GRAPPLED or state == PlayerState.GRAPPLE_THROW {
	var grapple_dist = point_distance(x, y - 12, grappling_coords[0],grappling_coords[1]);
	var grapple_dir = point_direction(x, y - 12, grappling_coords[0],grappling_coords[1]);
	draw_sprite_ext(defaultRope, 0, x, y - 12, 1, grapple_dist/42, grapple_dir - 90, c_white, 1);
}

var hitcol = merge_color(c_white, c_red, hitind);

if global.debugmode { 
	
	draw_set_color(c_aqua)
	draw_arrow(x, y, x+movvec.x*10, y+movvec.y*10, 5);

}

if not dead {
	if is_an_enemy() {
		shader_set(RedBorderEnemy)
		playerDraw(#ff2937, 1);
		shader_reset();
	} else {
		playerDraw(#ff2937, 1);	
	}
	
}