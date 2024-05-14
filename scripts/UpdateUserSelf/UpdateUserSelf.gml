function UpdateUserSelf() {
	
	static process = function(content) {
		
		UserData = content;
		var friends = struct_get_key_failsafe(UserData, "friendManager.friendList") ?? [];
		var requests = struct_get_key_failsafe(UserData, "friendManager.receivedFriendRequests") ?? [];
		array_foreach(friends, function(friend) {
			if !userdata_other_loaded(friend) {
				account_server_send_message("fetch.user", {id: friend});
			}
		});
		array_foreach(requests, function(request) {
			if !userdata_other_loaded(request) {
				account_server_send_message("fetch.user", {id: request});
			}
		});
		
	}
	
	return process;

}