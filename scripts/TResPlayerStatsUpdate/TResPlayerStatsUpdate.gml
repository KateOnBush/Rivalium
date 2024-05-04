function TResPlayerStatsUpdate(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.PLAYER_STATS_UPDATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("playerId", buffer_u16)
		.add("kills", buffer_u16)
		.add("deaths", buffer_u16)
		.add("assists", buffer_u16)
		.add("gemPlants", buffer_u16)
		.build();

	playerId = 0;
	kills = 0;
	deaths = 0;
	assists = 0;
	gemPlants = 0;
	
	static handle = function() {
			
		var player = noone;
		if (playerId == global.playerid) player = obj_player;
		if (global.players[? playerId] != undefined) player = global.players[? playerId];
		with (player) {
			kills = other.kills;
			deaths = other.deaths;
			assists = other.assists;
			gem_plants = other.gemPlants;
		}
	
	}

}