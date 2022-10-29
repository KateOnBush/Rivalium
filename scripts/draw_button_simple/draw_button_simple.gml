/// @description draw_button_simple(x1,y1,x2,y2,text)
function draw_button_simple(argument0, argument1, argument2, argument3, argument4) {

	var inside = false;

	if mouse_x < argument2 and mouse_x > argument0 and mouse_y < argument3 and mouse_y>argument1 {

		inside = true;
		draw_set_color(c_white)
		draw_rectangle(argument0,argument1,argument2,argument3,false)

	}

	draw_set_color(c_black)

	draw_rectangle(argument0,argument1,argument2,argument3,true)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text((argument0+argument2)/2,(argument1+argument3)/2,argument4)

	if mouse_check_button_released(mb_left) and inside {
		return true;	
	}

	return false;


}
