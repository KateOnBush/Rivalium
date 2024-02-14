// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

global.projectiles_array = [

	obj_projectile_kenn_dagger,
	obj_projectile_kenn_dagger_transformed,

	obj_projectile_gramin_gun1bullet,
	obj_projectile_gramin_ult_bullet,
	obj_projectile_gramin_net,
	obj_projectile_gramin_ult_rocket,
	obj_projectile_gramin_ult_smalldebris,

	obj_projectile_lenya_blue_bullet,
	obj_projectile_lenya_red_bullet,
	obj_projectile_lenya_grenade,

	obj_projectile_masr_bolt,
	obj_projectile_masr_bolt_powered

];

global.explosions_array = [

	obj_explosion_gramin, 
	obj_explosion_gramin_ult, 

	obj_explosion_lenya_grenade,

	obj_explosion_masr_bolt

];

function projectile_create(proj, ownerid, x, y, speed, direction, collision, dieoncol, life, damage = 0, bleed = 0, heal = 0, ID = 0, bounce = false, px = 0, py = 0){

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
	_o.bounce = bounce;
	_o.px = px;
	_o.py = py;
	return _o;

}

function projectile_create_fake(proj, x, y, speed, direction, collision, dieoncol, bounce = false){

	var lagcompen = projectile_create(array_find_by_value(global.projectiles_array, proj), global.playerid, x, y, speed, direction, collision, dieoncol, 0.25, 0, 0, 0, 0, bounce, x, y);
	return lagcompen;

}
function explosion_create(explind, ownerid, x, y, radius = 50, damage = 0){

	var _o = instance_create_depth(x, y, 0, global.explosions_array[explind]);
	
	_o.damage = damage;
	_o.lifetime = 5;
	_o.radius = radius;
	_o.ownerID = ownerid;
	
	return _o;

}