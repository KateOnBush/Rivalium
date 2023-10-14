function ClientLogin(){

	static process = function(status, content){
		
		switchLoginButton.state = buttonState.ON;
		loginButton.reset();
				
		if (status == "ok") {
			loginAccessInput.state = InputState.CORRECT;
			loginPasswordInput.state = InputState.CORRECT;
			loginPageManager.loginSuccessful = true;
			AccessToken = content.accessToken;
			if (content[$ "autologinToken"] != undefined) {
				if (file_exists("al.key")) file_delete("al.key");
				var f = file_text_open_write("al.key");
				file_text_write_string(f, content.autologinToken);
				file_text_close(f);
			}
		} else {
			var error = content.error;
			if (error = "access.incorrect") && instance_exists(loginAccessInput){
				loginAccessInput.state = InputState.INCORRECT;
				loginAccessText.state = TextState.ERROR;
				loginAccessText.text = "Incorrect username/email"
			} else if (error = "password.incorrect") && instance_exists(loginPasswordInput){
				loginPasswordInput.state = InputState.INCORRECT;
				loginPasswordText.state = TextState.ERROR;
				loginPasswordText.text = "Incorrect password"
			}
		}
		
	}
	
	return process;

}