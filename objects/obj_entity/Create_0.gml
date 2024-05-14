/// @description Insert description here
// You can write your code in this editor

ownerID = 0;

ID = 0;

lifespan = 0;

show_hp_timer = 0;

_x = x;
_y = y;

physics = false;
alive = false;

hp = 100;
hp_blend = 100;
maxhp = 100;
armor = 0;

solidComponent = undefined;

parameters = array_create(entityParameterLimit, 0);

damage = function(projectileId){

	var entityHit = new TReqEntityHit();
	entityHit.projectileId = projectileId;
	entityHit.entityId = ID;

	gameserver_send(entityHit);

}

destroy = function(){};
