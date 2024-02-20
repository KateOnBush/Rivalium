/// @description Insert description here
// You can write your code in this editor

user = UserData;

wardrobe_blend = dtlerp(wardrobe_blend, global.inWardrobe, 0.04);
scale_animation_blend = 2 * max(wardrobe_blend - 0.5, 0);
details_alpha = 1 - scale_animation_blend;

x = lerp(xstart, room_width/2, scale_animation_blend);
y = lerp(ystart, ystart + 80, scale_animation_blend);
image_xscale = lerp(initial_scale, 2.6, scale_animation_blend);
image_yscale = lerp(initial_scale, 2.6, scale_animation_blend);

// Inherit the parent event
event_inherited();

