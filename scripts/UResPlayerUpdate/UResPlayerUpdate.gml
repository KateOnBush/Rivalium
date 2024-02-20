function UResPlayerUpdate(): NetworkingPacket(NetworkingChannel.UDP, UDPServerResponse.PLAYER_UPDATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("playerId", buffer_u16)
		.add("state", buffer_u8)
		.add("x", buffer_s32, 100)
		.add("y", buffer_s32, 100)
		.add("movX", buffer_s32, 100)
		.add("movY", buffer_s32, 100)
		.add("mouseX", buffer_s32, 100)
		.add("mouseY", buffer_s32, 100)
		.add("onGround", buffer_u8).asBoolean()
		.add("slide", buffer_u8).asBoolean()
		.add("direction", buffer_u8).asBoolean()
		.add("characterId", buffer_u8)
		.add("characterHealth", buffer_u16)
		.add("characterMaxHealth", buffer_u16)
		.add("characterUltimateCharge", buffer_u16)
		.add("characterMaxUltimateCharge", buffer_u16)
		.build();

	playerId = 0;
	state = 0;
	x = 0;
	y = 0;
	movX = 0;
	movY = 0;
	mouseX = 0;
	mouseY = 0;
	onGround = 0;
	slide = 0;
	direction = 0;
	characterId = 0;
	characterHealth = 0;
	characterMaxHealth = 0;
	characterUltimateCharge = 0;
	characterMaxUltimateCharge = 0;
	
	static handle = function() {
		
		if (playerId == global.playerid) {
					
			with (obj_player) {
				
				rec_x = other.x;
				rec_y = other.y;
				rec_mx = other.movX;
				rec_my = other.movY;
				playerhealth = other.characterHealth;
				playerhealthmax = other.characterMaxHealth;
				ultimatecharge = other.characterUltimateCharge;
				ultimatechargemax = other.characterMaxUltimateCharge;
				if (character_id != other.characterId) {
					setup_character(other.characterId);
				}
				
			}
			return;
		}
			
		if is_undefined(ds_map_find_value(global.players, playerId)) return;
		
		var player = global.players[? playerId];
			
		with(player){
			
			ux = dtlerp(x, other.x, 0.95);
			uy = dtlerp(y, other.y, 0.95);

			if place_meeting(ux, y, obj_solid){

				var k = 0.95;

				while(place_meeting(ux, y, obj_solid) && k != 0){
	
					k -= 0.05;
					ux = dtlerp(x, other.x, k);
		
				}

			}

			if place_meeting(ux, uy, obj_solid){

				var k = 0.95;

				while(place_meeting(ux, uy, obj_solid) && k != 0){
	
					k -= 0.05;
					uy = dtlerp(y, other.y, k);
		
				}

			}
					
			state = other.state;
					
			movvec.x = other.movX;
			movvec.y = other.movY;
			
			updated = current_time;
			
			on_ground = other.onGround;
			dir = other.direction ? 1 : -1;
			slide = other.slide;
			playerhealth = other.characterHealth;
			ultimatecharge = other.characterUltimateCharge;
			playerhealthmax = other.characterMaxHealth;
			ultimatechargemax = other.characterMaxUltimateCharge;
			if (character_id != other.characterId) {
				setup_character(other.characterId);
			}
			mousex = other.mouseX;
			mousey = other.mouseY;
			
		}
	
	}

}