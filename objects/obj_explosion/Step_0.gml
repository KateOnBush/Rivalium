/// @description Insert description here
// You can write your code in this editor


if !hits and !visual {

	for(var i = 0; i < instance_number(obj_player_other); i++){

		var _inst = instance_find(obj_player_other, i);
	
		var _dist = distance_to_object(_inst);
	
		if(_dist > radius) continue;
	
		var _damage = damage * power(1 - max(_dist - 40,0)/radius, 2);
		
		show_debug_message(_damage);
		
		if (global.playerid == ownerID) inflict_damage(damage, 0, _inst.ID);

	}

hits = true;

}

lifetime -= dtime/60;

if (lifetime<0) instance_destroy();