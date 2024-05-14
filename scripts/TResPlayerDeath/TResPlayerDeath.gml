function TResPlayerDeath(): NetworkingPacket(NetworkingChannel.TCP, TCPServerResponse.PLAYER_DEATH) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("killer", buffer_u16)
		.add("victim", buffer_u16)
		.add("respawnTime", buffer_u16)
		.add("assist1", buffer_u16)
		.add("assist2", buffer_u16)
		.add("assist3", buffer_u16)
		.add("assist4", buffer_u16)
		.build();

	killer = 0;
	victim = 0;
	assist1 = 0;
	assist2 = 0;
	assist3 = 0;
	assist4 = 0;
	respawnTime = 0;
	
	static handle = function () {
		
		var killer = undefined;
		if global.playerid == killer and instance_exists(obj_player) {
			killer = obj_player;
		} else {
			with (global.players[? killer] ?? noone){
				killer = self;
			}
		}
				
		if global.playerid == victim {
			with (obj_player) {
				self.killer = killer ?? self;
				playerDeath();
				respawn_time = other.respawnTime;
			}
		} else {
			with (global.players[? victim] ?? noone){
				self.killer = killer ?? self;
				playerDeath();
				respawn_time = other.respawnTime;
			}
		}
	
	}

}