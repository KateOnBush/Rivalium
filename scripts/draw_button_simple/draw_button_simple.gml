/// @description draw_button_simple(x1,y1,x2,y2,text)
function draw_button_simple(x1, y1, x2, y2, text, in = 0, selected = false) {

	var inside = mouse_x < x2 and mouse_x > x1 and mouse_y < y2 and mouse_y>y1;
	if inside {
		window_set_cursor(cr_handpoint);	
	}
	

	draw_set_alpha(1);
	draw_sprite_stretched(animator_button, selected ? 2 : !inside, x1, y1, x2 - x1, y2 - y1);
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_set_color(c_white);
	draw_set_font(font_animator);
	if (!is_string(text) && sprite_exists(text)){
		draw_sprite(text, in, (x1+x2)/2,(y1+y2)/2);
	} else draw_text_transformed((x1+x2)/2,(y1+y2)/2, text, 1, 1, 0);

	if mouse_check_button_released(mb_left) and inside {
		return true;	
	}

	return false;


}
