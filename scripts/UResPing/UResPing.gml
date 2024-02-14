function UResPing(): NetworkingPacket(NetworkingChannel.UDP, UDPServerResponse.PING) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("requesting", buffer_u8)
		.add("ping", buffer_u16)
		.build();

	requesting = 0;
	ping = 0;
	
	static handle = function() {
	
		if (requesting) {
			
			var pingMessage = new UReqPing();
			gameserver_send(pingMessage);
				
		} else {
			
			global.ping = ping;
			
		}
	
	}
	

}