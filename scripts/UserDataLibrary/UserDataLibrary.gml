#macro UserData global.__user_data
#macro UserOtherData global.__users_cache
#macro UserParty global.__party

UserParty = {};
UserData = {};
UserOtherData = {};

function userdata_get_party() {
	return UserParty;	
}

function userdata_get_self() {
	return UserData;	
}

function userdata_other_loaded(userID) {

	return (UserOtherData[$ userID] != undefined);

}

function userdata_other_get(userID) {

	return UserOtherData[$ userID];

}

function userdata_load_prematch_data() {
	var teams = struct_get_key_failsafe(MatchPreMatchData, "players");
	if !is_array(teams) or array_length(teams) == 0 or !is_array(teams[0]) return;
	for(var i = 0; i < array_length(teams); i++) {
		var team = teams[i];
		for(var j = 0; j < array_length(team); j++) {
			var player = team[j];
			if (!userdata_other_loaded(player.userId)) {
				account_server_send_message("fetch.user", {id: player.userId});	
			}
		}
	}	
}