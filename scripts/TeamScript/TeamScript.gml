function is_an_enemy() {
	return obj_player.team != team;
}

function is_team_based_game() {
	return obj_gameplay.type == GameType.CASUAL || obj_gameplay.type == GameType.RANKED;
}