/// @description Insert description here
// You can write your code in this editor

event_inherited();

if is_hovering() {

	if mouse_check_button_pressed(mb_left) {
		checked = !checked;
	}
	
	if !mouseIsInside {
		window_set_cursor(cr_handpoint);
		mouseIsInside = true;
	}

} else {

	if mouseIsInside {
		window_set_cursor(cr_default);
		mouseIsInside = false;
	}

}

checkedBlend = dtlerp(checkedBlend, checked, 0.3);






