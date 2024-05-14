/// @description Insert description here
// You can write your code in this editor

event_inherited();

_angle = 0;
result = [];
currentResult = [];
loading = false;

search = function(query) {

	result = [];
	loading = true;
	
	account_server_send_message("friend.search", { query }, function(content){
	
		loading = false;
		result = content;
		if !is_array(result) result = [];
	
	}, function() {
	
		loading = false;
	
	})

}