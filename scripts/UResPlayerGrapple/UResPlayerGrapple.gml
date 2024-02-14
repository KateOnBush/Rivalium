function UResPlayerGrapple(): NetworkingPacket(NetworkingChannel.UDP, UDPServerResponse.PLAYER_GRAPPLE) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("playerId", buffer_u16)
		.add("x", buffer_s32, 100)
		.add("y", buffer_s32, 100)
		.add("grappled", buffer_u8)
		.build();

	playerId = 0;
	x = 0;
	y = 0;
	grappled = 0;
	
	static handle = function () {
	
		if (playerId == global.playerid) return;
		var player = global.players[? playerId];
		if is_undefined(player) return;
			
		if grappled {
			
			player.grappling_coords_init = [x, y];
			player.grappling_coords = [x,y];
			player.grappled = true;
			player.grappling = true;
			
		} else {
			
			player.grappling_coords_init = [x, y];
			player.grappling_coords = [x,y];
			player.grappling = true;
			player.grappling_len = 0;
			
		}
	
	}

}