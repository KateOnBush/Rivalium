function UResEffectRemove(): NetworkingPacket(NetworkingChannel.UDP, UDPServerResponse.PLAYER_EFFECT_REMOVE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("playerId", buffer_u16)
		.add("type", buffer_u8)
		.build();

	playerId = 0;
	type = 0;
	
	static handle = function () {
			
		var player;
		if (playerId == global.playerid) player = obj_player else {
			if is_undefined(ds_map_find_value(global.players, playerId)) return;
			player = global.players[? playerId];
		}
			
		if !instance_exists(player) return;
			
		remove_effect(type, player);
	
	}

}