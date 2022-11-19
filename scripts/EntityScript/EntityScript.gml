#macro entityParameterLimit 6

global.entity_array = [obj_entity_leyna_wall];

function EntityPhysicsComponent(MovementVector2) constructor{

	self.x = MovementVector2.x;
	self.y = MovementVector2.y;

}

function EntityHealthComponent(hp, armor) constructor{

	self.health = hp;
	self.armor = armor;

}


function entity_create_request(entity, x, y, life = 10,
								physicsComponent = undefined, 
								healthComponent = undefined,
								entityParameters = []
								){

	var _ind = array_find_by_value(global.entity_array, entity)
	
	if _ind == -1 return;
	
	var buffer = buffer_create(global.dataSize, buffer_fixed, 1);
	buffer_seek(buffer, buffer_seek_start, 0);
	
	buffer_write(buffer, buffer_u8, 14);
	buffer_write(buffer, buffer_u16, _ind);
	buffer_write(buffer, buffer_s32, round(x*100));
	buffer_write(buffer, buffer_s32, round(y*100));
	buffer_write(buffer, buffer_u8, physicsComponent == undefined ? 0 : 1)
	buffer_write(buffer, buffer_s32, physicsComponent == undefined ? 0 : round(physicsComponent.movvec.x*100));
	buffer_write(buffer, buffer_s32, physicsComponent == undefined ? 0 : round(physicsComponent.movvec.y*100));
	buffer_write(buffer, buffer_u8, healthComponent == undefined ? 0 : 1);
	buffer_write(buffer, buffer_u32, healthComponent == undefined ? 0 : healthComponent.health)
	buffer_write(buffer, buffer_u8, healthComponent == undefined ? 0 : round(healthComponent.armor*100));
	buffer_write(buffer, buffer_u16, 0);
	buffer_write(buffer, buffer_u16, life);
	for(var i = 0; i < array_length(entityParameters); i++){
		buffer_write(buffer, buffer_s32, round(entityParameters[i]*100));
	}
	
	
	network_send_raw(obj_network.server, buffer, global.dataSize);
	
	buffer_delete(buffer);

}

function entity_update_request(entity_instance){

	var _ind = array_find_by_value(global.entity_array, entity_instance.object_index)
	if _ind == -1 return;
	
	var o = entity_instance;
	
	var _x = o.x, _y = o.y;
	var physicsComponent = o.physicsComponent;
	var healthComponent = o.healthComponent;
	var entityParameters = o.parameters;
	
	var buffer = buffer_create(global.dataSize, buffer_fixed, 1);
	buffer_seek(buffer, buffer_seek_start, 0);
	
	buffer_write(buffer, buffer_u8, 14);
	buffer_write(buffer, buffer_u16, _ind);
	buffer_write(buffer, buffer_s32, round(_x*100));
	buffer_write(buffer, buffer_s32, round(_y*100));
	buffer_write(buffer, buffer_u8, physicsComponent == undefined ? 0 : 1)
	buffer_write(buffer, buffer_s32, physicsComponent == undefined ? 0 : round(physicsComponent.movvec.x*100));
	buffer_write(buffer, buffer_s32, physicsComponent == undefined ? 0 : round(physicsComponent.movvec.y*100));
	buffer_write(buffer, buffer_u8, healthComponent == undefined ? 0 : 1);
	buffer_write(buffer, buffer_u32, healthComponent == undefined ? 0 : healthComponent.health)
	buffer_write(buffer, buffer_u8, healthComponent == undefined ? 0 : round(healthComponent.armor*100));
	buffer_write(buffer, buffer_u16, o.ID);
	buffer_write(buffer, buffer_u16, 0);
	for(var i = 0; i < array_length(entityParameters); i++){
		buffer_write(buffer, buffer_s32, round(entityParameters[i]*100));
	}
	
	network_send_raw(obj_network.server, buffer, global.dataSize);
	
	buffer_delete(buffer);
	
}

function entity_create(entity, owner, ID, x, y, 
						physicsComponent = undefined,
						healthComponent = undefined,
						entityParameters = undefined){
		
	if entity >= array_length(global.entity_array) return;		

	var o = instance_create_depth(x, y, 0, global.entity_array[entity]);
	o.ownerID = owner;
	o.ID = ID;
	o.physicsComponent = physicsComponent;
	o.healthComponent = healthComponent;
	
	
	o.parameters = entityParameters;
	
	show_debug_message(entityParameters);
	show_debug_message(o.parameters);
		
	return o;

}

function entity_create_solid_component(x, y, entity){

	var o = instance_create_depth(x, y, entity.depth, obj_obstacle_entity);
	
	o.componentTo = entity;
	
	return o;

}