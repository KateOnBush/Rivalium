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

damage = function(damage, projectileId){

	var entityHit = new TReqEntityHit();
	entityHit.projectileId = projectileId;
	entityHit.entityId = ID;

	gameserver_send(entityHit);

}

destroy = function(){};
