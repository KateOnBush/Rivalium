// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum effecttype {

	heal,
	bleed,
	boost,
	slow,
	invisible,
	stunned,

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
	
	var b = buffer_create(global.dataSize, buffer_fixed, 1);
	buffer_seek(b, buffer_seek_start, 0);
	buffer_write(b, buffer_u8, SERVER_REQUEST.PLAYER_EXPLOSION_HIT);
	buffer_write(b, buffer_u16, real(playerID));
	buffer_write(b, buffer_u16, real(explosionID));
	
	network_send_raw(obj_network.server, b, global.dataSize);
	
	buffer_delete(b);
	

}