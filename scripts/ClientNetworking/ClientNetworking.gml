#macro ClientStatus global.__client_status
#macro AccountServerIP "127.0.0.1"
#macro AccountServerPort 1840
#macro EventTimeoutTime 7
#macro MaxReconnectAttempts 8
#macro HeartbeatInterval 5
#macro AccessToken global.__access_token

AccessToken = "";

ClientStatus = {
	connection: ConnectionStatus.DISCONNECTED,
	authentication: AuthenticationStatus.UNAUTHORIZED
}

enum ConnectionStatus {

	DISCONNECTED,
	CONNECTING,
	CONNECTED,
	ERROR

}

enum AuthenticationStatus {
	
	UNAUTHORIZED,
	AUTHORIZED,
	AUTHENTICATED

}

function ServerRequestConstructor(event, content) constructor {

	self.event = event;
	self.content = content;
	
	static getData = function(){
		var json = {event: self.event, content: self.content};
		var msg = json_stringify(json);
		show_debug_message($"Sending: {msg}");
		return msg + "\0";
	}


}


function account_server_attempt_connection(){

	show_debug_message("Connecting to account server...")
	network_connect_raw_async(objClientNetwork.accountServer, AccountServerIP, AccountServerPort);
	ClientStatus.connection = ConnectionStatus.CONNECTING;
	objClientNetwork.reconnectionAttempts++;

}

function account_server_send_message(event, content, onReply = NULLFUNC, timeout = NULLFUNC){

	var msg = (new ServerRequestConstructor(event, content)).getData();
	array_push(EventWaitQueue, {event, time: current_time, timeout, onReply});
	var buffer = buffer_create(1, buffer_grow, 1);
	buffer_seek(buffer, buffer_seek_start, 0);
	var s = buffer_write(buffer, buffer_text, msg);
	if (s == -1) show_debug_message($"Couldn't write {msg} into a buffer.");
	network_send_raw(objClientNetwork.accountServer, buffer, buffer_get_size(buffer));
	buffer_delete(buffer);

}