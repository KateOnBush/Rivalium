function UReqFlip(): NetworkingPacket(NetworkingChannel.UDP, UDPServerRequest.FLIP) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("forward", buffer_u8)
		.add("start", buffer_u8, 100)
		.build();

	forward = 0;
	start = 0;

}