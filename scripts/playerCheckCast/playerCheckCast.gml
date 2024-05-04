function playerCheckCast(){
	
	if casting return;

	if mouse_check_button_released(mb_left){

		castedAbility = 0;
		char.abilities.basic_attack.requestCast(0, self); 

	} else if mouse_check_button_released(mb_right){

		castedAbility = 0;
		char.abilities.basic_attack.requestCast(1, self);

	}

	if keyboard_check_pressed(ord("X")){

		castedAbility = 3;
		char.abilities.ultimate.requestCast(0, self)

	}

	if keyboard_check_pressed(ord("Q")){

		castedAbility = 1;
		char.abilities.ability1.requestCast(0, self)	

	}
	
	if keyboard_check_pressed(ord("E")){

		castedAbility = 2;
		char.abilities.ability2.requestCast(0, self)	

	}

}