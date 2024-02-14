function TResPlayerAbilityCast(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.PLAYER_ABILITY_CAST) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("id", buffer_u16)
		.add("ability", buffer_u8)
		.add("abilityN", buffer_u8)
		.build();

	id = 0;
	ability = 0;
	abilityN = 0;
	
	static handle = function () {
	
		var player = global.players[? id];
		if (id == global.playerid && instance_exists(obj_player)) player = obj_player;
				
		if (player == undefined) return;
			
		with(player) {
			cast_ability(other.ability, other.abilityN);
		}
	
	}

}