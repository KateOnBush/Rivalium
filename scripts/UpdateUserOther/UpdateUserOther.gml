function UpdateUserOther() {
	
	static process = function(content) {
		
		UserOtherData[$ content.id] = content;
		
	}
	
	return process;

}