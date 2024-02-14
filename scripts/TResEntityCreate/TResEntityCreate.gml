function TResEntityCreate(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.ENTITY_CREATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("entityIndex", buffer_u16)
		.add("entityId", buffer_u16)
		.add("ownerId", buffer_u16)
		.add("x", buffer_s32, 100)
		.add("y", buffer_s32, 100)
		.add("mx", buffer_s32, 100)
		.add("my", buffer_s32, 100)
		.add("health", buffer_u32)
		.add("armor", buffer_u8, 100)
		.add("lifespan", buffer_u8)
		.add("param1", buffer_s32, 100)
		.add("param2", buffer_s32, 100)
		.add("param3", buffer_s32, 100)
		.add("param4", buffer_s32, 100)
		.add("param5", buffer_s32, 100)
		.build();

	entityIndex = 0;
	entityId = 0;
	ownerId = 0;
	x = 0;
	y = 0;
	mx = 0;
	my = 0;
	health = 0;
	armor = 0;
	lifespan = 0;
	param1 = 0;
	param2 = 0;
	param3 = 0;
	param4 = 0;
	param5 = 0;

	static handle = function () {
	
		var params = [param1, param2, param3, param4, param5];
			
		entity_create(entityIndex, ownerId, entityId, x, y,
		mx, my, health, armor, lifespan, params);
	
	}

}