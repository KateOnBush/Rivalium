function TReqEntityHit(): NetworkingPacket(NetworkingChannel.TCP, TCPServerRequest.ENTITY_HIT) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("projectileId", buffer_u16)
		.add("entityId", buffer_u16)
		.build();

	projectileId = 0;
	entityId = 0;

}