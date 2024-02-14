function UResProjectileUpdate(): NetworkingPacket(NetworkingChannel.UDP, UDPServerResponse.PROJECTILE_UPDATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("projectileId", buffer_u16)
		.add("x", buffer_s32, 100)
		.add("y", buffer_s32, 100)
		.add("movX", buffer_s32, 100)
		.add("movY", buffer_s32, 100)
		.build();

	projectileId = 0;
	x = 0;
	y = 0;
	movX = 0;
	movY = 0;
	
	static handle = function () {
	
		for(var i = 0; i < instance_number(obj_projectile); i++){
			
			var inst = instance_find(obj_projectile, i);
			if (inst.ID == projectileId){
				
				var _d = point_distance(inst.x, inst.y, x, y);
					
				if _d > 65 {
						
					inst.x = x;
					inst.y = y;
					inst.spd = point_distance(0, 0, movX, movY);
					inst.dir = point_direction(0, 0, movX, movY);
				}
				
			}
			
		}
	
	}

}