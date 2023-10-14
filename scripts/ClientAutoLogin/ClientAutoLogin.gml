function ClientAutoLogin(){

	static process = function(status, content) {
		
		if (status == "ok") {
		
			loginPageManager.loginSuccessful = true;
		
		} else {
		
			file_delete("al.key");
			queue_normal_message("Could not log you in automatically. Please log in again.", "OK", false);
		
		}
		
	}
	
	return process;

}