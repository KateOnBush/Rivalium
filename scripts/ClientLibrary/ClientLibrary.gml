enum buttonState {
	ON,
	LOADING,
	UNAVAILABLE
}

enum InputState {
	NORMAL,
	CORRECT,
	INCORRECT
}

enum TextState {
	NORMAL,
	LOADING,
	SUCCESS,
	ERROR
}

function is_hovering() {

	return is_between(bbox_left, mouse_x, bbox_right, true) && is_between(bbox_top, mouse_y, bbox_bottom, true) && (z > 0 or !isMessageOpen);

}

function stick_to_view() {
	
	var c = view_camera[0];
	var xsc = camera_get_view_width(c) / 1920;
	var ysc = camera_get_view_height(c) / 1080;

	x = camera_get_view_x(c) + xstart * xsc;
	y = camera_get_view_y(c) + ystart * ysc;
	
}
