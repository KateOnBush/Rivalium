function TResTeamData(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.TEAM_DATA) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("teamNumber", buffer_u8)
		.add("score", buffer_u8)
		.add("defending", buffer_u8)
		.build();

	teamNumber = 0;
	score = 0;
	defending = 1;
	
	static handle = function() {
	
		if array_length(obj_gameplay.teams) <= teamNumber {
			obj_gameplay.teams[teamNumber] = {};
		}
		
		obj_gameplay.teams[teamNumber].score = score;
		obj_gameplay.teams[teamNumber].defending = defending;
	
	}

}