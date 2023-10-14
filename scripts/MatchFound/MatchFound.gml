#macro MatchPass global.__match_pass
#macro MatchPlayerAccess global.__match_access
#macro MatchPreMatchData global.__match_prematch_data

MatchPass = 0x0;
MatchPlayerAccess = 0x0;
MatchPreMatchData = {};

function MatchFound() {
	
	static process = function(content) {
		
		MatchPass = content.match.pass ?? 0;
		MatchPlayerAccess = content.access ?? 0;
		MatchPreMatchData = content.match;
		
		if (content.display) queue_kinded_message("foundMatch", true);
		else {
			//rejoin game	
		}
		
	}
	
	return process;

}