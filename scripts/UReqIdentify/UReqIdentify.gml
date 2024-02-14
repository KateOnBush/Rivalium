function UReqIdentify(): NetworkingPacket(NetworkingChannel.UDP, UDPServerRequest.IDENTIFY) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("identifier", buffer_u32)
		.build();

	identifier = 0;

}