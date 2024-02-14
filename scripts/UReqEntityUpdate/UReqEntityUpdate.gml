function UReqEntityUpdate(): NetworkingPacket(NetworkingChannel.UDP, UDPServerRequest.ENTITY_UPDATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("entityId", buffer_u16)
		.add("x", buffer_s32, 100)
		.add("y", buffer_s32, 100)
		.add("movX", buffer_s32, 100)
		.add("movY", buffer_s32, 100)
		.add("param1", buffer_s32, 100)
		.add("param2", buffer_s32, 100)
		.add("param3", buffer_s32, 100)
		.add("param4", buffer_s32, 100)
		.add("param5", buffer_s32, 100)
		.build();

	entityId = 0;
	x = 0;
	y = 0;
	movX = 0;
	movY = 0;
	param1 = 0;
	param2 = 0;
	param3 = 0;
	param4 = 0;
	param5 = 0;

}