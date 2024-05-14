function UResEntityUpdate(): NetworkingPacket(NetworkingChannel.UDP, UDPServerResponse.ENTITY_UPDATE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("entityId", buffer_u16)
		.add("ownerId", buffer_u16)
		.add("x", buffer_s32, 100)
		.add("y", buffer_s32, 100)
		.add("movX", buffer_s32, 100)
		.add("movY", buffer_s32, 100)
		.add("health", buffer_u16)
		.add("armor", buffer_u8, 100)
		.add("param1", buffer_s32, 100)
		.add("param2", buffer_s32, 100)
		.add("param3", buffer_s32, 100)
		.add("param4", buffer_s32, 100)
		.add("param5", buffer_s32, 100)
		.build();

	entityId = 0;
	ownerId = 0;
	x = 0;
	y = 0;
	movX = 0;
	movY = 0;
	health = 0;
	armor = 0;
	param1 = 0;
	param2 = 0;
	param3 = 0;
	param4 = 0;
	param5 = 0;
	
	static handle = function () {
				
		var entity = noone;
		for(var i = 0; i < instance_number(obj_entity); i++){
			var thisEntity = instance_find(obj_entity, i);
			if (thisEntity.ID == entityId) {
				entity = thisEntity;
				break;
			}
		}
				
		if (entity == noone) return;
				
		if (ownerId != global.playerid) {
				
			entity._x = x;
			entity._y = y;
			entity.mx = movX;
			entity.my = movY;
			entity.parameters = [param1, param2, param3, param4, param5];
					
		}
		
		if (entity.hp != health) {
			entity.show_hp_timer = 5;
			entity.hp = health;
		}
		
		entity.armor = armor;
	
	}

}