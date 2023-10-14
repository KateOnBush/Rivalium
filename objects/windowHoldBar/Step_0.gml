/// @description Insert description here
// You can write your code in this editor

if mouse_check_button_pressed(mb_left) && is_hovering() {
	
	startX = display_mouse_get_x();
	startY = display_mouse_get_y();
	
	startWindowX = window_get_x();
	startWindowY = window_get_y();
	
	 started = true;
	
} else if mouse_check_button(mb_left) && started {
		
	var mx = display_mouse_get_x(),
		my = display_mouse_get_y();
	
	window_set_position(startWindowX + (mx - startX), startWindowY + (my - startY));

} else {
	started = false;	
}






