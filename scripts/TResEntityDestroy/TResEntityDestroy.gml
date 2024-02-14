function TResEntityDestroy(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.ENTITY_DESTROY) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("entityId", buffer_u16)
		.build();

	entityId = 0;
	
	static handle = function () {
	
		for(var j = 0; j < instance_number(obj_entity); j++){
				
			var inst = instance_find(obj_entity, j);
					
			if inst.ID == entityId with(inst) {
				destroy();
				instance_destroy();
			}
				
		}
	
	}

}