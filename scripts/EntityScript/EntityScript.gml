#macro entityParameterLimit 6

global.entity_array = [
obj_entity_leyna_wall, 
obj_entity_lenya_radius,

obj_entity_masr_windwall];

function entity_create(entity, owner, ID, x, y, mx, my, hp, armor, life, entityParameters = array_create(entityParameterLimit, 0)){
		
	if entity >= array_length(global.entity_array) return;

	var o = instance_create_layer(x, y, "Instances", global.entity_array[entity]);
	o._x = x;
	o._y = y;
	o.ownerID = owner;
	o.ID = ID;
	o.mx = my;
	o.my = my;
	o.hp = hp;
	o.maxhp = hp;
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
	
	var o = entity_instance;
	
	var updateEntity = new UReqEntityUpdate();
	
	updateEntity.entityId = o.ID;
	updateEntity.x = o.x; updateEntity.y = o.y;
	updateEntity.movX = o.mx; updateEntity.movY = o.my;
	updateEntity.param1 = o.parameters[0];
	updateEntity.param2 = o.parameters[1];
	updateEntity.param3 = o.parameters[2];
	updateEntity.param4 = o.parameters[3];
	updateEntity.param5 = o.parameters[4];
	
	gameserver_send(updateEntity);
	
}