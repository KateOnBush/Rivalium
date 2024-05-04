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
	SHIELDING,
    REDEMPTION,
    PROTECTION,

    VULNERABILITY,
    SLOWNESS,
    SHATTERING,
    IMPOTENCE,
    LETHARGY, // -% haste
    BLIND,
	
	SPECTRE,
	STORMWRATH

}

global.effect_data = [
	["NONE", c_black, c_white],
	
	["HEALING", #009c50, c_white, true],
	["BLEEDING", #751e01, c_white, false],
	
	["AGILITY", #b6c1cc, #303030, true],
	["SWIFTNESS", #156dbf, c_white, true],
	["STEALTH", #332314, c_white, true],
	["POWER", #cf2b1f, c_white, true],
	["SHIELDED", #d1ffdf, #004013, true],
	["REDEMPTIVE", #22f03d, c_white, true],
	["PROTECTED", #ccb010, c_white, true],
	
	["VULNERABLE", #ad8139, c_white, false],
	["SLOWED", #1a1714, c_white, false],
	["SHATTERED", #ae89d9, #251e2e, false],
	["IMPOTENT", #820d09, c_white, false], 
	["LETHARGIC", #2a4166, c_white, false],
	["BLINDED", #140352, c_white, false],
	
	["SPECTRE", #260502, #ff7569, true],
	["STORM WRATH", #195ed4, #c7dbff, true],
]


function Effect(type, duration) constructor{

	self.type = type;
	self.duration = duration;
	
	elapsed = 0;

}

function process_effects(effect_list){

	for(var i = 0; i < array_length(effect_list); i++){
	
		effect_list[i].elapsed += global.dt/60;
		
		if effect_list[i].elapsed > effect_list[i].duration array_delete(effect_list,  i, 1);
	
	}
	
	return effect_list;

}

function add_effect(type, duration, p, playerid = 0){

	var alreadyHas = false;
	for(var i = 0; i < array_length(p.playerEffects); i++) {
		var effect = p.playerEffects[i];
		if (effect.type == type) {
			effect.duration = effect.elapsed + max(duration, effect.duration - effect.elapsed);
			alreadyHas = true;
		}
	}
	if (!alreadyHas) array_push(p.playerEffects, new Effect(type, duration));
	if (type == EFFECT.HEAL) {
		p.healing_timer = max(duration, p.healing_timer);
	} else if (type == EFFECT.BURN) {
		p.burning_timer = max(duration, p.burning_timer);
	}
	return p.playerEffects;

}

function remove_effect(type, p){
	var new_array = [];
	for(var i = 0; i < array_length(p.playerEffects); i++) {
		var effect = p.playerEffects[i];
		if (effect.type != type) array_push(new_array, effect);
	}
	p.playerEffects = new_array;
}

function explosion_hit(explosionID, playerID){
	
	if (playerID == 0 or playerID == global.playerid) obj_player.playerhealth -= damage;
	else if (global.players[? playerID]) global.players[? playerID].playerhealth -= damage;

}