function playerInputs(){

	k_right = input_right.check();
	k_left = input_left.check();
	k_dash = input_dash.check();
	k_jump = input_up.pressed();
	k_slide = input_down.check();
	k_slide_release = input_down.released();
	k_grapple = input_grapple.check();
	
	k_move = k_right or k_left or k_jump;

}