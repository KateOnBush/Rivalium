/// @description Insert description here
// You can write your code in this editor

wardrobe_blend = dtlerp(wardrobe_blend, global.inWardrobe, 0.04);
outmain_animation_blend = min(wardrobe_blend * 2, 1);
inwardrobe_animation_blend = 2 * max(wardrobe_blend - 0.5, 0);

var mainLayer = layer_get_id("MainLayer");
var bottomLayerRival = layer_get_id("RivalLayerBottom");
var leftLayerRival = layer_get_id("RivalLayerLeft");
var rightLayerRival = layer_get_id("RivalLayerRight");

with(all) {
	if (layer == mainLayer) {
		y = ystart + other.outmain_animation_blend * 80;
	} else if (layer == bottomLayerRival) {
		y = ystart + 400 - other.inwardrobe_animation_blend * 400;
	} else if (layer == leftLayerRival) {
		x = xstart - 1000 + other.inwardrobe_animation_blend * 1000;
	} else if (layer == rightLayerRival) {
		x = xstart + 1000 - other.inwardrobe_animation_blend * 1000;
	}
}
