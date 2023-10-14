/// @description Insert description here
// You can write your code in this editor

if (async_load[? "id"] != server) exit;

var dataSize = global.dataSize;

if async_load[? "type"] == network_type_non_blocking_connect {
	
	global.connected = async_load[? "succeeded"];
	if (!global.connected) {
		show_debug_message("nigga da server down?");
		//couldnt connect	
		exit;
	}
	
	start_loading(, "JOINING GAME");
	
	var buff = buffer_create(dataSize, buffer_fixed, 1);
	buffer_write(buff, buffer_u8, ServerRequest.IDENTIFY);
	buffer_write(buff, buffer_u32, MatchPass);
	buffer_write(buff, buffer_u32, MatchPlayerAccess);
	
	network_send_raw(server, buff, dataSize);
	
	buffer_delete(buff);
	
} else if async_load[? "type"] == network_type_data {

	var buff = async_load[? "buffer"];
	buffer_seek(buff, buffer_seek_start, 0);
	
	var size = async_load[? "size"]

	var nPackets = (size) div dataSize;
	
	for(var currentPacket = 0; currentPacket < nPackets; currentPacket++){

		buffer_seek(buff, buffer_seek_start, dataSize*currentPacket);
		
		var type = buffer_read(buff, buffer_u8);
		
		switch(type) {
			
			case ServerResponse.PREMATCH:
			
				var state = buffer_read(buff, buffer_u8);
				switch(state) {
					
					case SERVER_PREMATCH.IDENTIFIED:
						start_loading(, "GAME LOADING");
						loading_set_game(true);
						userdata_load_prematch_data();
						break;
				
					case SERVER_PREMATCH.MATCH_STARTING:
						start_loading(, "MATCH STARTING");
						break;
						
					case SERVER_PREMATCH.MATCH_STARTED: 
						finish_loading();
						break;
				
				}
				break;
				
			case ServerResponse.GAME_STATE: 
			
				var newState = buffer_read(buff, buffer_u8);
				var newRound = buffer_read(buff, buffer_u8);
				var startingIn = buffer_read(buff, buffer_u8);
				
				obj_gameplay.currentState = newState;
				obj_gameplay.currentRound = newRound;
				obj_gameplay.startingIn = startingIn;
				
				if (newState != GameState.PREROUND && instance_exists(obj_player)) {
					obj_player.GUIText = "";
					obj_player.state = PlayerState.FREE;
				}
			
				break;
		
			case ServerResponse.PLAYER_CREATE:
			
				var ID = buffer_read(buff, buffer_u16);
				var isme = buffer_read(buff, buffer_u8);
				var charid = buffer_read(buff, buffer_u8);
				var hp = buffer_read(buff, buffer_u16);
				var ult = buffer_read(buff, buffer_u16);
				var maxhp = buffer_read(buff, buffer_u16);
				var maxult = buffer_read(buff, buffer_u16);
			
				var _x = buffer_read(buff, buffer_s32)/100;
				var _y = buffer_read(buff, buffer_s32)/100;
			
				if (isme){
			
					instance_create_depth(_x,_y,0,obj_player)
					global.playerid = ID;
					
					with (obj_player) { 
							
						setup_character(charid); 
						playerhealthmax = maxhp;
						playerhealth = hp;
						ultimatechargemax = maxult;
						ultimatecharge = ult;
							
					}
			
				} else {
			
					if is_undefined(ds_map_find_value(global.players, ID)) {
		
						var player = instance_create_depth(_x, _y, 0, obj_player_other);
						player.ID = ID;
						ds_map_add(global.players, ID, player);
		
					}
				
					var p = global.players[? ID];
						
					with(p) {
						setup_character(charid); 
						playerhealthmax = maxhp;
						playerhealth = hp;
						ultimatechargemax = maxult;
						ultimatecharge = ult;
					}
			
				}
			
				break;
			
			case ServerResponse.PLAYER_UPDATE:
	
				if global.playerid == -1 continue;
			
				var ID = buffer_read(buff, buffer_u16);
				
				var _state = buffer_read(buff, buffer_u8);
		
				var _x = buffer_read(buff, buffer_s32)/100;
				var _y = buffer_read(buff, buffer_s32)/100;
				var movvecx = buffer_read(buff, buffer_s32)/100;
				var movvecy = buffer_read(buff, buffer_s32)/100;
				
				var _on_ground = buffer_read(buff, buffer_u8);
				var _dir = buffer_read(buff, buffer_s8);
				var _slide = buffer_read(buff, buffer_u8);
				var _playerhealth = real(buffer_read(buff, buffer_u16));
				var _ultimatecharge = real(buffer_read(buff, buffer_u16));
				var _playerhealthmax = real(buffer_read(buff, buffer_u16));
				var _ultimatechargemax = real(buffer_read(buff, buffer_u16));
				var _charid = buffer_read(buff, buffer_u8);
				var _mousex = buffer_read(buff, buffer_s32)/100;
				var _mousey = buffer_read(buff, buffer_s32)/100;
		
				if (ID == global.playerid) {
					
					with (obj_player) {
				
						rec_x = _x;
						rec_y = _y;
						rec_mx = movvecx;
						rec_my = movvecy;
						playerhealth = _playerhealth;
						ultimatecharge = _ultimatecharge;
						if (character_id != _charid) {
							setup_character(_charid);
						}
				
					}
					continue;
				}
			
				if is_undefined(ds_map_find_value(global.players, ID)) {
			
					var player = instance_create_depth(_x, _y, 0, obj_player_other);
					player.ID = ID;
					ds_map_add(global.players, ID, player);
				
			
				}
		
				var p = global.players[? ID];
			
				with(p){
			
					ux = dtlerp(x, _x, 0.95);
					uy = dtlerp(y, _y, 0.95);

					if place_meeting(ux, y, obj_solid){

						var k = 0.95;

						while(place_meeting(ux, y, obj_solid) && k != 0){
	
							k -= 0.05;
							ux = dtlerp(x, _x, k);
		
						}

					}

					if place_meeting(ux, uy, obj_solid){

						var k = 0.95;

						while(place_meeting(ux, uy, obj_solid) && k != 0){
	
							k -= 0.05;
							uy = dtlerp(y, _y, k);
		
						}

					}
					
					state = _state;
					
					movvec.x = movvecx;
					movvec.y = movvecy;
			
					updated = current_time;
			
					on_ground = _on_ground;
					dir = _dir;
					slide = _slide;
					playerhealth = _playerhealth;
					ultimatecharge = _ultimatecharge;
					playerhealthmax = _playerhealthmax;
					ultimatechargemax = _ultimatechargemax;
					if (character_id != _charid) {
						setup_character(_charid);
					}
					mousex = _mousex;
					mousey = _mousey;
				
			
				}
			
				break;
				
			case ServerResponse.PLAYER_FORCED_DASH:
			
				var ID = buffer_read(buff, buffer_u16);
				var _dir = buffer_read(buff, buffer_s16)/100;
				var _time = buffer_read(buff, buffer_u16)/100;
				var _mult = buffer_read(buff, buffer_u16)/100;
				
				if (ID == global.playerid && instance_exists(obj_player)) {
				
					with(obj_player){
						playerDash(_dir, _time, _mult);
					}
				
				}
				
				break;
				
	
			case ServerResponse.PLAYER_GRAPPLE:
	
				if global.playerid == -1 continue;
	
				var ID = buffer_read(buff, buffer_u16);
		
				if (ID == global.playerid) continue;
				if is_undefined(ds_map_find_value(global.players, ID)) continue;
		
				var p = global.players[? ID];
		
				var __x = real(buffer_read(buff, buffer_s32))/100;
				var __y = real(buffer_read(buff, buffer_s32))/100;
				var _gr = buffer_read(buff, buffer_u8);
			
				if _gr {
			
					p.grappling_coords_init = [__x, __y];
					p.grappling_coords = [__x,__y];
					p.grappled = true;
					p.grappling = true;
			
				} else {
			
					p.grappling_coords_init = [__x, __y];
					p.grappling_coords = [__x,__y];
					p.grappling = true;
					p.grappling_len = 0;
			
				}
			
				break;
			
		
			case ServerResponse.PLAYER_FLIP:
	
				if global.playerid == -1 continue;
	
				var ID = buffer_read(buff, buffer_u16);
		
				if (ID == global.playerid) continue;
				if is_undefined(ds_map_find_value(global.players, ID)) continue;
		
				var p = global.players[? ID];
		
				var _forward = buffer_read(buff, buffer_u8);
				var _start = buffer_read(buff, buffer_u8)/100;
		
				with(p){
		
					// Feather disable once GM1019
					perform_flip(_forward, _start);
		
				}
			
				break;
			
			case ServerResponse.PING:
		
				var st = buffer_read(buff, buffer_u8);
				if(st == 0){
			
					var b = buffer_create(dataSize, buffer_fixed, 1);
					buffer_seek(b, buffer_seek_start, 0);
					buffer_write(b, buffer_u8, ServerRequest.PING);
				
					network_send_raw(obj_network.server, b, buffer_get_size(b));
				
					buffer_delete(b);
				
				
				} else {
			
					global.ping = real(buffer_read(buff, buffer_u32));
			
				}
			
				break;
		
			case ServerResponse.PROJECTILE_CREATE: //Projectile
		
				var ownerid = buffer_read(buff, buffer_u16);
				var ob = buffer_read(buff, buffer_u16);
				var _x = buffer_read(buff, buffer_s32)/100;
				var _y = buffer_read(buff, buffer_s32)/100;
				var sp = buffer_read(buff, buffer_s32)/100;
				var dr = buffer_read(buff, buffer_s16)/10;
				var col = buffer_read(buff, buffer_u8);
				var dieoncol = buffer_read(buff, buffer_u8);
				var lifespan = buffer_read(buff, buffer_u8);
				var damage = buffer_read(buff, buffer_u16);
				var bleed = buffer_read(buff, buffer_u16);
				var heal = buffer_read(buff, buffer_u16);
				var ID = buffer_read(buff, buffer_u16);
				var bounce = buffer_read(buff, buffer_u8);
				var __px = buffer_read(buff, buffer_s32)/100;
				var __py = buffer_read(buff, buffer_s32)/100;
				var bounceFriction = buffer_read(buff, buffer_u8)/100;
				var hasGrav = buffer_read(buff, buffer_u8);
			
				if ownerid == global.playerid {
					
					with(obj_projectile){
						if (self.ID == 0){
							instance_destroy();	
						}
					}
				}
				
				var o = projectile_create(ob, ownerid, _x, _y, sp, dr, col, dieoncol, lifespan, damage, bleed, heal, ID, bounce, __px, __py);
				o.bounceFriction = bounceFriction;
				o.hasGrav = hasGrav;
				
				break;
			
		
			case ServerResponse.PLAYER_HIT:
		
				var __hit = buffer_read(buff, buffer_u16);
				var __attacker = buffer_read(buff, buffer_u16);
				var __visual = buffer_read(buff, buffer_u8);
				var p = noone;
				if (__hit == global.playerid) p = obj_player;
				if (global.players[? __hit]) p = global.players[? __hit];
				with (p) {
					playerHit(__visual);	
				}
				break;
		
			case ServerResponse.PROJECTILE_DESTROY:
		
				var proj = buffer_read(buff, buffer_u16);
				for(var i = 0; i < instance_number(obj_projectile); i++){
			
					var inst = instance_find(obj_projectile, i);
					if (inst.ID == proj){
				
						inst.on_collision();
						instance_destroy(inst);
				
					}
			
				}
				break;
		
			case ServerResponse.PLAYER_ABILITY_CAST:
		
				var ID = buffer_read(buff, buffer_u16);
			
				var p = global.players[? ID];
				if (ID == global.playerid && instance_exists(obj_player)) p = obj_player;
				
				if (p == undefined) continue;
			
				var abi = buffer_read(buff, buffer_u8);
			
				var abi_n = buffer_read(buff, buffer_u8);
			
				with(p) {
					cast_ability(abi, abi_n);
				}
				
				break;
		
			case ServerResponse.EFFECT_ADD: 
		
				var ID = buffer_read(buff, buffer_u16);
			
				var p;
			
				if (ID == global.playerid) p = obj_player else {
			
					if is_undefined(ds_map_find_value(global.players, ID)) continue;
			
					p = global.players[? ID];
				
				}
			
				if !instance_exists(p) continue;
			
				var e_type = buffer_read(buff, buffer_u8);
			
				var e_duration = buffer_read(buff, buffer_u16)/100;
			
				var e_data = {};
			
				if (e_type == EFFECT.ACCELERATION || e_type == EFFECT.SLOW) e_data = {multiplier: buffer_read(buff, buffer_u16)/100};
			
				add_effect(e_type, e_duration, e_data, p);
			
				break;
		
			case ServerResponse.EXPLOSION_CREATE:
		
				var ID = string(buffer_read(buff, buffer_u16));
			
				var expl = buffer_read(buff, buffer_u16);
				var _x = buffer_read(buff, buffer_s32)/100;
				var _y = buffer_read(buff, buffer_s32)/100;
				var rad = buffer_read(buff, buffer_u16);
				var dmg = buffer_read(buff, buffer_u16);
			
				explosion_create(expl, ID, _x, _y, rad, dmg);
			
				break;
			
		
			case ServerResponse.PROJECTILE_UPDATE:
		
				var _ID = buffer_read(buff, buffer_u16);
				var _x = buffer_read(buff, buffer_s32)/100;
				var _y = buffer_read(buff, buffer_s32)/100;
				var _mx = buffer_read(buff, buffer_s32)/100;
				var _my = buffer_read(buff, buffer_s32)/100;
				
				//show_debug_message("Received {0}, x: {1} y: {2}, mx: {3} my: {4}", _ID, _x, _y, _mx, _my);
			
				for(var i = 0; i < instance_number(obj_projectile); i++){
			
					var inst = instance_find(obj_projectile, i);
					if (inst.ID == _ID){
				
						var _d = point_distance(inst.x, inst.y, _x, _y);
					
						if _d>65{
						
							inst.x = _x;
							inst.y = _y;
							inst.spd = point_distance(0,0,_mx,_my);
							inst.dir = point_direction(0,0,_mx,_my);
						}
				
					}
			
				}
				break;
				
			case ServerResponse.ENTITY_CREATE:
		
			{
				
				var ind = buffer_read(buff, buffer_u16);
				var ownerID = buffer_read(buff, buffer_u16);
				var __ID = buffer_read(buff, buffer_u16);
				var _x = buffer_read(buff, buffer_s32)/100;
				var _y = buffer_read(buff, buffer_s32)/100;
				
				var mov_x = buffer_read(buff, buffer_s32)/100;
				var mov_y = buffer_read(buff, buffer_s32)/100;
				
				var hp = buffer_read(buff, buffer_u32);
				var armor = buffer_read(buff, buffer_u8)/100;
				
				var life = buffer_read(buff, buffer_u8);
				
				var params = [];
				for(var i = 0; i < entityParameterLimit; i++){
					array_push(params, buffer_read(buff, buffer_s32)/100);
					show_debug_message(params[i]);
				}
			
				entity_create(ind, ownerID, __ID, _x, _y,
				mov_x, mov_y, hp, armor, life, params);
			
				break;
		
			}
			
			case ServerResponse.ENTITY_UPDATE:
		
			{
			
				var ownerID = buffer_read(buff, buffer_u16);
				var __ID = buffer_read(buff, buffer_u16);
				
				var ent = noone;
				for(var i = 0; i < instance_number(obj_entity); i++){
					var cEnt = instance_find(obj_entity, i);
					if (cEnt.ID == __ID) {
						ent = cEnt;
						break;
					}
				}
				
				if (ent == noone) break;
				
				var _x = buffer_read(buff, buffer_s32)/100;
				var _y = buffer_read(buff, buffer_s32)/100;
				
				var mx = buffer_read(buff, buffer_s32)/100;
				var my = buffer_read(buff, buffer_s32)/100;
				
				if (ownerID != global.playerid) {
				
					ent._x = _x;
					ent._y = _y;
				
					ent.mx = mx;
					ent.my = my;
					
				}
				
				ent.hp = buffer_read(buff, buffer_u32);
				ent.armor = buffer_read(buff, buffer_u8)/100;
				
				if (ownerID != global.playerid) {
				
					for(var i = 0; i < entityParameterLimit; i++){
						ent.parameters[i] = buffer_read(buff, buffer_s32)/100;
					}
					
				}
			
				break;
		
			}
			
			case ServerResponse.ENTITY_DESTROY:
			{
				
				var entityID = buffer_read(buff, buffer_u16);
				
				for(var j = 0; j < instance_number(obj_entity); j++){
				
					var _inst = instance_find(obj_entity, j);
					
					if _inst.ID == entityID with(_inst) {
						destroy();
						instance_destroy();
					}
				
				}
				
				break;
			
			}
			
			case ServerResponse.PLAYER_DEATH: 
			{
			
				var ID = buffer_read(buff, buffer_u16);
				var killerID = buffer_read(buff, buffer_u16);
				
				if global.playerid == ID {
				
					with (obj_player) {
						playerDeath();
					}
				
				} else {
				
					with (global.players[? ID] ?? noone){
						playerOtherDeath();	
					}
				
				}
			
				break;
			}
		
		}
		
		
		
	}
	
}

