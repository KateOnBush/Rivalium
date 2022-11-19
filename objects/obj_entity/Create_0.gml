/// @description Insert description here
// You can write your code in this editor

ownerID = 0;

ID = 0;

physicsComponent = undefined;

solidComponent = undefined;

healthComponent = undefined;

parameters = [];

damage = function(dmg){

	show_debug_message("Damaged me ("+string(ID)+") : " + string(dmg));

	var buff = buffer_create(global.dataSize, buffer_fixed, 1);
	
	buffer_seek(buff, buffer_seek_start, 0);
	
	buffer_write(buff, buffer_u8, 15);
	buffer_write(buff, buffer_u16, ID);
	buffer_write(buff, buffer_u16, dmg);
	
	network_send_raw(obj_network.server, buff, global.dataSize);
	
	buffer_delete(buff);

}

destroy = function(){};
