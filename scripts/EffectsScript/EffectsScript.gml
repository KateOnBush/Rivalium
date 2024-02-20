// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum EFFECT {

	NONE,

    HEAL,
    BURN,

    AGILITY,
    SWIFTNESS,
    INVISIBILITY,
    POWER,
    REDEMPTION,
    PROTECTION,

    VULNERABILITY,
    SLOWNESS,
    SHATTERING,
    IMPOTENCE,
    LETHARGY, // -% haste
    BLIND,

}

function Effect(type, duration, data) constructor{

	self.type = type;
	self.duration = duration;
	self.data = data;
	
	elapsed = 0;

}

function process_effects(effect_list){

	for(var i = 0; i < array_length(effect_list); i++){
	
		effect_list[i].elapsed += global.dt/60;
		
		if effect_list[i].elapsed > effect_list[i].duration array_delete(effect_list,  i, 1);
	
	}
	
	return effect_list;

}

function add_effect(type, duration, data, p, playerid = 0){

	array_push(p.playerEffects, new Effect(type, duration, data));
	return p.playerEffects;

}

function explosion_hit(explosionID, playerID){
	
	if (playerID == 0 or playerID == global.playerid) obj_player.playerhealth -= damage;
	else if (global.players[? playerID]) global.players[? playerID].playerhealth -= damage;

}