function display_add_friend(){
	
	var currentMessage = MessageQueue[0];
	
	var mx = 1920/2, my = 1080/2;
	var ww = 320,
		hh = 800;
		
	var cx = mx - ww/2,
		cy = my - hh/2;
		
	var oText = instance_create_layer(cx, cy, "MessageLayer", baseText);
	oText.set_width(ww - 32);
	oText.x = mx;
	oText.y = cy + (100 - 24)/2;
	oText.size = 1.3;
	oText.text = "ADD A FRIEND";
	oText.align = 0;
	
	var oInput = instance_create_layer(mx, cy + 100, "MessageLayer", addFriendInput);
	oInput.set_width(ww - 32);
	oInput.set_height(48);
	oInput.z = 1;
	
	var oView = instance_create_layer(cx + 16 + 16, cy + 100 + 32 + 16, "MessageLayer", addFriendsView);
	oView.set_width(ww - 64);
	oView.set_height(hh - 16 - 20 - 100 - 24 - 20 - 32 - 32);
	oView.z = 1;
	
	var oDarkField = instance_create_layer(cx + 16, cy + 100 + 32, "MessageLayer", fieldDark);
	oDarkField.set_width(ww - 32);
	oDarkField.set_height(hh - 16 - 20 - 100 - 24 - 20 - 32);
	
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
	
	array_push(MessageInstances, oInput);
	array_push(MessageInstances, oText);
	array_push(MessageInstances, oView);
	array_push(MessageInstances, oDarkField);
	array_push(MessageInstances, oCancel);
	
	array_push(MessageInstances, oField);
	
}