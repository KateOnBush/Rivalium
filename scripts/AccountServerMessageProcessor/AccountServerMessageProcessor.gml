#macro EventMap global.__event_map
#macro EventReplyMap global.__event_reply_map
#macro EventWaitQueue global.__event_queue

global.__event_queue = [];
global.__event_map = {};
global.__event_reply_map = {};

EventReplyMap[$ "client.version"] = ClientVersion();
EventReplyMap[$ "client.login"] = ClientLogin();
EventReplyMap[$ "client.signup"] = ClientSignup();
EventReplyMap[$ "client.heartbeat"] = ClientHeartbeat();
EventReplyMap[$ "client.autologin"] = ClientAutoLogin();

EventMap[$ "update.self"] = UpdateUserSelf();
EventMap[$ "update.user"] = UpdateUserOther();
EventMap[$ "match.found"] = MatchFound();

function AccountServerMessageProcessor(msg){
	
	var parsed;
	try {
		parsed = json_parse(msg);
	} catch(err){
		show_debug_message($"Could not parse incoming message: {msg}");
		return;
	}
	
	show_debug_message("Received: " + msg);
	var data = {
		content: parsed[$ "c"],
		event: parsed[$ "e"],
		reply: parsed[$ "r"],
		status: parsed[$ "s"]
	}
	
	if (data[$ "event"] == undefined) return;
	if (data[$ "content"] == undefined) return;
	var event = data.event;
	var content = data.content;
	
	if (event == "reply") {
	
		var repliesTo = data.reply;
		var status = data.status;
		if (status == "internal.error") {
			queue_normal_message(content.error ?? $"An internal server error occured to event {repliesTo}" , "OK", content.fatal ?? false);	
		}
		
		for(var j = 0; j < array_length(EventWaitQueue); j++){
			
			var queued = EventWaitQueue[j];
			if (queued.event == repliesTo) {
				
				var replyEventProcess = EventReplyMap[$ repliesTo];
				if (replyEventProcess != undefined) replyEventProcess(status, content);
				queued.onReply();
				array_delete(EventWaitQueue, j, 1);
				
				return;
			
			}
			
		}
		
	} else {
		
		var eventProcess = EventMap[$ event];
		
		if (eventProcess != undefined) eventProcess(content);
	
	}

}