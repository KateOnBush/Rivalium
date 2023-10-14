/// @description Insert description here
// You can write your code in this editor

ownerID = 0;

ID = 0;

lifespan = 0;


physics = false;
alive = false;

hp = 100;
armor = 0;

solidComponent = undefined;

parameters = array_create(entityParameterLimit, 0);

damage = function(dmg){

	show_debug_message("Damaged me ("+string(ID)+") : " + string(dmg));

	var buff = buffer_create(global.dataSize, buffer_fixed, 1);
	
	buffer_seek(buff, buffer_seek_start, 0);
	
	buffer_write(buff, buffer_u8, ServerRequest.ENTITY_HIT);
	buffer_write(buff, buffer_u16, ID);
	buffer_write(buff, buffer_u16, dmg);
	
	network_send_raw(obj_network.server, buff, global.dataSize);
	
	buffer_delete(buff);

}

destroy = function(){};
