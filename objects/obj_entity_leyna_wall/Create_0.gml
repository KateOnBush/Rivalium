/// @description Insert description here
// You can write your code in this editor

depth = -5;

grown = false;

growbranches = 0;

lerpmom = 0.06;

last_updated = current_time;

newdir = 0;

takingdir = true;

takingdirtimer = 0.5;

changedirtime = 5;

pomdir = 0;

growMaxBranches = 15;

sprite = base_character_lenya_wall_block;

dist = 55;

spr_inds = array_create(growMaxBranches);

blocks = array_create(growMaxBranches);

for(var i = 0; i < growMaxBranches; i++){

	spr_inds[i] = irandom_range(0, sprite_get_number(sprite)-1);
	blocks[i] = entity_create_solid_component(x, y, self);
	blocks[i].image_xscale = 2;
	blocks[i].image_yscale = 1.3;

}

// Inherit the parent event
event_inherited();

destroy = function(){

	for(var i = 0; i < array_length(blocks); i++){
	
		if instance_exists(blocks[i]) instance_destroy(blocks[i]);
	
	}

}

