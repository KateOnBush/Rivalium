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

function add_effect(type, duration, data, effectsArray, broadcast, playerid = 0){

	array_push(effectsArray, new Effect(type, duration, data));
	if global.connected && broadcast{
	
		var b = buffer_create(global.dataSize, buffer_fixed, 1);
		buffer_seek(b, buffer_seek_start, 0);
		buffer_write(b, buffer_u8, 9);
		buffer_write(b, buffer_u8, type);
		buffer_write(b, buffer_u16, duration*100);
		buffer_write(b, buffer_u16, real(playerid));
		if(type == effecttype.slow or type == effecttype.boost) buffer_write(b, buffer_u16, data.multiplier*100);
		
		network_send_raw(obj_network.server, b, global.dataSize);
		
		buffer_delete(b);
		
	
	}
	return effectsArray;

}

function inflict_damage(damage, burn, ID){
	
	if (ID == 0 or ID == global.playerid) obj_player.playerhealth -= damage;
	else if (global.players[? ID]) global.players[? ID].playerhealth -= damage;
	
	var b = buffer_create(global.dataSize, buffer_fixed, 1);
	buffer_seek(b, buffer_seek_start, 0);
	buffer_write(b, buffer_u8, 10);
	buffer_write(b, buffer_u16, real(ID));
	buffer_write(b, buffer_u16, damage);
	buffer_write(b, buffer_u16, burn);
	
	network_send_raw(obj_network.server, b, global.dataSize);
	
	buffer_delete(b);
	

}

function heal(amount, ID = 0){

	if (ID == 0 or ID == global.playerid) obj_player.playerhealth += amount;
	else if (global.players[? ID]) global.players[? ID].playerhealth += amount;

	var b = buffer_create(global.dataSize, buffer_fixed, 1);
	buffer_seek(b, buffer_seek_start, 0);
	buffer_write(b, buffer_u8, 11);
	buffer_write(b, buffer_u16, real(ID));
	buffer_write(b, buffer_u16, amount);
	
	network_send_raw(obj_network.server, b, global.dataSize);
	
	buffer_delete(b);

}