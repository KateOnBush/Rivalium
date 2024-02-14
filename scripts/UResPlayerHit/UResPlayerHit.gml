function UResPlayerHit(): NetworkingPacket(NetworkingChannel.UDP, UDPServerResponse.PLAYER_HIT) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("playerId", buffer_u16)
		.add("attackerId", buffer_u16)
		.add("visual", buffer_u8).asBoolean()
		.build();

	playerId = 0;
	attackerId = 0;
	visual = 0;
	
	static handle = function() {
	
		var player = noone;
		if (playerId == global.playerid) player = obj_player;
		if (global.players[? playerId]) player = global.players[? playerId];
		with (player) {
			playerHit(other.visual);	
		}
	
	}

}