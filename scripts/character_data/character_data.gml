// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


function setupCharacterData(){

characters = [{

	name: "Kenn",
	speed: 28,
	id: 1,
	base: base_character(1),
	sprite: base_character_kenn,
	anims: animations(1),
	particles: {
		boost: part_type_create()
	},
	attach: [],
	abilities: {
	
		basic_attack: new Ability([0.3, 2], ability_type.onetime, {},
		function (n){
			
			var _heal = char.abilities.ability1.active ? 15 : 0;
			
			if(char.abilities.ultimate.active){
			
				projectile_create_request(obj_projectile_kenn_dagger_transformed, x, y, 55, point_direction(x, y, mousex, mousey), true, false, 5, 35, 10, _heal*2);
			
				if n == 1 repeat(3){
			
					projectile_create_request(obj_projectile_kenn_dagger_transformed, x, y, 55, point_direction(x, y, mousex, mousey) + irandom_range(-20,20), true, false, 5, 35, 10, _heal*2);
			
				}
			
			} else {
			
				projectile_create_request(obj_projectile_kenn_dagger, x, y, 55, point_direction(x, y, mousex, mousey), true, false, 5, 25, 0, _heal)
			
				if n == 1 repeat(3){
			
					projectile_create_request(obj_projectile_kenn_dagger, x, y, 55, point_direction(x, y, mousex, mousey) + irandom_range(-20,20), true, false, 5, 25, 0 , _heal)
			
				}
			
			}
			
			screen_shake(5, 20, 0.05); 
		}, 
		function (n){
			if sign(mousex - x) != dir and movvec.length()>4{
				play_animation(char.anims.abilities.basic_attack, 8, animation_type_full, false)	
			} else play_animation(char.anims.abilities.basic_attack, 8, animation_type_partial, false, [0, 1]);
		}, 
		function (n){
			dir = sign(mousex - x);
		}, 
		0, basicattackkenn, 0),
		
		ability1: new Ability(18, ability_type.active, {active_time: 12, active_func: function(){}, end_func: function(){}}, function(){
		
		}, function(){}, function(){}, 0.2, kennability1, 0),
		
		ability2: new Ability(13, ability_type.active, {active_time: 8, active_func: function(){}, end_func: function(){
		
			removeFilter(base_character_kenn_filter1);
		
		}}, function(){
			
			add_effect(effecttype.boost, 8, {multiplier: 1.25}, playerEffects, true);
			
		}, function(){
			
			addFilter(base_character_kenn_filter1, -5, 0.8);
			
		}, function(){
		}, 0, kennability2, 0),
		
		ultimate: new Ability(60, ability_type.active, {active_time: 25, active_func: function(){}, end_func: function(){
		
			removeFilter(base_character_kenn_transformed)
		
		}}, function(){
			
			screen_shake(10, 50, 2.2);
			camera_ultimate_zoom(350, 2.5, easeInOutBack, 0.5, easeInOutBack, 0.5);
		
		}, function(){
			
			play_animation(char.anims.abilities.ultimate, 0.4, animation_type_full, true);
			dir = 1;
			ultpart = part_type_create();
			part_type_shape(ultpart, pt_shape_sphere)
			part_type_color2(ultpart, #821511, #302727);
			part_type_size(ultpart, 0.03, 0.05, 0, 0);
			part_type_alpha2(ultpart,0.5, 0)
			
		}, function(){
		
			if char.abilities.ultimate.cast_time < 1.1 addFilter(base_character_kenn_transformed, -10, 1);
			movvec.x *= power(0.01, dtime);
			movvec.y *= power(0.01, dtime);
			part_type_speed(ultpart, 1*dtime, 3*dtime, -0.01*dtime, 0);
			part_type_life(ultpart, fpstime, fpstime*1.2);
			part_type_direction(ultpart, 0, 360, 1*dtime, 0);
			part_particles_create(global.partSystemBehind, x+irandom_range(-5,5), y+irandom_range(-8,3), ultpart, 1);
			
		
		}, 2.5, ultimatekenn, #9A1D1C, true),
	
	}

},{

	name: "Gramin",
	speed: 27,
	id: 2,
	base: base_character(2),
	sprite: base_character_gramin,
	anims: animations(2),
	attach: [],
	abilities: {
		
		basic_attack: new Ability([0.2, 1.8], ability_type.onetime, {}, function(n){
		
			var _d = point_direction(x, y, mousex, mousey);
			
			if n = 0 {
				
				projectile_create_request(obj_projectile_gramin_gun1bullet, x, y-10, 80, _d+random_range(-5,5), true, true, 50, 20, 0, 0);
				
			}
			if n = 1 {
				
				var anon = function(){
				
					var _d = point_direction(x, y, mousex, mousey);
				
					projectile_create_request(obj_projectile_gramin_gun1bullet, x, y-10, 80, _d+random_range(-5,5), true, true, 50, 20, 0, 0);
				
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
		
		ability1: new Ability(1.5, ability_type.onetime, {}, function(){
		
			var _d = point_direction(x, y, mousex, mousey)+random_range(-2,2);

			var __spd = point_distance(0,0, lengthdir_x(25, _d)+movvec.x/3, lengthdir_y(25, _d)+movvec.y/3);
			var __d = point_direction(0,0, lengthdir_x(25, _d)+movvec.x/3, lengthdir_y(25, _d)+movvec.y/3);
				
			projectile_create_request(obj_projectile_gramin_net, x, y-10, __spd, __d, true, true, 50, 20, 0, 0);


		}, function(){
		
			play_animation(char.anims.abilities.ability1, 4, animation_type_partial, false, [10, 11], true);
		
		}, function(){}, 0, kennability1, 0),
		
		ability2: new Ability(5, ability_type.onetime, {}, function(){
		
			heal(50);
		
		}, function(){}, function(){}, 0, kennability2, 0),
		
		ultimate: new Ability(0.2, ability_type.activecharges, {charges: 4, cooldown_charge: 2, charge_cast_time: 0, charge_time: 0, active_time: 20, active_func: function(){}, end_func: function(){}, castCondition: function(){
			
			return !on_ground and !char.abilities.ultimate.active
			
		}}, function(){ //Cast
			
			if !char.abilities.ultimate.active{
			
				camera_ultimate_zoom(400, 4, easeInSixth, 0.4, easeInSixth, 0.4);
				return;
			
			}
			
			var _d = point_direction(x, y, mousex, mousey)+random_range(-2,2);
			
			projectile_create_request(obj_projectile_gramin_ult_rocket, x, y-10, 80, _d, false, false, 10, 0, 0, 0);
			
		}, function(){ //Visual Cast
		
			if !char.abilities.ultimate.active{
			
				play_animation(char.anims.abilities.ultimate, 0.25, animation_type_full, true);
				return;
			
			}
		
			var _s = mousex - x;
		
			var _pos = (180-angle_difference(point_direction(x, y, mousex, mousey), dir > 0 ? 0 : 180))/360;
			
			if(dir == -1) _pos = 1 - _pos;
		
			var animation = animation_construct([animation_get_frame(char.anims.abilities.basic_attack, _pos, false)], [0])
			
			play_animation(animation, 5, animation_type_partial, false, [0, 1, 2, 7, 10, 11], true);
		
		}, function(){}, 4, ultimatekenn, #9A1D1C)
		
	}

},{

	name: "Crystia",
	speed: 29,
	id: 3,
	base: base_character(1),
	sprite: base_character_sonia,
	anims: animations(1),
	attach: [[base_character_sonia_hair,47,25,1,6]]

}]

}