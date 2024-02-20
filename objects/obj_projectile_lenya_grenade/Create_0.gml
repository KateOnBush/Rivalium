/// @description Insert description here
// You can write your code in this editor

event_inherited();

trail = part_type_create();
part_type_sprite(trail, base_character_lenya_grenade_trail, false, false, true);
part_type_size(trail, 0.5, 1, 0, 0);
part_type_color2(trail, #e897e5, #8b09ba);
part_type_alpha2(trail, .8, 0);

on_destroy = function(){

	if (ownerID == global.playerid && instance_exists(obj_player)){
		obj_player.char.abilities.ability2.forceCooldown();
	}

}