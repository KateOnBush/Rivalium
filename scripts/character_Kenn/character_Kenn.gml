// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function character_Kenn(){
	
	return {

		name: "Kenn",
		speed: 23,
		id: 1,
		base: base_character(1),
		sprite: base_character_kennidk,
		anims: animations(1),
		particles: {
			boost: part_type_create()
		},
		attach: [],
		abilities: {
	
			basic_attack: new Ability([0.3, 2], ability_type.onetime, {},
		
				function (n) {
			
					var _heal = char.abilities.ability1.active ? 15 : 0;
					var proj = char.abilities.ultimate.active ? obj_projectile_kenn_dagger_transformed : obj_projectile_kenn_dagger;
			
					repeat(n == 1 ? 3 : 1){
			
						projectile_create_fake(proj, x, y, 70, point_direction(x, y, mousex, mousey) + (n == 1 ? irandom_range(-20,20) : 0), true, false);
			
					}
					if sign(mousex - x) != sign(movvec.x) and movvec.length() > 4 {
						dir = sign(mousex - x);
						play_animation(char.anims.kenn_basic_attack, 3, animation_type_full);
					} else play_animation(char.anims.kenn_basic_attack, 3, animation_type_partial, [0, 1]);
					
				}, NULLFUNC,
				function (n){
					if sign(mousex - x) != sign(movvec.x) and movvec.length() > 4 {
						dir = sign(mousex - x);
						play_animation(char.anims.kenn_basic_attack, 3, animation_type_full);
					} else play_animation(char.anims.kenn_basic_attack, 3, animation_type_partial, [0, 1]);
				}, 
				function (n){
					dir = sign(mousex - x);
				}, 
				1/4.5, basicattackkenn, 0, false, false),
		
			ability1: new Ability(18, ability_type.active, {active_time: 12, active_func: function(){}, end_func: function(){}}, 
			function(){}, function(){}, function(){}, function(){}, 0.2, kennability1, 0),
		
			ability2: new Ability(13, ability_type.active, {active_time: 8, active_func: function(){
			
				if (isFpsFrame) {
					if (random(1) > 0.8) part_particles_create(global.partSystem, x, y + 32, gParts.kennSpeedParticle, irandom(2));	
				}
				
			}, end_func: function(){
		
					removeFilter(base_character_kenn_filter1);
		
				}}, function(){},
				
				function(){}, function(){
			
					addFilter(base_character_kenn_filter1, -5, 0.8);
			
				}, function(){
				}, 0, kennability2, 0),
		
			ultimate: new Ability(60, ability_type.active, {active_time: 25, active_func: function(){}, end_func: function(){
		
					removeFilter(base_character_kenn_transformed)
		
				}}, NULLFUNC, function(){
			
					screen_shake(2, 10, 3);
					camera_ultimate_zoom(0.7, 5, easeInOutBack, 0.5, easeInOutBack, 0.5);
		
				}, function(){
			
					play_animation(char.anims.kenn_ultimate, 0.2, animation_type_full, true);
					dir = 1;
					ultpart = part_type_create();
					part_type_shape(ultpart, pt_shape_sphere)
					part_type_color2(ultpart, #821511, #302727);
					part_type_size(ultpart, 0.03, 0.05, 0, 0);
					part_type_alpha2(ultpart,0.5, 0)
					createEvent(2.5, function(){
						 addFilter(base_character_kenn_transformed, -10, 1)
						 screen_shake(100, 200, 0.1);
					}, self)
			
				}, function(){
		
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