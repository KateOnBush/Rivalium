function TResEffectAdd(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.EFFECT_ADD) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("playerId", buffer_u16)
		.add("type", buffer_u8)
		.add("duration", buffer_u16, 100)
		.add("multiplier", buffer_u16, 100)
		.build();

	playerId = 0;
	type = 0;
	duration = 0;
	multiplier = 0;
	
	static handle = function () {
			
		var player;
		if (playerId == global.playerid) player = obj_player else {
			if is_undefined(ds_map_find_value(global.players, playerId)) return;
			player = global.players[? playerId];
		}
			
		if !instance_exists(player) return;
		
		var data = {};
			
		if (type == EFFECT.ACCELERATION || type == EFFECT.SLOW) data.multiplier = multiplier;
			
		add_effect(type, duration, data, player);
	
	}

}