#macro MessageQueue global.__message_queue
#macro currentMessage global.__message_queue[0]
#macro isMessageOpen global.__message_open
#macro MessageInstances global.__message_instances


isMessageOpen = false;
MessageQueue = [];
MessageInstances = [];

function Message(text, textState, width, height, buttonList = [], fatal = false, kind = "normal") constructor{

	self.id = "";
	self.kind = kind;
	self.textState = textState;
	self.text = text;
	self.width = width;
	self.height = height;
	self.buttonList = buttonList;
	self.fatal = fatal;
	
	self.onClose = NULLFUNC;
	
	self.close = function() {
		if (self.fatal) game_end();
		onClose();
		var i = 0;
		while(i < array_length(MessageQueue)) {
			if MessageQueue[i].text == self.text {
				if i == 0 close_current_message()
				else array_delete(MessageQueue, i, 1);
				break;
			}
		}
	}

}

function KindedMessage(kind) : Message("", 0, 0, 0, [], false, kind) constructor {}

function queue_kinded_message(kind, priority = false) {

	queue_message(new KindedMessage(kind), priority);

}

function message_button_get(sprite, text, purpose, purposeFunc = NULLFUNC) constructor{

	return {sprite, text, purpose, purposeFunc};

}

function queue_normal_message(text, buttonText, fatal, priority = false) {
	
	var btnlist = [message_button_get(secondaryButtonSprite, buttonText, "close")];
	var msg = new Message(text, TextState.NORMAL, 500, 160, btnlist, fatal);
	
	queue_message(msg, priority);
	
	return msg;
	
}

function queue_loading_message(text, priority = false) {

	var msg = new Message(text, TextState.LOADING, 500, 160, [], false);
	queue_message(msg, priority);
	
	return msg;

}

function queue_question_message(text, yesText, noText, onYes = NULLFUNC, onNo = NULLFUNC, priority = false) {

	var btnlist = [
		message_button_get(mainButtonSprite, yesText, "", onYes),
		message_button_get(secondaryButtonSprite, noText, "", onNo)
	];
	var msg = new Message(text, TextState.NORMAL, 500, 160, btnlist, false);
	
	queue_message(msg, priority);
	
	return msg;

}

function queue_message(msg, priority) {

	if priority {
		array_insert(MessageQueue, 0, msg);
		refresh_current_message()
	} else array_push(MessageQueue, msg);

}

function display_next_message() {

	if array_length(MessageQueue) == 0 return;
	
	isMessageOpen = true;
	MessageInstances = [];
	
	if (!instance_exists(objDimmedBackground)) instance_create_layer(0, 0, "Dim", objDimmedBackground);
	
	switch(currentMessage.kind) {
	
		case "playMatch": {
			display_play_match();
			return;
		}
		
		case "foundMatch": {
			display_found_match();
			return;
		}
		
		case "addFriend": {
			display_add_friend();
			return;
		}
		
		case "friendRequests": {
			display_requests();
			return;
		}
	
	}
	
	var mx = 1920/2, my = 1080/2;
	var ww = currentMessage.width,
		hh = currentMessage.height;
	
	var cx = mx - ww/2,
		cy = my - hh/2;

	//buttons
	var btnList = currentMessage.buttonList;
	var btnSize = array_length(btnList);
	for(var i = 0; i < btnSize; i++){
		
		var currentBtn = btnList[i];
		var currentText = currentBtn.text;
		var bw = 180, bh = 40;
		
		var oBtn = instance_create_layer(
			mx - (ww/2 - (ww * (i + .5))/btnSize) * .9, 
			my + hh/2 - bh,
		"MessageLayer", baseButton);
		
		oBtn.sprite_index = currentBtn.sprite;
		oBtn.width = bw;
		oBtn.height = bh;
		oBtn.text = currentText;
		oBtn.z = 1;
		oBtn.followUI = 1;
		
		if (currentBtn.purpose == "close") oBtn.onClick = close_current_message;
		else oBtn.onClick = currentBtn.purposeFunc;
		
		array_push(MessageInstances, oBtn);
		
	}
	
	var oText = instance_create_layer(mx, my - hh * .15, "MessageLayer", baseText);
	var oField = instance_create_layer(cx, cy, "MessageLayer", field);
	
	oField.sprite_index = fieldSprite;
	oField.width = ww;
	oField.height = hh;
	oField.z = 1;
	oField.followUI = 1;
	
	oText.image_xscale = (currentMessage.width - 80) / sprite_get_width(oText.sprite_index);
	oText.align = 0;
	oText.text = currentMessage.text;
	oText.size = 1.1;
	oText.alpha = 1;
	oText.state = currentMessage.textState;
	oText.z = 1;
	oText.followUI = 1;
	
	array_push(MessageInstances, oField, oText);

}

function refresh_current_message() {

	array_foreach(MessageInstances, instance_destroy);
	MessageInstances = [];
	isMessageOpen = false;
	
	display_next_message();

}

function close_current_message() {

	array_foreach(MessageInstances, instance_destroy);
	MessageInstances = [];
	
	isMessageOpen = false;
	
	if array_length(MessageQueue) == 0 return;
	
	var currentMessage = MessageQueue[0];
	currentMessage.onClose();
	
	if currentMessage.fatal game_end();
	
	array_delete(MessageQueue, 0, 1);

}

function display_gui_message(message) {
	if instance_exists(gameManager) {
		gameManager.lastMessage = message;
		if (gameManager.backBlend < 0.2) gameManager.displayMessage = message;
		gameManager.textDuration = 5;
	}
}