function UReqProjectileUpdate(): NetworkingPacket(NetworkingChannel.UDP, UDPServerRequest.PROJECTILE_UPDATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("projId", buffer_u16)
		.add("x", buffer_s32, 100)
		.add("y", buffer_s32, 100)
		.add("movX", buffer_s32, 100)
		.add("movY", buffer_s32, 100)
		.build();

	projId = 0;
	x = 0;
	y = 0;
	movX = 0;
	movY = 0;

}