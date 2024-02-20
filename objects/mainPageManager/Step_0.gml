/// @description Insert description here
// You can write your code in this editor

wardrobe_blend = dtlerp(wardrobe_blend, global.inWardrobe, 0.04);
outmain_animation_blend = min(wardrobe_blend * 2, 1);
inwardrobe_animation_blend = 2 * max(wardrobe_blend - 0.5, 0);

var lay_id = layer_get_id("MainLayer");
layer_y(lay_id, outmain_animation_blend * 80);