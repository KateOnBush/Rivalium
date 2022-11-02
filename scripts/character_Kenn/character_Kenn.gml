// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function character_Kenn(){
	
	return {

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

	}

}