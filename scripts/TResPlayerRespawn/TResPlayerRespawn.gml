function TResPlayerRespawn(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.PLAYER_RESPAWN) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("playerId", buffer_u16)
		.build();

	playerId = 0;
	
	static handle = function () {
				
		if global.playerid == playerId {
			with (obj_player) {
				state = PlayerState.FREE;
				playerhealth = playerhealthmax;
			}
		} else {
			with (global.players[? playerId] ?? noone){
				state = PlayerState.FREE;
				playerhealth = playerhealthmax;
			}
		}
	
	}

}