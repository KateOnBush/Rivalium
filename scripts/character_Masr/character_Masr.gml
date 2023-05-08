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
	
	return {

		name: "Masr",
		speed: 32,
		id: 4,
		base: base_character(4),
		sprite: base_character_masr,
		anims: animations(4),
		attach: [],
		abilities: {
	
			basic_attack: new Ability([.1, .1], ability_type.onetime, {}, NULLFUNC, function(n){
			
				if (n == 0) {
			
					 __Masr_basicAttackAnim()
					 
				} else if (n == 1) {
				
					__Masr_alternativeBasicAttackAnim();
				
				}
				
			}, NULLFUNC, function() {
				dir = sign(mousex - x);
			}, 1/1.2, ability_unavailable, 0),
		
			ability1: new Ability([0.3], ability_type.onetime, {}, NULLFUNC, function(){
			
				play_animation(char.anims.ability1_swing, 2.5, animation_type_full, true)
			
			}, NULLFUNC, function(){
			
				dir = sign(mousex - x);
			
			}, 0.4, ability_unavailable, 0, false, true),
		
			ability2: new Ability([0], ability_type.onetime, {}, NULLFUNC, NULLFUNC, function(){
			
			}, NULLFUNC, 0, ability_unavailable, 0),
		
			ultimate: new Ability([10], ability_type.active, {active_time: 20, active_func: NULLFUNC, end_func: NULLFUNC, castCondition: function(){
			
				return on_ground;
			
			}}, NULLFUNC, function(){
				
				var dur = 1/0.15;
				camera_ultimate_zoom(0.7, dur, easeInOutBack, 0.5, easeInOutBack, 0.5);
				createEvent(0.38 * dur, function(){
					screen_shake(2, 5, 0.1);
				})
				createEvent(0.6 * dur, function(){
					screen_shake(2, 0.02, 0.4);
				})
				
			}, function(){
			
				play_animation(char.anims.ultimate, 0.15, animation_type_full, true);
			
			}, NULLFUNC, 0, ability_unavailable, 0),
	
		}

	}

}