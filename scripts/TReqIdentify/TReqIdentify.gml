function TReqIdentify(): NetworkingPacket(NetworkingChannel.TCP, TCPServerRequest.IDENTIFY) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("pass", buffer_u32)
		.add("access", buffer_u32)
		.build();

	pass = 0;
	access = 0;

}