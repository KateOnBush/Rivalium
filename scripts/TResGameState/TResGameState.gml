function TResGameState(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.GAME_STATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("state", buffer_u8)
		.add("currentRound", buffer_u8)
		.add("timer", buffer_u8)
		.build();

	state = 0;
	currentRound = 0;
	timer = 0;
	
	static handle = function() {
	
		var newState = state;
		var newRound = currentRound;
		var startingIn = timer;
				
		obj_gameplay.currentState = newState;
		obj_gameplay.currentRound = newRound;
		obj_gameplay.startingIn = startingIn;
				
		if (newState != GameState.PREROUND && instance_exists(obj_player)) {
			obj_player.GUIText = "";
			obj_player.state = PlayerState.FREE;
		}
	
	}

}