function UReqPositionUpdate(): NetworkingPacket(NetworkingChannel.UDP, UDPServerRequest.POSITION_UPDATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("counter", buffer_u32)
		.add("x", buffer_s32, 100)
		.add("y", buffer_s32, 100)
		.add("movX", buffer_s32, 100)
		.add("movY", buffer_s32, 100)
		.add("mouseX", buffer_s32, 100)
		.add("mouseY", buffer_s32, 100)
		.add("state", buffer_u8)
		.add("onGround", buffer_u8).asBoolean()
		.add("slide", buffer_u8).asBoolean()
		.add("orientation", buffer_u8).asBoolean()
		.build();

	counter = 0;
	x = 0;
	y = 0;
	movX = 0;
	movY = 0;
	mouseX = 0;
	mouseY = 0;
	state = 0;
	onGround = 0;
	slide = 0;
	orientation = 0;

}