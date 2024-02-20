// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


function __leyna_shootVisualBlueHand(){
	
	var _s = sign(mousex - x);
	
	if _s != sign(movvec.x) and movvec.length() > 5 {
		play_animation(char.anims.shoot_blue_hand, 4, animation_type_full,,,0.4);
	} else {
		play_animation(char.anims.shoot_blue_hand, 4, animation_type_partial, [0, 1, 7, 9, 10], true,0.4);
	}
	
}

function __leyna_shootVisualRedHand(){
	
	var _s = sign(mousex - x);
	
	if _s != sign(movvec.x) and movvec.length() > 5 {
		play_animation(char.anims.shoot_red_hand, 4, animation_type_full,,,0.4);
	} else {
		play_animation(char.anims.shoot_red_hand, 4, animation_type_partial, [0, 1, 7, 9, 10], true,0.4);
	}
	
}


function character_Lenya(){

	static particles = (function(){

		charge = part_type_create();
		part_type_sprite(charge, base_character_lenya_ult_charge_particle, false, false, true);
		part_type_size(charge, 0.6, 2.2, -0.05, 0);
		part_type_orientation(charge, 0, 360, -4, 0, 0)
		part_type_alpha3(charge, 0.5, 0.8, 0);
		part_type_life(charge, 20, 30);
		
		return {charge};

	})();

	return {

		name: "Lenya",
		speed: 21.5,
		id: 3,
		base: base_character(3),
		sprite: base_character_lenya,
		anims: animations(3),
		attach: [[base_character_lenya_hair,0,-2,0.7,6]],
		abilities: {
		
			basic_attack: new Ability([0.1, 0.1], ability_type.onetime, {}, function(n){

				var d = point_direction(x, y, mousex, mousey);
				var proj = n == 1 ? obj_projectile_lenya_red_bullet : obj_projectile_lenya_blue_bullet;
				//projectile_create_fake(proj, x, y, 60, d, true, true);	
				if (n == 0) __leyna_shootVisualBlueHand();
				else __leyna_shootVisualRedHand();
			
			}, function(n){

				var d = point_direction(x, y, mousex, mousey);
				var proj = n == 1 ? obj_projectile_lenya_red_bullet : obj_projectile_lenya_blue_bullet;
				//projectile_create_fake(proj, x, y, 60, d, true, true);	
				if (n == 0) __leyna_shootVisualBlueHand();
				else __leyna_shootVisualRedHand();
			
			}, function(n){ // Cast visual
			
				if (n == 0) __leyna_shootVisualBlueHand();
				else __leyna_shootVisualRedHand();
			
			}, function(){ //Casting
			
				dir = sign(mousex - x); 
			
			}, 0.1, lenya_basic_attack, 0),
				
				
			ability1: new Ability(0.3, ability_type.onetime, {}, NULLFUNC, 
			
			function(){
			
				
				var dd = point_direction(x, y + 80, mousex, mousey);
				
				var createdx = x + (sign(mousex - x) == sign(movvec.x) ? 16*movvec.x : sign(mousex - x)*60);
				var createdy = y + 80;
			
				//entity_create_request(obj_entity_leyna_wall, createdx, createdy,20,,new EntityHealthComponent(100, 0),[dd, dd]);
		
			
			}, 
			function(){
			
				if on_ground play_animation(char.anims.ability1, 2.8, animation_type_partial, [0, 1, 9, 10], true)
				else play_animation(char.anims.ability1, 2.8, animation_type_full);
				
			
			}, function(){}, 0, lenya_ability1, 0),
				
				
			//
			ability2: new Ability(.1, ability_type.activecharges, {charges: 1, cooldown_charge: .1, charge_cast_time: 0, charge_time: 0, active_time: 5, active_func: NULLFUNC, end_func: NULLFUNC},
			
			function(){
				
				if char.abilities.ability2.active return;
		
				var _d = point_direction(x, y, mousex, mousey)+random_range(-2,2);
				var __spd = point_distance(0,0, lengthdir_x(25, _d)+movvec.x/3, lengthdir_y(25, _d)+movvec.y/3);
				var __d = point_direction(0,0, lengthdir_x(25, _d)+movvec.x/3, lengthdir_y(25, _d)+movvec.y/3);
				
				projectile_create_fake(obj_projectile_lenya_grenade, x, y - 10, __spd, __d, true, false, true);
				if sign(mousex - x) != sign(movvec.x) and movvec.length() > 4 {
					dir = sign(mousex - x);
					play_animation(char.anims.ability2, 4.5, animation_type_full);
				} else play_animation(char.anims.ability2, 3, animation_type_partial, [0, 1]);
			
			}, NULLFUNC, function(){
				
				if char.abilities.ability2.active return;
				
				if sign(mousex - x) != sign(movvec.x) and movvec.length() > 4 {
					dir = sign(mousex - x);
					play_animation(char.anims.ability2, 4.5, animation_type_full);
				} else play_animation(char.anims.ability2, 3, animation_type_partial, [0, 1]);
				
			}, NULLFUNC, 0, lenya_ability2, 0),
				
				
			ultimate: new Ability(5, ability_type.onetime, {}, NULLFUNC, function(){
			
				movvec.x = 0;
				movvec.y = 0;
				camera_ultimate_zoom(0.7, 10/3, easeInOutExpo, .5, easeInOutExpoEarly, 5/3 + 0.8);
				
			
			}, function(){
			
				play_animation(char.anims.ultimate, 0.3, animation_type_full);
				screen_shake_position(0.2, 0.15, 5/3, x, y);
			
			}, function(){
			
				if (isFpsFrame) and char.abilities.ultimate.cast_time > 10/6
				part_particles_create(global.partSystem, x, y, character_Lenya.particles.charge, random(3));
				movvec.x *= 0.1;
				movvec.y *= 0.1;
			
			}, 10/3, lenya_ult, 0, true, true),
		
		}

	}

}
