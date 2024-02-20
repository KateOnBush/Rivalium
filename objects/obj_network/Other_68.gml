/// @description Insert description here
// You can write your code in this editor

if (async_load[? "id"] != TCPsocket && async_load[? "id"] != UDPsocket) exit;

var dataSize = global.dataSize;

if async_load[? "type"] == network_type_data {
	
	var buffer = async_load[? "buffer"];
	var received_size = buffer_get_size(buffer);
	buffer_seek(buffer, buffer_seek_start, 0);

	if (async_load[? "id"] == TCPsocket) { //TCP Packet
	
		while(buffer_tell(buffer) < received_size) {
			var index = buffer_read(buffer, buffer_u8);
			var constructedPacket = undefined;
			switch(index) {
                case TCPServerResponse.EFFECT_ADD:
                        constructedPacket = new TResEffectAdd();
                        break;
                case TCPServerResponse.ENTITY_CREATE:
                        constructedPacket = new TResEntityCreate();
                        break;
                case TCPServerResponse.ENTITY_DESTROY:
                        constructedPacket = new TResEntityDestroy();
                        break;
                case TCPServerResponse.EXPLOSION_CREATE:
                        constructedPacket = new TResExplosionCreate();
                        break;
                case TCPServerResponse.GAME_STATE:
                        constructedPacket = new TResGameState();
                        break;
                case TCPServerResponse.PLAYER_ABILITY_CAST:
                        constructedPacket = new TResPlayerAbilityCast();
                        break;
                case TCPServerResponse.PLAYER_CONNECTION:
                        constructedPacket = new TResPlayerConnection();
                        break;
                case TCPServerResponse.PLAYER_CREATE:
                        constructedPacket = new TResPlayerCreate();
                        break;
                case TCPServerResponse.PLAYER_DEATH:
                        constructedPacket = new TResPlayerDeath();
                        break;
                case TCPServerResponse.PLAYER_FORCED_DASH:
                        constructedPacket = new TResPlayerForcedDash();
                        break;
                case TCPServerResponse.PRE_MATCH:
                        constructedPacket = new TResPreMatch();
                        break;
                case TCPServerResponse.PROJECTILE_CREATE:
                        constructedPacket = new TResProjectileCreate();
                        break;
                case TCPServerResponse.PROJECTILE_DESTROY:
                        constructedPacket = new TResProjectileDestroy();
                        break;
				case TCPServerResponse.UDP_CHANNEL_IDENTIFY:
						constructedPacket = new TResUDPChannel();
						show_debug_message("received identify udp");
						break;
			}
			
			if is_undefined(constructedPacket) break;
			var length = buffer_read(buffer, buffer_u8);
			if (constructedPacket.getSize() != length) break;
			if (buffer_tell(buffer) + length > received_size) break;
			var numberOfAttributes = array_length(constructedPacket.attributes), attributes = constructedPacket.attributes;
			var booleanStreak = 0, readBoolean = 0;
			for(var i = 0; i < numberOfAttributes; i++) {
				var attribute = attributes[i];
				if (attribute.boolean) {
	                if (booleanStreak == 0) {
	                    readBoolean = buffer_read(buffer, buffer_u8);
	                }
	                constructedPacket[$ attribute.name] = (readBoolean >> booleanStreak) & 1;
	                booleanStreak++;
	                if (booleanStreak >= 8) booleanStreak = 0;
	                continue;
	            }
	            var valueRead = buffer_read(buffer, attribute.type);
	            constructedPacket[$ attribute.name] = valueRead / attribute.multiplier;
			}
			constructedPacket.handle();
		}
	
	} else { //UDP Packet
	
		var index = buffer_read(buffer, buffer_u8);
		var constructedPacket = undefined;
		switch(index) {
            case UDPServerResponse.ENTITY_UPDATE:
                    constructedPacket = new UResEntityUpdate();
                    break;
            case UDPServerResponse.PING:
                    constructedPacket = new UResPing();
                    break;
            case UDPServerResponse.PLAYER_FLIP:
                    constructedPacket = new UResPlayerFlip();
                    break;
            case UDPServerResponse.PLAYER_GRAPPLE:
                    constructedPacket = new UResPlayerGrapple();
                    break;
            case UDPServerResponse.PLAYER_UPDATE:
                    constructedPacket = new UResPlayerUpdate();
                    break;
            case UDPServerResponse.PROJECTILE_UPDATE:
                    constructedPacket = new UResProjectileUpdate();
                    break;
			case UDPServerResponse.PLAYER_HIT:
                    constructedPacket = new UResPlayerHit();
                    break;
		}
		if (constructedPacket == undefined) {
			show_debug_message("[udp] undefined packet");
			exit;
		}
		var length = buffer_read(buffer, buffer_u8);
		if (constructedPacket.getSize() != length) {
			show_debug_message("[udp] inaccurate length {0}", index);
			exit;
		}
		if (length + 4 != received_size) {
			show_debug_message("[udp] wrong length {0}", index);
			exit;
		};
		var numberOfAttributes = array_length(constructedPacket.attributes), attributes = constructedPacket.attributes;
		var booleanStreak = 0, readBoolean = 0, checksum = 0, consecutiveXOR = 0;
		for(var i = 0; i < numberOfAttributes; i++) {
			var attribute = attributes[i];
			if (attribute.boolean) {
	            if (booleanStreak == 0) {
	                readBoolean = buffer_read(buffer, buffer_u8);
	                consecutiveXOR = consecutiveXOR ^ readBoolean;
	                checksum += get_bit_count(readBoolean);
	            }
	            constructedPacket[$ attribute.name] = (readBoolean >> booleanStreak) & 1;
	            booleanStreak++;
	            if (booleanStreak >= 8) booleanStreak = 0;
	            continue;
	        }
			booleanStreak = 0;
	        var valueRead = buffer_read(buffer, attribute.type), valueSizeInBytes = 0;
			switch(attribute.type) {
					case buffer_u8:
					case buffer_s8:
						valueSizeInBytes=1;
						break;
					case buffer_u16:
					case buffer_s16:
					case buffer_f16:
						valueSizeInBytes=2;
						break;
					case buffer_u32:
					case buffer_s32:
					case buffer_f32:
						valueSizeInBytes=4;
						break;
				}
			while(valueSizeInBytes > 0) {
	            var integer = buffer_peek(buffer, buffer_tell(buffer) - valueSizeInBytes, buffer_u8);
	            consecutiveXOR = consecutiveXOR ^ integer;
	            checksum += get_bit_count(integer);
	            valueSizeInBytes--;
	        }
	        constructedPacket[$ attribute.name] = valueRead / attribute.multiplier;
		}
		checksum %= 256;
		var readXOR = buffer_read(buffer, buffer_u8);
		var readChecksum = buffer_read(buffer, buffer_u8);
	    if (readChecksum != checksum || readXOR != consecutiveXOR) {
			show_debug_message("[udp] wrong checksum {0}, read: {1} {2}, calculated: {3} {4} (s-xor)", index, readChecksum, readXOR, checksum, consecutiveXOR);
			exit;
		}
		constructedPacket.handle();
	
	}

} else if async_load[? "type"] == network_type_non_blocking_connect {
	
	global.connected = async_load[? "succeeded"];
	if (!global.connected) {
		show_debug_message("nigga da server down?");
		//couldnt connect	
		exit;
	}
	
	start_loading(, "JOINING GAME");
	
	var identify = new TReqIdentify();
	
	identify.pass = MatchPass;
	identify.access = MatchPlayerAccess;
	
	gameserver_send(identify);
	
}

