/// @description Insert description here
// You can write your code in this editor

draw_set_font(font_animator);

var maxw = 0;
for(var i = 0; i < array_length(names); i++){
	maxw = max(string_width(names[i]), maxw);
}
draw_set_alpha(.95);
draw_set_color(c_dkgrey)
draw_rectangle(x, y, x + maxw + 4, y + (string_height("M") + 4) * array_length(names), false);

var clicked = mouse_check_button_pressed(mb_left);

for(var i = 0; i < array_length(names); i++){
	
	var text = names[i], 
	w = maxw + 4, h = string_height(text) + 4, 
	xx = x, 
	yy = y + h * i;

	var inside = is_between(xx, mouse_x, xx + w) and is_between(yy, mouse_y, yy + h);

	if inside {
		draw_set_alpha(0.8);
		draw_set_color(c_aqua)
		draw_rectangle(xx, yy, xx + w, yy + h, false);
		if clicked event(i);
	}
	

	draw_set_alpha(1);
	draw_set_color(c_black)
	draw_rectangle(xx, yy, xx + w, yy + h, true);
	
	draw_set_color(c_white)
	draw_set_valign(fa_middle)
	draw_set_halign(fa_center)
	draw_text(xx + w/2, yy + h/2, names[i]);
	
}

if (clicked) {
	instance_destroy();
}

