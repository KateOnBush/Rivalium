// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


function __leyna_shootVisualBlueHand(){
	
	var _s = sign(mousex - x);
	var _pos = 1 - abs(angle_difference(point_direction(x, y, mousex, mousey), -270))/180;
		
	var frame1 = animation_get_frame(char.anims.throw_prep_blue_hand, _pos);
	var frame2 = animation_get_frame(char.anims.throw_shoot_blue_hand, _pos);
	
	char.abilities.basic_attack.cast_time = 0.15;
		
	var animation = animation_construct([frame1, frame2], [0, 1], [framestyle.backease, framestyle.exponential]);
	
	if _s != sign(movvec.x) and movvec.length() > 5 {
		play_animation(animation, 4.5, animation_type_full,,,0.4);
	} else {
		play_animation(animation, 4.5, animation_type_partial, [0, 1, 7, 9, 10], true,0.4);
	}
	
}

function __leyna_shootVisualRedHand(){
	
	var _s = sign(mousex - x);
	var _pos = 1 - abs(angle_difference(point_direction(x, y, mousex, mousey), -270))/180;
		
	var frame1 = animation_get_frame(char.anims.throw_prep_red_hand, _pos);
	var frame2 = animation_get_frame(char.anims.throw_shoot_red_hand, _pos);
	
	char.abilities.basic_attack.cast_time = 0.15;
		
	var animation = animation_construct([frame1, frame2], [0, 1], [framestyle.backease, framestyle.exponential]);
	
	if _s != sign(movvec.x) and movvec.length() > 5 {
		play_animation(animation, 4.5, animation_type_full,,,0.4);
	} else {
		play_animation(animation, 4.5, animation_type_partial, [0, 1, 7, 9, 10], true,0.4);
	}
	
}


function character_Lenya(){

	return {

		name: "Lenya",
		speed: 29,
		id: 3,
		base: base_character(3),
		sprite: base_character_lenya,
		anims: animations(3),
		attach: [[base_character_lenya_hair,0,-2,0.7,6]],
		abilities: {
		
			basic_attack: new Ability([0.35, 0.35], ability_type.onetime, {}, function(n){

				var d = point_direction(x, y, mousex, mousey);
				var proj = n == 1 ? obj_projectile_lenya_red_bullet : obj_projectile_lenya_blue_bullet;
				projectile_create_request(proj, x, y, 60, d, true, true, 20);
			
			}, function(n){ // Cast visual
			
				if (n == 0) __leyna_shootVisualBlueHand();
				else __leyna_shootVisualRedHand();
			
			}, function(){ //Casting
			
				dir = sign(mousex - x); 
			
			}, 0.1, kennability2, 0),
				
				
			ability1: new Ability(5, ability_type.onetime, {}, function(){}, function(){}, function(){}, 0, kennability2, 0),
				
				
			ability2: new Ability(5, ability_type.onetime, {}, function(){}, function(){}, function(){}, 0, kennability2, 0),
				
				
			ultimate: new Ability(5, ability_type.onetime, {}, function(){}, function(){}, function(){}, 0, kennability2, 0),
		
		}

	}

}
