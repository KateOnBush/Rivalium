function TResPlayerDeath(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.PLAYER_DEATH) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("killer", buffer_u16)
		.add("victim", buffer_u16)
		.build();

	killer = 0;
	victim = 0;
	
	static handle = function () {
				
		if global.playerid == victim {
				
			with (obj_player) {
				playerDeath();
			}
				
		} else {
				
			with (global.players[? victim] ?? noone){
				playerDeath();
			}
				
		}
	
	}

}