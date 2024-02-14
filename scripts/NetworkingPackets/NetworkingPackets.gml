enum NetworkingChannel {
	TCP,
	UDP
}

function NetworkingPacket(packet_channel, packet_index) constructor {
	
	channel = packet_channel;
	static attributes = [];
	index = packet_index;
	
	buffer = -1;
	
	static getSize = function(){
		var att = self.attributes, size = 0, booleanStreak = 0;
		for(var i = 0; i < array_length(att); i++) {
			var currentAttribute = att[i];
			if (!currentAttribute.boolean) {
                booleanStreak = 0;
                switch(currentAttribute.type) {
					case buffer_u8:
					case buffer_s8:
						size+=1;
						break;
					case buffer_u16:
					case buffer_s16:
					case buffer_f16:
						size+=2;
						break;
					case buffer_u32:
					case buffer_s32:
					case buffer_f32:
						size+=4;
						break;
				}
                continue;
            }
            if (booleanStreak == 0) size+=1;
            if (booleanStreak == 8) { booleanStreak = 0; size+=1; }
            booleanStreak++;
		}
		return size;
	}
	
	static bake = function(){
		
		var size = getSize(); 
		var fullSize = self.channel == NetworkingChannel.TCP ? size + 2 : size + 4;
		if (!buffer_exists(self.buffer) || buffer_get_size(self.buffer) != fullSize) {
			if (buffer_exists(self.buffer)) buffer_delete(self.buffer);
			self.buffer = buffer_create(fullSize, buffer_fixed, 1);
		}
		
		// ! UDP: Index(1 byte) + Length<Data>(1 byte) + Data + Checksum<Data>(2 byte)
        // * Checksum = ConsecutiveXOR(1 byte) + BitSum(1 byte)
        // ! TCP: Index(1 byte) + Length<Data>(1 byte) + Data
		
		buffer_seek(self.buffer, buffer_seek_start, 0);
		buffer_write(self.buffer, buffer_u8, self.index);
		buffer_write(self.buffer, buffer_u8, size);
		var booleanStreak = 0, builtBoolean = 0, consecutiveXOR = 0, checksum = 0, needsValidation = (self.channel == NetworkingChannel.UDP);
		var attributeSize = array_length(self.attributes);
		for(var i = 0; i < attributeSize; i++) {
			var attribute = self.attributes[i];
			var value = self[$ attribute.name] ?? 0;
            if (!attribute.boolean) {
                if (booleanStreak != 0) {
					buffer_write(self.buffer, buffer_u8, builtBoolean);
					if (needsValidation) {
						checksum += get_bit_count(builtBoolean);
						consecutiveXOR = consecutiveXOR ^ builtBoolean;
					}
				}
                if (attribute.multiplier == 1) buffer_write(self.buffer, attribute.type, value);
                else buffer_write(self.buffer, attribute.type, round(value * attribute.multiplier));
                if (needsValidation) {
					var writtenSize, correspondingType;
					switch(attribute.type) {
						case buffer_u8:
						case buffer_s8:
							writtenSize=1;
							correspondingType=buffer_u8;
							break;
						case buffer_u16:
						case buffer_s16:
						case buffer_f16:
							writtenSize=2;
							correspondingType=buffer_u16;
							break;
						case buffer_u32:
						case buffer_s32:
						case buffer_f32:
							writtenSize=4;
							correspondingType=buffer_u32;
							break;
					}
					var readValue = buffer_peek(self.buffer, buffer_tell(self.buffer) - writtenSize, correspondingType);
					checksum += get_bit_count(readValue);
					while(writtenSize > 0) {
						consecutiveXOR = consecutiveXOR ^ (readValue & 0xFF);
						readValue = readValue >> 8;
						writtenSize--;
					}
				}
                booleanStreak = 0;
                continue;
            }
            builtBoolean |= ((value & 1) << booleanStreak++);
            if (booleanStreak == 8 || i == attributeSize - 1) {
                buffer_write(self.buffer, buffer_u8, builtBoolean);
                if (needsValidation) {
					checksum += get_bit_count(builtBoolean);
					consecutiveXOR = consecutiveXOR ^ builtBoolean;
				}
                booleanStreak = 0;
            }
		}
		if (needsValidation) {
			checksum &= 0xFF;
			consecutiveXOR &= 0xFF;
			buffer_write(self.buffer, buffer_u8, consecutiveXOR);
			buffer_write(self.buffer, buffer_u8, checksum);
		}
		return self.buffer;
		
	}
	
	static clear = function(){
		buffer_delete(self.buffer);
	}
	
}

function gameserver_send(packet, clear = true) {

	if (!instance_exists(obj_network)) return false;
	var buffer = packet.bake();
	
	show_debug_message("Sending index {0}", packet.index);
	
	if (packet.channel == NetworkingChannel.UDP) {
		network_send_udp_raw(obj_network.UDPsocket, obj_network.server_ip, obj_network.port, buffer, buffer_get_size(buffer));
	} else {
		network_send_raw(obj_network.TCPsocket, buffer, buffer_get_size(buffer));
	}
	
	if (clear) packet.clear();

}

function get_bit_count(number) {

	var count = 0;
	while(number > 0) {
		count += number & 1;
		number = number >> 1;
	}
	return count;
	
}