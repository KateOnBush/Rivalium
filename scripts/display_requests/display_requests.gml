function display_requests(){
	
	var currentMessage = MessageQueue[0];
	
	var mx = 1920/2, my = 1080/2;
	var ww = 320,
		hh = 800;
		
	var cx = mx - ww/2,
		cy = my - hh/2;
		
	var oText = instance_create_layer(cx, cy, "MessageLayer", baseText);
	oText.set_width(ww - 32);
	oText.x = mx;
	oText.y = cy + 32;
	oText.size = 1.3;
	oText.text = "FRIEND REQUESTS";
	oText.align = 0;
	
	var oView = instance_create_layer(cx + 16 + 8, cy + 64 + 8, "MessageLayer", requestsView);
	oView.set_width(ww - 48);
	oView.set_height(hh - 64 - 16 - 40 - 16 - 16);
	oView.z = 1;
	
	var oDarkField = instance_create_layer(cx + 16, cy + 64, "MessageLayer", fieldDark);
	oDarkField.set_width(ww - 32);
	oDarkField.set_height(hh - 64 - 16 - 40 - 16);
	
	var oCancel = instance_create_layer(cx, cy, "MessageLayer", baseButton);
	oCancel.sprite_index = secondaryButtonSprite;
	oCancel.set_width(ww - 32);
	oCancel.set_height(40);
	oCancel.size = .8;
	oCancel.text = "BACK"
	oCancel.x = mx;
	oCancel.y = my + hh/2 - 16 - 20;
	oCancel.z = 1;
	oCancel.onClick = close_current_message;
		
	var oField = instance_create_layer(cx, cy, "MessageLayer", field);
	oField.sprite_index = fieldSprite;
	oField.set_width(ww);
	oField.set_height(hh);
	
	array_push(MessageInstances, oText);
	array_push(MessageInstances, oView);
	array_push(MessageInstances, oDarkField);
	array_push(MessageInstances, oCancel);
	
	array_push(MessageInstances, oField);
	
}