function AccountServerMessageProcessor(msg){
	
	var data;
	try {
		data = json_parse(msg);
	} catch(err){
		show_debug_message($"Could not parse incoming message: {msg}");
		return;
	}
	
	if (data[$ "event"] == undefined) return;
	if (data[$ "content"] == undefined) return;
	var event = data.event;
	var content = data.content;
	
	switch(event){
	
		case "reply": {
			
			var repliesTo = data[$ "reply"];
			var status = data[$ "status"];
			
			if (status == "internal.error") {
			
				show_message(content[$ "error"]);
				if (content[$ "fatal"]) game_end();
				return;
			
			}
			
			switch(repliesTo) {
			
				case "client.version": {
					
					if (status == "ok") ClientStatus.authentication = AuthenticationStatus.AUTHORIZED;
					else {
						show_message("Client version is outdated, need to update.");	
					}
					
					break;
				}
			
			}
			
			break;
		}
	
	}

}