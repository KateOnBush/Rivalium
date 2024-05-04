/// @description Insert description here
// You can write your code in this editor

draw_sprite_ext(wardrobeBorder, 0, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
if sprite_exists(lastCircle) draw_sprite_ext(lastCircle, 0, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
if sprite_exists(currentCircle) draw_sprite_ext(currentCircle, 0, x, y, image_xscale, image_yscale, image_angle, c_white, opacity);
