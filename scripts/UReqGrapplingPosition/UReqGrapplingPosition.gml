function UReqGrapplingPosition(): NetworkingPacket(NetworkingChannel.UDP, UDPServerRequest.GRAPPLING_POSITION) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("x", buffer_s32, 100)
		.add("y", buffer_s32, 100)
		.add("grappled", buffer_u8)
		.build();

	x = 0;
	y = 0;
	grappled = 0;

}