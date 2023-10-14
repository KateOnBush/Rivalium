function ClientVersion() {
	
	static process = function(status, content) {
		
		if (status == "ok") {
			ClientStatus.authentication = AuthenticationStatus.AUTHORIZED;
			if instance_exists(loginButton) {
				loginButton.reset();
			}
			if instance_exists(signupButton) {
				signupButton.reset();
			}
			if (file_exists("al.key")) && room == roomLogin {
				var f = file_text_open_read("al.key");
				var autologinToken = file_text_read_string(f);
				file_text_close(f);
				
				queue_loading_message("Logging in");
				account_server_send_message("client.autologin", {token: autologinToken}, close_current_message, function(){
					close_current_message();
					queue_normal_message("Auto-login timed out, please log in again.", "OK", false);
				});
				
			}
		} else {
			queue_normal_message("Update is waiting for you bro!", "GOT IT!", true);
		}
		
	}
	
	return process;

}