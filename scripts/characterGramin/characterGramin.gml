// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function character_Gramin(){

	return {

		name: "Gramin",
		speed: 27,
		id: 2,
		base: base_character(2),
		sprite: base_character_gramin,
		anims: animations(2),
		attach: [],
		abilities: {
		
			basic_attack: new Ability([0.2, 1.8], ability_type.onetime, {}, 
			
				function(n){
		
					var _d = point_direction(x, y, mousex, mousey);
					var _x = lengthdir_x(6, _d);
					var _y = lengthdir_y(6, _d);
			
					var _ult = char.abilities.ultimate.active;
					var bull = _ult ? obj_projectile_gramin_ult_bullet : obj_projectile_gramin_gun1bullet;
			
					if n = 0 {
				
						projectile_create_request(bull, x + _x, y-10+_y, 80, _d+random_range(-5,5), true, true, 50, 20, 0, 0);
				
					}
					if n = 1 {
				
						var anon = function(){
				
							var _d = point_direction(x, y, mousex, mousey);
							var _ult = char.abilities.ultimate.active;
							var bull = _ult ? obj_projectile_gramin_ult_bullet : obj_projectile_gramin_gun1bullet;
							var _x = lengthdir_x(6, _d);
							var _y = lengthdir_y(6, _d);
				
							projectile_create_request(bull, x+_x, y-10+_y, 80, _d+random_range(-5,5), true, true, 50, 20, 0, 0);
				
						}
				
						anon = method(self, anon);
				
						anon();
						createEvent(0.1, anon);
						createEvent(0.2, anon);
						createEvent(0.25, anon);
						createEvent(0.3, anon);
						createEvent(0.35, anon);
						createEvent(0.4, anon);

			
					}
			
			
		
				}, function(n){
		
					var _s = mousex - x;
		
					var _pos = (180-angle_difference(point_direction(x, y, mousex, mousey), dir > 0 ? 0 : 180))/360;
			
					if(dir == -1) _pos = 1 - _pos;
		
					var animation = animation_construct([animation_get_frame(char.anims.abilities.basic_attack, _pos, false)], [0])
			
					play_animation(animation, n == 0 ? 5 : 2.5, animation_type_partial, false, [0, 1, 2, 7, 10, 11], true);
		
				}, function(){}, 0, kennability1, 0),
		
			ability1: new Ability(1.5, ability_type.onetime, {}, 
			
				function(){
		
					var _d = point_direction(x, y, mousex, mousey)+random_range(-2,2);

					var __spd = point_distance(0,0, lengthdir_x(25, _d)+movvec.x/3, lengthdir_y(25, _d)+movvec.y/3);
					var __d = point_direction(0,0, lengthdir_x(25, _d)+movvec.x/3, lengthdir_y(25, _d)+movvec.y/3);
				
					projectile_create_request(obj_projectile_gramin_net, x, y-10, __spd, __d, true, false, 50, 20, 0, 0, true);


				}, function(){
		
					play_animation(char.anims.abilities.ability1, 4, animation_type_partial, false, [10, 11], true);
		
				}, function(){}, 0, kennability1, 0),
		
			ability2: new Ability(5, ability_type.onetime, {}, function(){
		
				heal_player(50);
		
				}, function(){}, function(){}, 0, kennability2, 0),
		
			ultimate: new Ability(0.2, ability_type.activecharges, {charges: 30, cooldown_charge: 0.1, charge_cast_time: 0, charge_time: 0, active_time: 20, active_func: function(){}, 
			
				end_func: function(){
		
					removeFilter(base_character_gramin_ult);
		
				}, 
				castCondition: function(){
			
					return !on_ground and !char.abilities.ultimate.active
			
				}}, function(){ //Cast
			
					if !char.abilities.ultimate.active{
			
						camera_ultimate_zoom(400, 2.5, easeInSixth, 0.4, easeInSixth, 0.4);
						return;
			
					}
			
					var anon = function(){
			
						var _d = point_direction(x, y, mousex, mousey)+random_range(-2,2);
						var _x = -lengthdir_x(20, _d);
						var _y = -lengthdir_y(20, _d);
						movvec.x = abs(movvec.x + _x) < abs(_x) ? _x : movvec.x + _x;
						movvec.y = abs(movvec.y + _y) < abs(_y) ? _y : movvec.y + _y;
						projectile_create_request(obj_projectile_gramin_ult_rocket, x-_x/3, y-10-_y/3, 60, _d, true, true, 10, 0, 0, 0);
			
					}
			
					createEvent(0.1, anon);
			
			
				}, function(){ //Visual Cast
		
					if !char.abilities.ultimate.active{
			
						play_animation(char.anims.abilities.ultimate, 0.35, animation_type_full, true);
						addFilter(base_character_gramin_ult, -1, 1);
						return;
			
					}
		
					var _s = mousex - x;
		
					var _pos = (180-angle_difference(point_direction(x, y, mousex, mousey), dir > 0 ? 0 : 180))/360;
			
					if(dir == -1) _pos = 1 - _pos;
		
					var animation = animation_construct([animation_get_frame(char.anims.abilities.basic_attack, _pos, false)], [0])
			
					play_animation(animation, 2, animation_type_partial, false, [0, 1, 2, 7, 10, 11], true);
			
					screen_shake_position(40, 40, 0.1, x, y);
		
				}, function(){}, 2.5, ultimatekenn, #9A1D1C)
		
			}

	}

}