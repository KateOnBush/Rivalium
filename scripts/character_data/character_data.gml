// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


function setupCharacterData(){

	var characters = [
		character_Kenn(),
		character_Gramin(),{

		name: "Crystia",
		speed: 29,
		id: 3,
		base: base_character(1),
		sprite: base_character_sonia,
		anims: animations(1),
		attach: [[base_character_sonia_hair,47,25,1,6]],
		abilities: character_Kenn().abilities

	}]
	
	return characters;

}