function TResExplosionCreate(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.EXPLOSION_CREATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("ownerId", buffer_u16)
		.add("explosionIndex", buffer_u16)
		.add("x", buffer_s32, 100)
		.add("y", buffer_s32, 100)
		.add("radius", buffer_u16)
		.add("damage", buffer_u16)
		.build();

	ownerId = 0;
	explosionIndex = 0;
	x = 0;
	y = 0;
	radius = 0;
	damage = 0;
	
	static handle = function () {
	
		explosion_create(explosionIndex, ownerId, x, y, radius, damage);
	
	}

}