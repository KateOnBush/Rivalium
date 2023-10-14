/// @description Insert description here
// You can write your code in this editor

if ClientStatus.connection == ConnectionStatus.DISCONNECTED && reconnectionAttempts <= MaxReconnectAttempts {
	
	timerReconnect -= dtime/60;
	if (timerReconnect < 0) {
		show_debug_message($"Attempting reconnection {reconnectionAttempts} ...");
		account_server_attempt_connection();
	}
	
}

if ClientStatus.connection == ConnectionStatus.CONNECTED {

	if alreadyConnected {

		if (timeSinceLastHeartbeat > EventTimeoutTime && !lastHeartbeatConfirmed) {
		
			lostConnectionMessage = queue_loading_message("Lost connection to the server. Attempting to reconnect");
			ClientStatus.connection = ConnectionStatus.DISCONNECTED;
			reconnectionAttempts = 0;
		
		} else {
		
			if is_struct(lostConnectionMessage) lostConnectionMessage.close();
			lostConnectionMessage = -1;
		
		}
		
		if (timeSinceLastHeartbeat > HeartbeatInterval && lastHeartbeatConfirmed) {
		
			lastHeartbeatConfirmed = false;
			timeSinceLastHeartbeat = 0;
			account_server_send_message("client.heartbeat", {});
		
		}
		
	}

}

timeSinceLastHeartbeat += dtime/60;

inQueue = struct_get_key_failsafe(UserData, "party.inQueue") ?? false;