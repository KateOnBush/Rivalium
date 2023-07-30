/// @description Insert description here
// You can write your code in this editor

if instance_exists(deadPlayer) {

	var surf = deadPlayer.playerSurf;
	
	if !surface_exists(surf) exit;
	
	var ww = surface_get_width(surf);
	
	var col = make_color_hsv(color_get_hue(c_white), 0, (1 - greying) * 255);
	
	draw_surface_part_ext(surf, 0, 0, 
	ww, ww * (1 - disappear), x - ww/2, y - ww/2,
	1, 1, col, (1 - greying) * 0.2 + 0.8);

}