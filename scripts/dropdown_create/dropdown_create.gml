function dropdown_create(names, event){

	var o = instance_create_depth(mouse_x, mouse_y, -100, dropdown_menu);
	o.names = names;
	o.event = event;

}