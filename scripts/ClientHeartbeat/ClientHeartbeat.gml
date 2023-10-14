function ClientHeartbeat(){

	static process = function(status, content){
		
		if (status == "ok") {
		
			objClientNetwork.lastHeartbeatConfirmed = true;
		
		}
		
	}
	
	return process;

}