function TReqPlayerHit(): NetworkingPacket(NetworkingChannel.TCP, TCPServerRequest.PLAYER_HIT) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("projectileId", buffer_u16)
		.add("objectId", buffer_u32)
		.add("hitId", buffer_u16)
		.add("x", buffer_s32, 100)
		.add("y", buffer_s32, 100)
		.build();

	projectileId = 0;
	objectId = 0;
	hitId = 0;
	x = 0;
	y = 0;

}