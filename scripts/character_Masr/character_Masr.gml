function __Masr_basicAttackAnim() {

	if sign(mousex - x) != sign(movvec.x) and movvec.length() > 4 {
		dir = sign(mousex - x);
		play_animation(char.anims.swing_midair, 3, animation_type_full);
	} else if (movvec.length() > 4) {
		play_animation(char.anims.swing, 3, animation_type_partial, [0, 1, 2, 7, 8, 9]);
	} else play_animation(char.anims.swing, 3, animation_type_full);

}

function __Masr_alternativeBasicAttackAnim(){

	if sign(mousex - x) != sign(movvec.x) and movvec.length() > 4 {
		dir = sign(mousex - x);
		play_animation(char.anims.swing_alt_midair, 1.2, animation_type_full, [], true);
	} else if (movvec.length() > 4) {
		play_animation(char.anims.swing_alt, 1.2, animation_type_partial, [0, 1, 2], true);
	} else play_animation(char.anims.swing_alt, 1.2, animation_type_full, [], true);

}


function character_Masr(){
	
	static particles = (function(){

		electricity = part_type_create();
		part_type_sprite(electricity, base_character_masr_slash_part, false, false, true);
		part_type_alpha3(electricity, .8, 0.6, 0)
		part_type_size(electricity, .01, .8, 0, 0)
		part_type_life(electricity, 10, 20)
		part_type_orientation(electricity, 0, 360, 0, 0, 0);
		
		cloud = part_type_create();
		part_type_sprite(cloud, base_character_masr_cloud, false, false, true);
		part_type_speed(cloud, 3, 15, -0.05, 0);
		part_type_alpha2(cloud, 0.8, 0);
		part_type_size(cloud, 1, 4, -0.05, 0);
		part_type_life(cloud, 60, 90);
		
		return {electricity, cloud};

	})();
	
	return {

		name: "Masr",
		desc: "Stormblade Sentinel",
		splash_art: masrSplashArt,
		circle: masrCircle,
		speed: 20.5,
		id: 4,
		base: base_character(4),
		sprite: base_character_masr,
		anims: animations(4),
		attach: [],
		ability_info: [{
			name: "Thunderbolt",
			desc: "Masr shoots a thunderbolt from his sword. ALTERNATIVE CAST: Masr charges his sword briefly and shoots a powerful bolt that explodes on impact."
		},{
			name: "Storm Barrier",
			desc: "Masr creates a windwall in front of him that blocks all projectiles."
		},{
			name: "Tempest Blink",
			desc: "Masr performs a quick dash in any direction."
		},{
			name: "Storm Wrath",
			desc: "Masr charges his sword with a powerful thunderbolt and enters a powerful stance. During this time, Masr will become invisible when performing Tempest Blink, and his Thunderbolts will bounce."
		}
		],
		abilities: {
	
			basic_attack: new Ability([.3, 1.8], ability_type.onetime, {}, NULLFUNC, NULLFUNC, function(n){
			
				if (n == 0) {
			
					__Masr_basicAttackAnim()
					 
				} else if (n == 1) {
				
					__Masr_alternativeBasicAttackAnim();
				
				}

				
			}, function() {
				dir = sign(mousex - x);
			}, 1/1.2, masr_basic_attack, 0),
		
			ability1: new Ability([20], ability_type.onetime, {}, NULLFUNC, NULLFUNC, function(){
			
				play_animation(char.anims.ability1_swing, 2.5, animation_type_full, true)
			
			}, function(){
			
				dir = sign(mousex - x);
			
			}, 0.4, masr_ability1, 0, false, true),
		
			ability2: new Ability([8], ability_type.onetime, {}, NULLFUNC, NULLFUNC, function(){
			
				var dir = point_direction(x, y, mousex, mousey);
				var distance = 300, i = 0;
				repeat(15) {
					var _x = lengthdir_x(distance * i/10, dir), _y = lengthdir_y(distance * i/15, dir);
					_x += random_range(-10, 10); _y += random_range(-10, 10);
					part_particles_create(global.partSystemBehind, x + _x, y + _y, character_Masr.particles.electricity, random(3));						
					i++;
				}
			
			}, NULLFUNC, 0, masr_ability2, 0),
		
			ultimate: new Ability([80], ability_type.active, {active_time: 20, active_func: NULLFUNC, end_func: function(){
			
				sprite = base_character_masr;
			
			}, castCondition: function(){
			
				return on_ground;
			
			}}, NULLFUNC, function(){
				
				var dur = 1/0.15;
				camera_ultimate_zoom(0.7, dur, easeInOutBack, 0.5, easeInOutBack, 0.5);
				createEvent(0.38 * dur, function(){
					screen_shake(1, 5, 0.1);
					sprite = base_character_masr_transformed;
					repeat(40) {
						var _dir = choose(0, 180);
						part_type_direction(character_Masr.particles.cloud, _dir, _dir, 0, 0);
						part_particles_create(global.partSystem, x, y + 20, character_Masr.particles.cloud, random(3));
					}
					var distance = 400, i = 0;
					repeat(40) {
						part_particles_create(global.partSystemBehind, x, y - (distance * i / 20), character_Masr.particles.electricity, random(3));						
						i++;
					}
				}, self)
				
			}, function(){
			
				play_animation(char.anims.ultimate, 0.15, animation_type_full, true);
			
			}, function(){
			
				movvec.x *= 0.1;
				movvec.y *= 0.1;
			
			}, 1/0.15, masr_ult, 0, true, true),
	
		}

	}

}