function ClientSignup(){

	static process = function(status, content){
		
		switchLoginButton.state = buttonState.ON;
		signupButton.reset()
		
		if (status == "ok") {
			signupText.text = "Account created! You can now log in.";
			signupText.state = TextState.SUCCESS;
		} else {
			var error = content.error;
			signupText.state = TextState.ERROR;
			switch(error) {
			
				case "bad.username": {
					signupText.text = UsernameRequirementMessage;
					signupUsernameInput.state = InputState.INCORRECT;
					break;
				}
				
				case "bad.email": {
					signupText.text = EmailRequirementMessage;
					signupEmailInput.state = InputState.INCORRECT;
					break;
				}
				
				case "bad.password": {
					signupText.text = PasswordRequirementMessage;
					signupPasswordInput.state = InputState.INCORRECT;
					break;	
				}
				
				case "bad.confirm": {
					signupText.text = PasswordConfirmRequirementMessage;
					signupPasswordConfirmInput.state = InputState.INCORRECT;
					break;	
				}
				
				case "bad.accept": {
					signupText.text = AcceptTOSRequirementMessage;
					break;
				}
				
				case "username.taken": {
					signupText.text = "Username already taken.";
					break;
				}
				
				default: {
					queue_normal_message("An unexpected error occured, please try again.", "OK", false);
					break;
				}
			
			}
						
		}
		
	}
	
	return process;

}