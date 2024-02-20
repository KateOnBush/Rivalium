/// @description Insert description here
// You can write your code in this editor

depth = -5;

grown = false;

growbranches = 0;

lerpmom = 2.3;

last_updated = current_time;

newdir = 0;

takingdir = true;

takingdirtimermax = 0.6
takingdirtimer = takingdirtimermax;

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

rumble = part_type_create();
part_type_sprite(rumble, base_character_lenya_explosion_rumble_wall, false, false, true);
part_type_size(rumble, 1.3, 1.5, -0.03, 0);
part_type_direction(rumble, 0, 180, 0, 0)
part_type_speed(rumble, 3, 8, 0, 0);
part_type_gravity(rumble, grav, -90);
part_type_life(rumble, 80, 80);
part_type_alpha3(rumble, 1, 1, 0);

destroy = function(){

	for(var i = 0; i < array_length(blocks); i++){
	
		if instance_exists(blocks[i]) {
			repeat(20){
				part_particles_create(global.partSystem, 
				blocks[i].x + random_range(-5, 5), 
				blocks[i].y + random_range(-5, 5), 
				rumble, random(5))	
			}
			instance_destroy(blocks[i]);
		}
	
	}

}

