function UResPlayerFlip(): NetworkingPacket(NetworkingChannel.UDP, UDPServerResponse.PLAYER_FLIP) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("playerId", buffer_u16)
		.add("forward", buffer_u8)
		.add("start", buffer_u8, 100)
		.build();

	playerId = 0;
	forward = 0;
	start = 0;
	
	static handle = function () {
		
		if (playerId == global.playerid) return;
		var player = global.players[? playerId];
		if is_undefined(player) return;
		
		with(player){
			perform_flip(other.forward, other.start);
		}
	
	}

}