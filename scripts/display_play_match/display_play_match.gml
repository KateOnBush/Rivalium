#macro inQueue global.__in_queue
#macro joinedQueue global.__joined_queue

inQueue = false;
joinedQueue = "";

function queue_to_full_name(queue) {

	if (queue == "casual") return "Casual";
	if (queue == "ranked") return "Competitive";
	return "";

}

function request_join_queue(queue){
	
	close_current_message();
	joinedQueue = queue;
	if instance_exists(joinButton) {
		joinButton.state = buttonState.LOADING;
		joinButton.text = "JOINING QUEUE"
	}
	account_server_send_message("party.join.queue", {queue}, NULLFUNC, 
	function() {
		queue_normal_message("Unable to join queue. Please try again later.", "OK", false);
		if instance_exists(joinButton) joinButton.reset();
	})

}

function display_play_match(){

	global.selected_description = "";

	isMessageOpen = true;
	MessageInstances = [];
	
	var currentMessage = MessageQueue[0];
	
	var mx = 1920/2, my = 1080/2;
	var ww = 1280 * .8,
		hh = 720 * .8;
		
	var cx = mx - ww/2,
		cy = my - hh/2;
		
	var oCasual = instance_create_layer(cx, cy, "MessageLayer", playMenuButton);
	oCasual.bigText = "CASUAL"
	oCasual.description = "Unrated default 4v4 gamemode. First to 15 planted gems wins.";
	oCasual.image = casualSplash;
	oCasual.width = (ww - 128) * .33;
	oCasual.height = (hh - 128);
	oCasual.x = cx + 32 + oCasual.width/2;
	oCasual.y = cy + 32 + oCasual.height/2;
	oCasual.z = 1;
	oCasual.onClick = function() { request_join_queue("casual"); }
	
	var oRanked = instance_create_layer(cx, cy, "MessageLayer", playMenuButton);
	oRanked.bigText = "COMPETITIVE"
	oRanked.description = "Competitive default 4v4 gamemode. Compete to climb to the highest Rivalry Rank. First to 15 planted gems wins."
	oRanked.image = rankedSplash;
	oRanked.width = (ww - 128) * .33;
	oRanked.height = (hh - 128);
	oRanked.x = cx + 64 + oCasual.width * 1.5;
	oRanked.y = cy + 32 + oCasual.height/2;
	oRanked.z = 1;
	oRanked.onClick = function() { request_join_queue("casual"); }
	
	var oTraining = instance_create_layer(cx, cy, "MessageLayer", playMenuButton);
	oTraining.bigText = "TRAINING"
	oTraining.image = emptySplash;
	oTraining.description = "Training room to practice your favorite Rival and master him."
	oTraining.width = (ww - 128) * .33;
	oTraining.height = (hh - 128) * .5 - 16;
	oTraining.x = cx + 96 + oCasual.width * 2.5;
	oTraining.y = cy + 32 + oTraining.height / 2;
	oTraining.z = 1;
	oTraining.onClick = function() { close_current_message(); queue_normal_message("This feature is unavailable for the moment.", "OK", false); };
	
	var oPrivate = instance_create_layer(cx, cy, "MessageLayer", playMenuButton);
	oPrivate.bigText = "PRIVATE"
	oPrivate.image = emptySplash;
	oPrivate.description = "Make your own customized game and play with friends!";
	oPrivate.width = (ww - 128) * .33;
	oPrivate.height = (hh - 128) * .5 - 16;
	oPrivate.x = cx + 96 + oCasual.width * 2.5;
	oPrivate.y = cy + 64 + oPrivate.height * 1.5;
	oPrivate.z = 1;
	oPrivate.onClick = function() { close_current_message(); queue_normal_message("This feature is unavailable for the moment.", "OK", false); };
	
	var oText = instance_create_layer(cx, cy, "MessageLayer", playMenuDescription);
	oText.width = (ww - 128);
	oText.x = mx - ww * .1;
	oText.y = my + hh/2 - 48;
	oText.align = 0;
	
	var oCancel = instance_create_layer(cx, cy, "MessageLayer", baseButton);
	oCancel.sprite_index = secondaryButtonSprite;
	oCancel.width = 160;
	oCancel.height = 40;
	oCancel.size = .8;
	oCancel.text = "CANCEL"
	oCancel.x = mx + ww/2 - 32 - oCancel.width/2;
	oCancel.y = my + hh/2 - 48;
	oCancel.z = 1;
	oCancel.onClick = close_current_message;
	
	array_push(MessageInstances, oCasual);
	array_push(MessageInstances, oRanked);
	array_push(MessageInstances, oTraining);
	array_push(MessageInstances, oPrivate);
	array_push(MessageInstances, oText);
	array_push(MessageInstances, oCancel);
		
	var oField = instance_create_layer(cx, cy, "MessageLayer", field);
	oField.sprite_index = fieldSprite;
	oField.width = ww;
	oField.height = hh;
	
	array_push(MessageInstances, oField);
	
	

}