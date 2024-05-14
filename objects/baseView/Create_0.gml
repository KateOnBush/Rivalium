/// @description Insert description here
// You can write your code in this editor

event_inherited();

view_surface = -1;

//view_layer = layer_create(depth - 1);
//layer_set_visible(view_layer, true);

view_mask_surface = -1;

isHovering = false;

lastx = x;
lasty = y;

lastSprite = -1;

//fx = fx_create("_filter_mask");
//fx_params = fx_get_parameters(fx);

//layer_set_fx(view_layer, fx);

children = [];

add = function(object, _x, _y) {

	if !array_contains(children, object) array_push(children, object);
	var o = instance_create_layer(_x, _y, layer, object);
	o.visible = false;
	o.depth = depth - 1;
	o.viewParent = self;
	o.z = z;
	return o;
	
}

clear = function() {
	
	array_foreach(children, function(child){
		instance_destroy(child);
	})
	children = [];
	
}

draw_func = function(child) {
	with(child) {
		event_perform(ev_draw, 0);
	}
}

scrollY = 0;
scrollYReal = 0;
scrollSens = 10;

maxY = y;