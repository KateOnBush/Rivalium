/// @description Insert description here
// You can write your code in this editor

if state == buttonState.LOADING {
	_angle += 10*dtime;
	var hei = string_height("0") * 0.75;
	textX = x + hei * 0.8;
	textY = y;
} else {
	textX = x;
	textY = y;
}

if is_between(bbox_left, mouse_x, bbox_right, true) && is_between(bbox_top, mouse_y, bbox_bottom, true) {

	if (!mouseIsInside) {
		window_set_cursor(cr_handpoint);
		onHover();
		mouseIsInside = true;
	}
	if state == buttonState.ON {
		image_alpha = dtlerp(image_alpha, 0.65, 0.06);	
	}
	if mouse_check_button_pressed(mb_left){
		onClick();	
	}

} else {

	
	if (mouseIsInside) window_set_cursor(cr_default);
	onExit();
	mouseIsInside = false;

}

if !mouseIsInside image_alpha = dtlerp(image_alpha, 1, 0.06);

if displayText != text {

	textAlpha = dtlerp(textAlpha, 0, 0.3);
	if textAlpha < 0.001 displayText = text;

} else {

	textAlpha = dtlerp(textAlpha, 1, 0.3);

}

loadingBlend = dtlerp(loadingBlend, (state == buttonState.LOADING), 0.06);
unavailableBlend = dtlerp(unavailableBlend, (state != buttonState.ON), 0.06);
displayTextX = dtlerp(displayTextX, textX, 0.06);
displayTextY = dtlerp(displayTextY, textY, 0.06);