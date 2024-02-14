function TResUDPChannel(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.UDP_CHANNEL_IDENTIFY) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("identifier", buffer_u32)
		.build();

	identifier = 0;
	
	static handle = function () {
	
		var udpIdentify = new UReqIdentify();
		udpIdentify.identifier = identifier;
		gameserver_send(udpIdentify);
	
	}

}