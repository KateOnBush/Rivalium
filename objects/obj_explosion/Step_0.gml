/// @description Insert description here
// You can write your code in this editor

if !hits {

	var _dist = distance_to_object(obj_player);
	
	var _dir = point_direction(x, y, obj_player.x, obj_player.y);
	
	if(_dist < radius*2) {
	
		var _e = power(1 - max(_dist - 40,0)/(radius*2), 1/2);
		
		obj_player.movvec.x += lengthdir_x(17, _dir)*_e;
		obj_player.movvec.y += lengthdir_y(17, _dir)*_e;
	
	}

	for(var i = 0; i < instance_number(obj_obstacle_entity); i++){
	
		var _inst = instance_find(obj_obstacle_entity, i);
		
		var _d = distance_to_object(_inst);
		
		if (_d < radius) {
		
			_inst.componentTo.damage(damage);
		
		}
		
	
	}

}

if !hits and !visual {

	for(var i = 0; i < instance_number(obj_player_other); i++){

		var _inst = instance_find(obj_player_other, i);
	
		var _dist = distance_to_object(_inst);
	
		if(_dist > radius) continue;
	
		var _damage = damage * power(1 - max(_dist - 25,0)/radius, 1/2);
		
		show_debug_message(_damage);
		
		if (global.playerid == ownerID) inflict_damage(damage, 0, _inst.ID);

	}

hits = true;

}

lifetime -= dtime/60;

if (lifetime<0) instance_destroy();