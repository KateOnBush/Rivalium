function TResOrbCreate(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.ENTITY_CREATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("entityId", buffer_u16)
		.add("ownerId", buffer_u16)
		.add("orbType", buffer_u8)
		.add("x", buffer_s32, 100)
		.add("y", buffer_s32, 100)
		.add("lifespan", buffer_u8)
		.build();

	orbType = 0;
	entityId = 0;
	ownerId = 0;
	x = 0;
	y = 0;
	lifespan = 0;

	static handle = function () {
	
		var o = instance_create_depth(x, y, 0, obj_orb);
		o.type = orbType;
		o._x = x;
		o._y = y;
		o.ownerID = ownerId;
		o.ID = entityId;
		o.mx = 0;
		o.my = 0;
		o.hp = 100;
		o.armor = 1;
		o.lifespan = lifespan;
	
	}

}