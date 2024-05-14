// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function __kenn_animate_throw() {
	if sign(mousex - x) != sign(movvec.x) and movvec.length() > 4 {
		dir = sign(mousex - x);
		play_animation(char.anims.kenn_basic_attack, 3, animation_type_full);
	} else play_animation(char.anims.kenn_basic_attack, 3, animation_type_partial, [0, 1]);
}

function character_Kenn(){
	
	static particles = (function(){

		stance = part_type_create();
		part_type_sprite(stance, base_character_kenn_stance, false, false, true);
		part_type_size(stance, 1.8, 1.6, +0.06, 0);
		part_type_speed(stance, 0.2, 0.5, 0, 0.08);
		part_type_life(stance, 30, 40);
		part_type_direction(stance, 0, 180, 0, 40);
		part_type_gravity(stance, 0.12, 90);
		part_type_alpha2(stance, 0.2, 0.01);
		
		tornado = part_type_create();
		part_type_sprite(tornado, base_character_kenn_tornado, 0, 0, true);
		part_type_size(tornado, 0.6, 0.6, 0.038, 0);
		part_type_life(tornado, 45, 55);
		part_type_direction(tornado, 90, 90, 0, 0)
		part_type_speed(tornado, 1, 1, -0.0008, 0);
		part_type_alpha3(tornado, 0.6, 0.2, 0);
		
		ultpart = part_type_create();
		part_type_shape(ultpart, pt_shape_sphere);
		part_type_color2(ultpart, #821511, #302727);
		part_type_size(ultpart, 0.08, 0.12, 0, 0);
		part_type_alpha2(ultpart, 0.5, 0);
		part_type_speed(ultpart, 0.8, 0.8, -0.002, 0);
		part_type_direction(ultpart, 0, 360, 0, 0);
		
		return {stance, tornado, ultpart};

	})();
	
	return {

		name: "Kenn",
		desc: "Blade of Rivalia",
		splash_art: kennSplashArt,
		circle: kennCircle,
		speed: 20,
		id: 1,
		base: base_character(1),
		sprite: base_character_kennidk,
		anims: animations(1),
		attach: [],
		ability_info: [{
			name: "Bladeshot",
			desc: "Kenn throws a blade. ALTERNATIVE CAST: Kenn scatters multiple blades at the direction of the mouse."
		},{
			name: "Sentinel's thrust",
			desc: "Kenn gains Acceleration for 8 seconds. During this time, Kenn's Bladeshot will bleed its target."
		},{
			name: "Furry of blades",
			desc: "Kenn enters a defensive stance, becoming a storm of blades."
		},{
			name: "Spectre",
			desc: "Kenn's spectre takes control for 50 seconds. During this time, Kenn heals when dealing damage with Bladeshot. If Kenn gets a kill, he heals fully and becomes Invisible for 1 second."
		}
		],
		abilities: {
	
			basic_attack: new Ability([0.3, 1], ability_type.onetime, {},
		
				function (n) {
			
					var _heal = char.abilities.ability1.active ? 15 : 0;
					var proj = char.abilities.ultimate.active ? obj_projectile_kenn_dagger_transformed : obj_projectile_kenn_dagger;
			
					repeat(n == 1 ? 4 : 1){
			
						projectile_create_fake(proj, x, y, 70, point_direction(x, y, mousex, mousey) + (n == 1 ? irandom_range(-20,20) : 0), true, false);
			
					}
					__kenn_animate_throw()
					
				}, NULLFUNC,
				function (n){
					__kenn_animate_throw()
				}, 
				function (n){
					dir = sign(mousex - x);
				}, 
				1/4.5, basicattackkenn, 0, false, false),
		
			ability1: new Ability(20, ability_type.active, {active_time: 8, active_func: function(){
			
				if (isFpsFrame) {
					if (random(1) > 0.8) part_particles_create(global.partSystemBehind, x, y + 32, gParts.kennSpeedParticle, irandom(2));	
				}
				
			}, end_func: function(){
		
					removeFilter(base_character_kenn_filter1);
		
				}}, function(){},
				
				function(){}, function(){
			
					addFilter(base_character_kenn_filter1, -5, 0.8);
			
				}, function(){
				}, 0, kennability2, 0),
		
			ability2: new Ability(30, ability_type.onetime, {}, 
			function(){}, function(){}, function(){ //visual
			
				play_animation(char.anims.kenn_stance, 1, animation_type_full);
			
			}, function(){ //casting
			
				if (char.abilities.ability2.cast_time < 2.1) and isFpsFrame {
					repeat(5) {
						part_particles_create(global.partSystemBehind, x + random_range(-10, 10), y + random_range(-40, 40), character_Kenn.particles.stance, 2);
					}
					part_particles_create(global.partSystem, x + random_range(-2, 2), y + random_range(20, 40), character_Kenn.particles.tornado, 1);
				}
			
				movvec.x *= 0.1;
				movvec.y *= 0.1;
				dir = sign(mousex - x);
			
			}, 3.1, kennability1, 0, false, true),
		
			ultimate: new Ability(80, ability_type.active, {active_time: 45, active_func: function(){}, end_func: function(){
		
					removeFilter(base_character_kenn_transformed)
		
				}}, NULLFUNC, function(){
			
					screen_shake(0.3, 0.5, 3);
					camera_ultimate_zoom(0.7, 5, easeInOutBack, 0.5, easeInOutBack, 0.5);
		
				}, function(){
			
					play_animation(char.anims.kenn_ultimate, 0.2, animation_type_full, true);
					dir = 1;
					createEvent(2.5, function(){
						 addFilter(base_character_kenn_transformed, -10, 1)
						 screen_shake(2, 1, 0.1);
					}, self)
			
				}, function(){
		
					movvec.x *= power(0.01, dtime);
					movvec.y *= power(0.01, dtime);
					if (isFpsFrame) {
						part_particles_create(global.partSystemBehind, x+irandom_range(-5,5), y+irandom_range(-8,3), character_Kenn.particles.ultpart, 1);
					}
		
				}, 2.5, ultimatekenn, #B22320, true, true),
	
		}

	}

}