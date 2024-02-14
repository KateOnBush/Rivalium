function TResPreMatch(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.PRE_MATCH) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("state", buffer_u8)
		.add("playerId", buffer_u16)
		.build();

	state = 0;
	playerId = 0;
	
	static handle = function () {
	
		switch(state) {
					
			case SERVER_PREMATCH.IDENTIFIED:
				start_loading(, "GAME LOADING");
				loading_set_game(true);
				userdata_load_prematch_data();
				break;
				
			case SERVER_PREMATCH.MATCH_STARTING:
				start_loading(, "MATCH STARTING");
				break;
						
			case SERVER_PREMATCH.MATCH_STARTED: 
				finish_loading();
				break;
				
		}
	
	}

}