// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

global.emptyFunction = function(){}
#macro NULLFUNC global.emptyFunction

function __gramin_basicAttackShoot(){
		
	var _d = point_direction(x, y, mousex, mousey);
	var _ult = char.abilities.ultimate.active;
	var bull = _ult ? obj_projectile_gramin_ult_bullet : obj_projectile_gramin_gun1bullet;
	var _x = lengthdir_x(6, _d);
	var _y = lengthdir_y(6, _d);
				
	projectile_create_fake(bull, x+_x, y-10+_y, 80, _d+random_range(-5,5), true, true);
				
}

function __gramin_basicAttackShootVisual(){

	var _s = sign(mousex - x);
	var _pos = 1 - abs(angle_difference(point_direction(x, y, mousex, mousey), -270))/180;
		
	var frame1 = animation_get_frame(char.anims.gramin_shoot_dir, _pos);
	var frame2 = animation_get_frame(char.anims.gramin_shoot_dir_recoil, _pos);
	
	char.abilities.basic_attack.cast_time = 0.08;
		
	var animation = animation_construct([frame1, frame2], [0, 0.5], [framestyle.linear, framestyle.backease]);
	
	if _s != sign(movvec.x) and movvec.length() > 5 {
		play_animation(animation, 6, animation_type_full,,,0.4);
	} else {
		play_animation(animation, 6, animation_type_partial, [0, 1, 2, 10, 11], true, 0.4);
	}

}

function character_Gramin(){

	return {

		name: "Gramin",
		speed: 20,
		id: 2,
		base: base_character(2),
		sprite: base_character_gramin,
		anims: animations(2),
		attach: [],
		abilities: {
		
			basic_attack: new Ability([0.25, 1.8], ability_type.onetime, {},
			
				function(n){
					
					__gramin_basicAttackShoot();
					__gramin_basicAttackShootVisual();
					
					if n = 1 {
				
						createEvent(0.1, __gramin_basicAttackShoot, self);
						createEvent(0.2, __gramin_basicAttackShoot, self);
						createEvent(0.25, __gramin_basicAttackShoot, self);
						createEvent(0.3, __gramin_basicAttackShoot, self);
						createEvent(0.35, __gramin_basicAttackShoot, self);
						createEvent(0.4, __gramin_basicAttackShoot, self);

			
					}
			
				}, NULLFUNC, function(n){
					
					__gramin_basicAttackShootVisual();
					
					if n = 1 {
				
						createEvent(0.1, __gramin_basicAttackShootVisual, self);
						createEvent(0.2, __gramin_basicAttackShootVisual, self);
						createEvent(0.25, __gramin_basicAttackShootVisual, self);
						createEvent(0.3, __gramin_basicAttackShootVisual, self);
						createEvent(0.35, __gramin_basicAttackShootVisual, self);
						createEvent(0.4, __gramin_basicAttackShootVisual, self);

			
					}
		
				}, function(n){
					dir = sign(mousex - x);
				}, 0, kennability1, 0, false, false),
		
			ability1: new Ability(1.5, ability_type.onetime, {},
			
				function(){
		
					var _d = point_direction(x, y, mousex, mousey)+random_range(-2,2);

					var __spd = point_distance(0,0, lengthdir_x(25, _d)+movvec.x/3, lengthdir_y(25, _d)+movvec.y/3);
					var __d = point_direction(0,0, lengthdir_x(25, _d)+movvec.x/3, lengthdir_y(25, _d)+movvec.y/3);
				
					projectile_create_fake(obj_projectile_gramin_net, x, y-10, __spd, __d, true, false, true);


				}, NULLFUNC, function(){
		
						var _s = sign(mousex - x);
						var _pos = 1 - abs(angle_difference(point_direction(x, y, mousex, mousey), -270))/180;
	
						if _s != sign(movvec.x) and movvec.length() > 5 {
							play_animation(char.anims.gramin_ability1, 3, animation_type_partial, [3, 4, 5, 6, 7, 8, 9, 10, 11], true);	
						} else {
							play_animation(char.anims.gramin_ability1, 3, animation_type_partial, [10, 11], true);
						}

		
				}, function(){
				
					dir = sign(mousex - x);
					
				}, 0.33, kennability1, 0),
		
			ability2: new Ability(5, ability_type.onetime, {}, NULLFUNC, NULLFUNC, NULLFUNC, NULLFUNC, 0, kennability2, 0),
		
			ultimate: new Ability(0.2, ability_type.activecharges, {charges: 30, cooldown_charge: 0.1, charge_cast_time: 0, charge_time: 0, active_time: 20, active_func: function(){}, 
			
				end_func: function(){
		
					sprite = base_character_gramin;
		
				}, 
				castCondition: function(){
			
					return on_ground or char.abilities.ultimate.active;
			
				}}, function(){
		
					__gramin_basicAttackShootVisual();
				
				}, function(){ //Cast
			
					if !char.abilities.ultimate.active{
			
						camera_ultimate_zoom(0.7, 5, easeInSixth, 0.4, easeInSixth, 0.4);
						return;
			
					} else {
						
						var anon = function(){
			
							var _d = point_direction(x, y, mousex, mousey)+random_range(-2,2);
							var _x = -lengthdir_x(20, _d);
							var _y = -lengthdir_y(20, _d);
							movvec.x = abs(movvec.x + _x) < abs(_x) ? _x : movvec.x + _x;
							movvec.y = abs(movvec.y + _y) < abs(_y) ? _y : movvec.y + _y;
							projectile_create_fake(obj_projectile_gramin_ult_rocket, x-_x/3, y-10-_y/3, 60, _d, true, true);
			
						}
						createEvent(0.1, anon, self);
						
					}
			
				}, function(){ //Visual Cast
		
					if !char.abilities.ultimate.active{
			
						play_animation(char.anims.gramin_ultimate, 0.2, animation_type_full, [], true);
						sprite = base_character_gramin_ult;
						return;
			
					}
		
					__gramin_basicAttackShootVisual();
		
				}, function(){}, 1/0.3, ultimatekenn, #9A1D1C, true, true)
		
			}

	}

}