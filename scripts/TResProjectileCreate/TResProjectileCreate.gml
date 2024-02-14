function TResProjectileCreate(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.PROJECTILE_CREATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("ownerId", buffer_u16)
		.add("projId", buffer_u16)
		.add("projIndex", buffer_u16)
		.add("x", buffer_s32, 100)
		.add("y", buffer_s32, 100)
		.add("oldX", buffer_s32, 100)
		.add("oldY", buffer_s32, 100)
		.add("speed", buffer_s32, 100)
		.add("direction", buffer_s16, 10)
		.add("collision", buffer_u8).asBoolean()
		.add("dieOnCollision", buffer_u8).asBoolean()
		.add("bounce", buffer_u8).asBoolean()
		.add("hasWeight", buffer_u8).asBoolean()
		.add("bounceFriction", buffer_u8, 100)
		.add("lifespan", buffer_u8)
		.add("damage", buffer_u16)
		.add("bleed", buffer_u16)
		.add("heal", buffer_u16)
		.build();

	ownerId = 0;
	projId = 0;
	projIndex = 0;
	x = 0;
	y = 0;
	oldY = 0;
	oldX = 0;
	speed = 0;
	direction = 0;
	collision = 0;
	dieOnCollision = 0;
	bounce = 0;
	hasWeight = 0;
	bounceFriction = 0;
	lifespan = 0;
	damage = 0;
	bleed = 0;
	heal = 0;
	
	static handle = function() {
	
		if ownerId == global.playerid {
			with(obj_projectile){
				if (self.ID == 0){
					instance_destroy();	
				}
			}
		}
				
		var o = projectile_create(projIndex, ownerId, 
		x, y, speed, direction, 
		collision, dieOnCollision, lifespan, damage, bleed, heal, projId, bounce, oldX, oldY);
		o.bounceFriction = bounceFriction;
		o.hasGrav = hasWeight;
	
	}

}