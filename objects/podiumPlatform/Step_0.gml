/// @description Insert description here
// You can write your code in this editor

wardrobe_blend = dtlerp(wardrobe_blend, global.inWardrobe, 0.04);
scale_animation_blend = 2 * max(wardrobe_blend - 0.5, 0);

y = lerp(ystart, ystart - 100, scale_animation_blend);
image_yscale = lerp(initial_scale, initial_scale * 1.8, scale_animation_blend);