// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

global.projectiles_array = [obj_projectile_kenn_dagger,
obj_projectile_kenn_dagger_transformed,
obj_projectile_gramin_gun1bullet,
obj_projectile_gramin_net,
obj_projectile_gramin_ult_rocket];

global.explosions_array = [obj_explosion_gramin];

function projectile_create(proj, ownerid, x, y, speed, direction, collision, dieoncol, life, damage = 0, bleed = 0, heal = 0, ID = 0){

	var _o = instance_create_depth(x, y, 0, global.projectiles_array[proj]);
	_o.ownerID = ownerid;
	_o.x = x;
	_o.y = y;
	_o.spd = speed;
	_o.dir = direction;
	_o.col = collision;
	_o.dieoncol = dieoncol;
	_o.life = life;
	_o.damage = damage;
	_o.bleed = bleed;
	_o.heal = heal;
	_o.ID = ID;
	return _o;

}

function projectile_create_request(proj, x, y, speed, direction, collision, dieoncol, life, damage = 0, bleed = 0, heal = 0){

	var o = array_find_by_value(global.projectiles_array, proj)
	if o == -1 return;
	var _buff = buffer_create(global.dataSize, buffer_fixed, 1);
	buffer_seek(_buff, buffer_seek_start, 0);
	buffer_write(_buff, buffer_u8, 6)
	buffer_write(_buff, buffer_u16, o)
	buffer_write(_buff, buffer_s32, round(x*100))
	buffer_write(_buff, buffer_s32, round(y*100))
	buffer_write(_buff, buffer_s32, round(speed*100))
	buffer_write(_buff, buffer_s16, round(direction*10))
	buffer_write(_buff, buffer_u8, collision);
	buffer_write(_buff, buffer_u8, dieoncol);
	buffer_write(_buff, buffer_u8, life);
	buffer_write(_buff, buffer_u16, damage)
	buffer_write(_buff, buffer_u16, bleed)
	buffer_write(_buff, buffer_u16, heal)
	var lagcompen = projectile_create(o, global.playerid, x, y, speed, direction, collision, dieoncol, 1, damage, bleed, heal, 0);
	buffer_write(_buff, buffer_u32, lagcompen);
	
	network_send_raw(obj_network.server, _buff, global.dataSize);
	
	buffer_delete(_buff);

}

function explosion_create_request(explosion, x, y, radius = 50, damage = 0, lifetime = 5){

	var o = array_find_by_value(global.explosions_array, explosion);
	if o == -1 return; 
	var _buff = buffer_create(global.dataSize, buffer_fixed, 1);
	buffer_seek(_buff, buffer_seek_start, 0);
	buffer_write(_buff, buffer_u8, 12)
	buffer_write(_buff, buffer_u16, o)
	buffer_write(_buff, buffer_s32, round(x*100))
	buffer_write(_buff, buffer_s32, round(y*100))
	buffer_write(_buff, buffer_u16, radius)
	buffer_write(_buff, buffer_u16, damage);
	buffer_write(_buff, buffer_u8, lifetime);
	
	network_send_raw(obj_network.server, _buff, global.dataSize);
	
	buffer_delete(_buff);
	

}

function explosion_create(explind, ownerid, x, y, radius = 50, damage = 0, lifetime = 5){

	var _o = instance_create_depth(x, y, 0, global.explosions_array[explind]);
	
	_o.damage = damage;
	_o.lifetime = lifetime;
	_o.radius = radius;
	_o.ownerID = ownerid;
	
	return _o;

}