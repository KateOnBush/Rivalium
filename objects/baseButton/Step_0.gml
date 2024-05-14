/// @description Insert description here
// You can write your code in this editor

if state == buttonState.LOADING {
	_angle += 10*dtime;
	var hei = string_height("0") * 0.7;
	textX = hei * 0.8;
	textY = 0;
} else {
	textX = 0;
	textY = 0;
}

if is_hovering() {

	if (!mouseIsInside or window_get_cursor() != cr_handpoint) {
		window_set_cursor(cr_handpoint);
		onHover();
		mouseIsInside = true;
	}
	if state == buttonState.ON {
		hoverBlend = dtlerp(hoverBlend, 1, 0.08);	
	}
	if mouse_check_button_released(mb_left) && state == buttonState.ON {
		onClick();	
	}

} else {

	
	if (mouseIsInside) { 
		window_set_cursor(cr_default)
		onExit();
		mouseIsInside = false;
	}

}

if !mouseIsInside hoverBlend = dtlerp(hoverBlend, 0, 0.08);

if displayText != text {

	textAlpha = dtlerp(textAlpha, 0, 0.3);
	if textAlpha < 0.001 displayText = text;

} else {

	textAlpha = dtlerp(textAlpha, 1, 0.3);

}

loadingBlend = dtlerp(loadingBlend, (state == buttonState.LOADING) || sprite_exists(icon), 0.06);
unavailableBlend = dtlerp(unavailableBlend, (state != buttonState.ON), 0.06);
displayTextX = dtlerp(displayTextX, textX, 0.06);
displayTextY = dtlerp(displayTextY, textY, 0.06);