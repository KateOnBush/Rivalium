/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

wardrobe_blend = dtlerp(wardrobe_blend, global.inWardrobe, 0.04);
disappear_animation_blend = min(wardrobe_blend * 2, 1);

global_alpha = 1 - disappear_animation_blend;