/// @description draw_button_simple(x1,y1,x2,y2,text)
function draw_button_simple(x1, y1, x2, y2, text) {

	var inside = false;

	if mouse_x < x2 and mouse_x > x1 and mouse_y < y2 and mouse_y>y1 {

		inside = true;
		draw_set_color(c_white)
		draw_rectangle(x1,y1,x2,y2,false)

	}

	draw_set_color(c_black)

	draw_rectangle(x1,y1,x2,y2,true)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text_transformed((x1+x2)/2,(y1+y2)/2,text, 0.7, 0.7, 0)

	if mouse_check_button_released(mb_left) and inside {
		return true;	
	}

	return false;


}
