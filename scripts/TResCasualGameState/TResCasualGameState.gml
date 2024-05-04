function TResCasualGameState(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.CASUAL_GAME_STATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("state", buffer_u8)
        .add("currentRound", buffer_u8)
        .add("defendingTeam", buffer_u8)
        .add("firstTeamScore", buffer_u8)
        .add("secondTeamScore", buffer_u8)
		.build();

	state = 0;
	currentRound = 0;
	defendingTeam = 0;
	firstTeamScore = 0;
	secondTeamScore = 0;
	
	static handle = function() {
	
		obj_gameplay.type = GameType.CASUAL;
	
		var oldState = obj_gameplay.currentState;
		var newState = state;
		var newRound = currentRound;
				
		obj_gameplay.currentState = newState;
		obj_gameplay.currentRound = newRound;
		obj_gameplay.defendingTeam = defendingTeam;
		obj_gameplay.firstTeamScore = firstTeamScore;
		obj_gameplay.secondTeamScore = secondTeamScore;
				
		if (newState != CasualGameState.PREROUND && oldState == CasualGameState.PREROUND && instance_exists(obj_player)) {
			obj_player.state = PlayerState.FREE;
		}
		
		if (oldState != CasualGameState.PREROUND && newState == CasualGameState.PREROUND && instance_exists(obj_player)) {
			obj_player.state = PlayerState.BLOCKED;
		}
	
	}

}