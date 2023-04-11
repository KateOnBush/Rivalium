/// @description Insert description here
// You can write your code in this editor

var dataSize = global.dataSize;



if async_load[? "type"] == network_type_data {

	var buff = async_load[? "buffer"];
	buffer_seek(buff, buffer_seek_start, 0);
	
	var size = async_load[? "size"]

	var nPackets = (size) div dataSize;
	
	for(var currentPacket = 0; currentPacket < nPackets; currentPacket++){

		buffer_seek(buff, buffer_seek_start, dataSize*currentPacket);
		
		var type = buffer_read(buff, buffer_u8);
		
		switch(type) {
		
			case SERVER_RESPONSE.PLAYER_JOIN:
			
				var ID = buffer_read(buff, buffer_u16);
				var connect = buffer_read(buff, buffer_u8);
				var isme = buffer_read(buff, buffer_u8);
				var charid = buffer_read(buff, buffer_u8);
				var maxhp = buffer_read(buff, buffer_u16);
				var maxult = buffer_read(buff, buffer_u16);
			
				var _x = buffer_read(buff, buffer_s32)/100;
				var _y = buffer_read(buff, buffer_s32)/100;
			
				if (connect) {
			
					if (isme){
			
						instance_create_depth(_x,_y,0,obj_player)
						global.playerid = ID;
					
						obj_player.setup_character(charid)


						obj_player.playerhealthmax = real(maxhp);
						obj_player.playerhealth = real(maxhp);
						obj_player.ultimatechargemax = real(maxult);
						obj_player.ultimatecharge = 220;
			
					} else {
			
						if is_undefined(ds_map_find_value(global.players, ID)) {
		
							var player = instance_create_depth(_x, _y, 0, obj_player_other);
							player.ID = ID;
							ds_map_add(global.players, ID, player);
		
						}
				
						var p = global.players[? ID];
				
						p.character_id = charid;
						p.playerhealthmax = maxhp;
						p.playerhealth = maxhp;
						p.ultimatechargemax = maxult;
						p.ultimatecharge = 0;
				
			
					}
				
				}
			
				break;
			
			case SERVER_RESPONSE.PLAYER_UPDATE:
	
				if global.playerid == -1 continue;
			
				var ID = buffer_read(buff, buffer_u16);
		
				var _x = buffer_read(buff, buffer_s32)/100;
				var _y = buffer_read(buff, buffer_s32)/100;
				var movvecx = buffer_read(buff, buffer_s32)/100;
				var movvecy = buffer_read(buff, buffer_s32)/100;
		
				if (ID == global.playerid) {
			
					buffer_seek(buff, buffer_seek_start,dataSize*currentPacket + 30);
					var hp = buffer_read(buff, buffer_u16);
					var ch = buffer_read(buff, buffer_u16);
					var dead = buffer_read(buff, buffer_u8);
				
					obj_player.rec_x = _x;
					obj_player.rec_y = _y;
					obj_player.rec_mx = movvecx;
					obj_player.rec_my = movvecy;
					obj_player.playerhealth = real(hp);
					obj_player.ultimatecharge = real(ch);
					obj_player.dead = dead;
				
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
				
			
				}
			
				p.movvec.x = movvecx;
				p.movvec.y = movvecy;
			
				p.updated = current_time;
			
				p.on_ground = buffer_read(buff, buffer_u8);
				p.run = buffer_read(buff, buffer_u8)/100;
				p.jump_prep = buffer_read(buff, buffer_u8)/100;
				p.wall_slide = buffer_read(buff, buffer_u8);
				p.grappling = buffer_read(buff, buffer_u8);
				p.grappled = buffer_read(buff, buffer_u8);
				p.dir = buffer_read(buff, buffer_s8);
				p.dash = buffer_read(buff, buffer_u8);
				p.slide = buffer_read(buff, buffer_u8);
				p.grounded = buffer_read(buff, buffer_u8);
				p.slope_blend = buffer_read(buff, buffer_u8)/100;
				p.playerhealth = real(buffer_read(buff, buffer_u16));
				p.ultimatecharge = real(buffer_read(buff, buffer_u16));
				p.playerhealthmax = real(buffer_read(buff, buffer_u16));
				p.ultimatechargemax = real(buffer_read(buff, buffer_u16));
				var char_id = buffer_read(buff, buffer_u8);
				p.setup_character(char_id);
				p.dead = buffer_read(buff, buffer_u8);
				p.mousex = buffer_read(buff, buffer_s32)/100;
				p.mousey = buffer_read(buff, buffer_s32)/100;
			
				break;
	
			case SERVER_RESPONSE.PLAYER_GRAPPLE:
	
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
			
		
			case SERVER_RESPONSE.PLAYER_FLIP:
	
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
			
			case SERVER_RESPONSE.PING:
		
				var st = buffer_read(buff, buffer_u8);
				if(st == 0){
			
					var b = buffer_create(dataSize, buffer_fixed, 1);
					buffer_seek(b, buffer_seek_start, 0);
					buffer_write(b, buffer_u8, SERVER_REQUEST.PING);
				
					network_send_raw(obj_network.server, b, buffer_get_size(b));
				
					buffer_delete(b);
				
				
				} else {
			
					global.ping = real(buffer_read(buff, buffer_u32));
			
				}
			
				break;
		
			case SERVER_RESPONSE.PROJECTILE_CREATE: //Projectile
		
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
			
				if ownerid == global.playerid {
					
					with(obj_projectile){
						show_debug_message("Checking for: {0}", self.ID);
						if (self.ID == 0){
							instance_destroy();	
						}
					}
				}
				
				projectile_create(ob, ownerid, _x, _y, sp, dr, col, dieoncol, lifespan, damage, bleed, heal, ID, bounce, __px, __py);
		
				break;
			
		
			case SERVER_RESPONSE.PLAYER_HIT:
		
				var hit = buffer_read(buff, buffer_u16);
				if (hit == global.playerid){
			
					obj_player.hit();
			
				}
			
				break;
		
			case SERVER_RESPONSE.PROJECTILE_DESTROY:
		
				var proj = buffer_read(buff, buffer_u16);
				for(var i = 0; i < instance_number(obj_projectile); i++){
			
					var inst = instance_find(obj_projectile, i);
					if (inst.ID == proj){
				
						inst.on_collision();
						instance_destroy(inst);
				
					}
			
				}
				break;
		
			case SERVER_RESPONSE.PLAYER_ABILITY_CAST:
		
				var ID = string(buffer_read(buff, buffer_u16));
			
				if is_undefined(ds_map_find_value(global.players, ID)) && ID != global.playerid continue;
			
				var p = global.players[? ID];
			
				var abi = buffer_read(buff, buffer_u8);
			
				var abi_n = buffer_read(buff, buffer_u8);
			
				if (ID == global.playerid) {
					obj_player.cast_ability(abi, abi_n)
				} else {
					with(p) cast_ability(abi, abi_n);
				}
				
				break;
		
			case SERVER_RESPONSE.EFFECT_ADD: 
		
				var ID = string(buffer_read(buff, buffer_u16));
			
				var p;
			
				if (ID == global.playerid) p = obj_player else {
			
					if is_undefined(ds_map_find_value(global.players, ID)) continue;
			
					p = global.players[? ID];
				
				}
			
				if !instance_exists(p) continue;
			
				var e_type = buffer_read(buff, buffer_u8);
			
				var e_duration = buffer_read(buff, buffer_u16)/100;
			
				var e_data = {};
			
				if (e_type == effecttype.boost || e_type == effecttype.slow) e_data = {multiplier: buffer_read(buff, buffer_u16)/100};
			
				show_debug_message("speedy speed!");
			
				add_effect(e_type, e_duration, e_data, p);
			
				break;
		
			case SERVER_RESPONSE.EXPLOSION_CREATE:
		
				var ID = string(buffer_read(buff, buffer_u16));
			
				var expl = buffer_read(buff, buffer_u16);
				var _x = buffer_read(buff, buffer_s32)/100;
				var _y = buffer_read(buff, buffer_s32)/100;
				var rad = buffer_read(buff, buffer_u16);
				var dmg = buffer_read(buff, buffer_u16);
			
				explosion_create(expl, ID, _x, _y, rad, dmg);
			
				break;
			
		
			case SERVER_RESPONSE.PROJECTILE_UPDATE:
		
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
				
			case SERVER_RESPONSE.ENTITY_UPDATE:
		
			{
				
				var ind = buffer_read(buff, buffer_u16);
				var ownerID = string(buffer_read(buff, buffer_u16));
				var __ID = buffer_read(buff, buffer_u16);
				var temp_x = buffer_read(buff, buffer_s32)/100;
				var temp_y = buffer_read(buff, buffer_s32)/100;
				
				var hasPhysicsComponent = buffer_read(buff, buffer_u8);
				var mov_x = buffer_read(buff, buffer_s32)/100;
				var mov_y = buffer_read(buff, buffer_s32)/100;
				
				var hasHealthComponent = buffer_read(buff, buffer_u8);
				var hp = buffer_read(buff, buffer_u32);
				var armor = buffer_read(buff, buffer_u8)/100;
				
				var params = [];
				for(var i = 0; i < entityParameterLimit; i++){
					array_push(params, buffer_read(buff, buffer_s32)/100);	
				}
				
				var exists = false;
				var already = 0;
				for(var j = 0; j < instance_number(obj_entity); j++){
					
					already = instance_find(obj_entity, j);
					if already.ID == __ID {
						exists = true;
						break;	
					}
					
				}
				
				if !exists {
					
					entity_create(ind, ownerID, __ID, temp_x, temp_y,
					hasPhysicsComponent ? new EntityPhysicsComponent(new Vector2(mov_x, mov_y)) : undefined,
					hasHealthComponent ? new EntityHealthComponent(hp, armor) : undefined,
					params);
					
				} else {
				
					if ownerID == global.playerid break;
				
					already.physicsComponent = hasPhysicsComponent ? new EntityPhysicsComponent(new Vector2(mov_x, mov_y)) : undefined;
					already.healthComponent = hasHealthComponent ? new EntityHealthComponent(hp, armor) : undefined;
					already.x = temp_x;
					already.y = temp_y;
					already.ownerID = ownerID;
					already.parameters = params;
				
				}
				
			
				break;
		
			}
			
			case SERVER_RESPONSE.ENTITY_DESTROY:
			{
				
				var entityID = buffer_read(buff, buffer_u16);
				
				show_debug_message(string(entityID) + " is being destroyed!");
				
				for(var j = 0; j < instance_number(obj_entity); j++){
				
					var _inst = instance_find(obj_entity, j);
					
					if _inst.ID == entityID with(_inst) {
						destroy();
						instance_destroy();
					}
				
				}
				
				break;
			
			}
		
		}
		
		
		
	}
	
}

