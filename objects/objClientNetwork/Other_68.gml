/// @description Insert description here
// You can write your code in this editor

if (async_load[? "id"] != accountServer) exit;

var type = async_load[? "type"];

switch(type){

	case network_type_non_blocking_connect: {
	
		var success = async_load[? "succeeded"];
		if (success) {

			show_debug_message("Connection success!")
			ClientStatus.connection = ConnectionStatus.CONNECTED;
			ClientStatus.authentication = AuthenticationStatus.UNAUTHORIZED;
			
			if instance_exists(loginButton) && !alreadyConnected {
				loginButton.state = buttonState.LOADING;
				loginButton.text = "CHECKING FOR UPDATES"
			}
			if instance_exists(signupButton) && !alreadyConnected {
				signupButton.state = buttonState.LOADING;
				signupButton.text = "CHECKING FOR UPDATES"
			}
			
			account_server_send_message("client.version", {version: GAMEVERSION});
			
			alreadyConnected = true;
			reconnectionAttempts = 0;
			lastHeartbeatConfirmed = true;
			timeSinceLastHeartbeat = 0;
			
		} else {
			show_debug_message("Connection timed out.")
			ClientStatus.connection = ConnectionStatus.DISCONNECTED;
			
			if reconnectionAttempts <= MaxReconnectAttempts {
				timerReconnect = fibonnacciSequence(reconnectionAttempts) * 2;
				show_debug_message($"Attempting reconnection in {timerReconnect} seconds...");
			} else {
				if is_struct(lostConnectionMessage) lostConnectionMessage.close();
				lostConnectionMessage = -1;
				queue_normal_message("Unfortunately, we can't connect you back to the server. Please try again later.", "I UNDERSTAND", true);	
			}
		}
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
	
	case network_type_down: {
	
		show_debug_message("Network down?")
		ClientStatus.connection = ConnectionStatus.DISCONNECTED;
		ClientStatus.authentication = AuthenticationStatus.AUTHORIZED;
		break;
	
	}
	

}