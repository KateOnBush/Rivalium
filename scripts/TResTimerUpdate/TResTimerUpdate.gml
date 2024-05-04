function TResTimerUpdate(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.TIMER_UPDATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("timer", buffer_u8)
		.add("timerType", buffer_u8)
		.build();

	timer = 0;
	timerType = 0;
	
	static handle = function() {
	
		if (!instance_exists(obj_player)) return;
	
		obj_player.timer_real = timer;
		obj_player.timer_type = timerType;
	
	}

}