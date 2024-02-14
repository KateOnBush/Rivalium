function TResProjectileDestroy(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.PROJECTILE_DESTROY) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("projId", buffer_u16)
		.build();

	projId = 0;
	
	static handle = function () {
	
		for(var i = 0; i < instance_number(obj_projectile); i++){
			
			var inst = instance_find(obj_projectile, i);
			if (inst.ID == projId){
				
				inst.on_collision();
				instance_destroy(inst);
				
			}
			
		}
	
	}

}