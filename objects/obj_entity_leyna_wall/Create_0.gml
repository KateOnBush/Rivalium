/// @description Insert description here
// You can write your code in this editor

depth = -5;

grown = false;

growbranches = 0;

lerpmom = 0.06;

newdir = 0;

growMaxBranches = 15;

sprite = base_character_lenya_wall_block;

dist = 55;

spr_inds = array_create(growMaxBranches);

blocks = array_create(growMaxBranches);

for(var i = 0; i < growMaxBranches; i++){

	spr_inds[i] = irandom_range(0, sprite_get_number(sprite)-1);
	blocks[i] = instance_create_depth(x, y, depth, obj_obstacle_entity);
	blocks[i].image_xscale = 2;
	blocks[i].image_yscale = 1.3;

}


// Inherit the parent event
event_inherited();

