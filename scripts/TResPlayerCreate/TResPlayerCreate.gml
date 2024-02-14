function TResPlayerCreate(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.PLAYER_CREATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("playerId", buffer_u16)
		.add("isYou", buffer_u8)
		.add("characterId", buffer_u8)
		.add("characterHealth", buffer_u16)
		.add("characterUltimateCharge", buffer_u16)
		.add("characterMaxHealth", buffer_u16)
		.add("characterMaxUltimateCharge", buffer_u16)
		.add("x", buffer_s32, 100)
		.add("y", buffer_s32, 100)
		.build();

	playerId = 0;
	isYou = 0;
	characterId = 0;
	characterHealth = 0;
	characterUltimateCharge = 0;
	characterMaxHealth = 0;
	characterMaxUltimateCharge = 0;
	x = 0;
	y = 0;
	
	static handle = function() {
			
		if (isYou){
			
			instance_create_depth(x,y,0,obj_player)
			global.playerid = playerId;
					
			with (obj_player) { 
							
				setup_character(other.characterId); 
				playerhealthmax = other.characterMaxHealth;
				playerhealth = other.characterHealth;
				ultimatechargemax = other.characterMaxUltimateCharge;
				ultimatecharge = other.characterUltimateCharge;
							
			}
			
		} else {
			
			if is_undefined(ds_map_find_value(global.players, playerId)) {
		
				var player = instance_create_depth(x, y, 0, obj_player_other);
				player.ID = playerId;
				ds_map_add(global.players, playerId, player);
		
			}
				
			var player = global.players[? playerId];
						
			with(player) {
				setup_character(other.characterId); 
				playerhealthmax = other.characterMaxHealth;
				playerhealth = other.characterHealth;
				ultimatechargemax = other.characterMaxUltimateCharge;
				ultimatecharge = other.characterUltimateCharge;
			}
			
		}
	
	}

}