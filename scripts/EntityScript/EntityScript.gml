#macro entityParameterLimit 6

global.entity_array = [
obj_entity_leyna_wall, 
obj_entity_lenya_radius,

obj_entity_masr_windwall];

function entity_create(entity, owner, ID, x, y, mx, my, hp, armor, life, entityParameters = array_create(entityParameterLimit, 0)){
		
	if entity >= array_length(global.entity_array) return;

	var o = instance_create_depth(x, y, 0, global.entity_array[entity]);
	o._x = x;
	o._y = y;
	o.ownerID = owner;
	o.ID = ID;
	o.mx = my;
	o.my = my;
	o.hp = hp;
	o.armor = armor;
	o.lifespan = life;
	
	o.parameters = entityParameters;
		
	return o;

}

function entity_create_solid_component(x, y, entity, obj = obj_obstacle_entity){

	var o = instance_create_depth(x, y, entity.depth, obj);
	
	o.componentTo = entity;
	
	return o;

}

function entity_update_request(entity_instance){

	var _ind = array_find_by_value(global.entity_array, entity_instance.object_index)
	if _ind == -1 return;
	
	var o = entity_instance;
	
	var _x = o.x, _y = o.y;
	var entityParameters = o.parameters;
	
	var buffer = buffer_create(global.dataSize, buffer_fixed, 1);
	buffer_seek(buffer, buffer_seek_start, 0);
	
	buffer_write(buffer, buffer_u8, ServerRequest.ENTITY_UPDATE);
	buffer_write(buffer, buffer_u16, o.ID);
	buffer_write(buffer, buffer_s32, round(_x * 100));
	buffer_write(buffer, buffer_s32, round(_y * 100));
	buffer_write(buffer, buffer_s32, round(o.mx * 100));
	buffer_write(buffer, buffer_s32, round(o.my * 100));

	for(var i = 0; i < array_length(entityParameters); i++){
		buffer_write(buffer, buffer_s32, round(entityParameters[i]*100));
	}
	
	network_send_raw(obj_network.server, buffer, global.dataSize);
	
	buffer_delete(buffer);
	
}