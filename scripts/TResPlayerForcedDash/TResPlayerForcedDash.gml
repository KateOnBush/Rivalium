function TResPlayerForcedDash(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.PLAYER_FORCED_DASH) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("playerId", buffer_u16)
		.add("direction", buffer_s16, 100)
		.add("time", buffer_u16, 100)
		.add("mult", buffer_u16, 100)
		.build();

	playerId = 0;
	direction = 0;
	time = 0;
	mult = 0;
	
	static handle = function() {
	
		if (playerId == global.playerid && instance_exists(obj_player)) {
				
			with(obj_player){
				playerDash(other.direction, other.time, other.mult);
			}
				
		}
	
	}

}