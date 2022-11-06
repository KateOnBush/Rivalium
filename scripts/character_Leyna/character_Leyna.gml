// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function character_Lenya(){

	return {

		name: "Lenya",
		speed: 29,
		id: 3,
		base: base_character(3),
		sprite: base_character_lenya,
		anims: animations(1),
		attach: [[base_character_lenya_hair,47,25,1,6]],
		abilities: {
		
			basic_attack: new Ability(5, ability_type.onetime, {}, function(){}, function(){}, function(){}, 0, kennability2, 0),
				
				
			ability1: new Ability(5, ability_type.onetime, {}, function(){}, function(){}, function(){}, 0, kennability2, 0),
				
				
			ability2: new Ability(5, ability_type.onetime, {}, function(){}, function(){}, function(){}, 0, kennability2, 0),
				
				
			ultimate: new Ability(5, ability_type.onetime, {}, function(){}, function(){}, function(){}, 0, kennability2, 0),
		
		}

	}

}
