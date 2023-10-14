function display_found_match(){
	
	isMessageOpen = true;
	MessageInstances = [];
	
	var currentMessage = MessageQueue[0];
		
	var oFound = instance_create_layer(0, 0, "MessageLayer", obj_match_found_display);
	
	array_push(MessageInstances, oFound);
	

}