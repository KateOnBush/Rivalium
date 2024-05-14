/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

text = "DECLINE"

size = 0.5;
userId = "";

loading = false;

onClick = function() {
	
	loading = true;
	account_server_send_message("friend.decline", {friend: userId}, function(content) {
		loading = false
		var error = struct_get_key_failsafe(content, "error");
		if is_string(error) {
			switch(error) {
				case "already.friends":
				{
					display_gui_message("Already friends.");
					break;
				}
				case "no.request":
				{
					display_gui_message("No such request.");
					break;
				}
				case "no.user":
				{
					display_gui_message("No such user.");
					break;
				}
			}
		} else display_gui_message("Request declined.");
		
	}, function(){
		loading = false;
	})
}