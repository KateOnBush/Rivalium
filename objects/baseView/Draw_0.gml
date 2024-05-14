/// @description Insert description here
// You can write your code in this editor

/*var changedPos = lastx != x or lasty != y;

if !surface_exists(view_mask_surface) or !sprite_exists(lastSprite) or changedPos {

	var scale = 1/3;

	//redraw surface
	if !surface_exists(view_mask_surface) or changedPos {
		
		if !surface_exists(view_mask_surface) view_mask_surface = surface_create(1920 * scale, 1080 * scale);
		
		surface_set_target(view_mask_surface);
	
		draw_clear_alpha(c_black, 1);
		draw_set_color(c_white);
		draw_set_alpha(1);
		draw_rectangle(
		x * scale, y * scale, 
		(x + sprite_width) * scale, (y + sprite_height) * scale, false);
	
		surface_reset_target();
		
	}
	
	if !sprite_exists(lastSprite) or changedPos {
		if changedPos and sprite_exists(lastSprite) sprite_delete(lastSprite);
		lastSprite = sprite_create_from_surface(view_mask_surface, 0, 0, 1920 * scale, 1080 * scale, false, false, 0, 0);
	}
	
	fx_params.g_MaskTexture = lastSprite;
	fx_set_parameters(fx, fx_params);
	
}

if changedPos {
	lastx = x;
	lasty = y;
}*/

if !surface_exists(view_surface) view_surface = surface_create(sprite_width, sprite_height);

surface_set_target(view_surface);
gpu_set_tex_filter(true);
draw_clear_alpha(c_black, 0);
draw_set_alpha(1);
matrix_set(matrix_world, matrix_build(-x, -y, 0, 0, 0, 0, 1, 1, 1));

array_foreach(children, draw_func);

matrix_set(matrix_world, matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1));

surface_reset_target();

draw_surface(view_surface, x, y);