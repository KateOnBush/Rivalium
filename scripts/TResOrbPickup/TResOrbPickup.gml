function TResOrbPickup(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.ORB_PICKUP) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("entityId", buffer_u16)
		.add("playerId", buffer_u16)
		.build();

	entityId = 0;
	playerId = 0;
	
	static handle = function () {
		
		var player = noone;
		if (playerId == global.playerid) player = obj_player;
		if (global.players[? playerId] != undefined) player = global.players[? playerId];
	
		for(var j = 0; j < instance_number(obj_orb); j++){
				
			var inst = instance_find(obj_orb, j);
			if inst.ID == entityId {
				inst.pickedup = player;
				break;
			}
				
		}
	
	}

}