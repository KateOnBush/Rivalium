/// @description Insert description here
// You can write your code in this editor

var type = async_load[? "type"];

switch(type){

	case network_type_non_blocking_connect: {
	
		var success = async_load[? "succeeded"];
		if (success) {
			
			show_debug_message("Connection success!")
			ClientStatus.connection = ConnectionStatus.CONNECTED;
			ClientStatus.authentication = AuthenticationStatus.UNAUTHORIZED;
			
			account_server_send_message("client.version", {version: GAMEVERSION});
			
		} else {
			show_debug_message("Connection timed out.")
			ClientStatus.connection = ConnectionStatus.DISCONNECTED;
		}
		break;
	
	}
	
	case network_type_disconnect: {
	
		ClientStatus.connection = ConnectionStatus.DISCONNECTED;
		break;
	
	}
	
	case network_type_data: {
	
		if (ClientStatus.connection != ConnectionStatus.CONNECTED) break;
		var buffer = async_load[? "buffer"];
		var allData = buffer_read(buffer, buffer_text);
		var messages = string_split(allData, "\0", true);
		array_foreach(messages, AccountServerMessageProcessor)
		break;
	
	}
	

}