/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

text = "ADD"

size = 0.5;
userId = "";

loading = false;

onClick = function() {
	
	loading = true;
	account_server_send_message("friend.add", {friend: userId}, function(content) {
		var error = struct_get_key_failsafe(content, "error");
		if is_string(error) {
			switch(error) {
				case "already.friends":
				{
					display_gui_message("Already friends.");
				}
				case "already.sent":
				{
					display_gui_message("Friend request already sent.");
				}
				case "no.user":
				{
					display_gui_message("No such user.");
				}
			}
		} else display_gui_message("Friend request sent.");
		loading = false
	}, function(){
		loading = false;
	})
}