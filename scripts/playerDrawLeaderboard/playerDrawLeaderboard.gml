function playerDrawLeaderboard(width, height){

	if leaderboard_blend > 0.01 {
		
		var leaderboardMyTeam = [{
			me: true,
			dead: state == PlayerState.DEAD,
			respawn_time: ceil(respawn_time),
			sprite: char.circle,
			name,
			kills,
			deaths,
			assists,
			gem_plants,
			ping: global.ping
		}];
		
		var leaderboardOtherTeam = [];
		
		for(var i = 0; i < instance_number(obj_player_other); i++) {
			var otherPlayer = instance_find(obj_player_other, i);
			var infoObject = {
				me: false,
				dead: otherPlayer.state == PlayerState.DEAD,
				respawn_time: ceil(otherPlayer.respawn_time),
				sprite: otherPlayer.char.circle,
				name: otherPlayer.name,
				kills: otherPlayer.kills,
				deaths: otherPlayer.deaths,
				assists: otherPlayer.assists,
				gem_plants: otherPlayer.gem_plants,
				ping: otherPlayer.ping
			}
			if (otherPlayer.team == team) {
				array_push(leaderboardMyTeam, infoObject);
			} else {
				array_push(leaderboardOtherTeam, infoObject);
			}
		}
		
		array_sort(leaderboardMyTeam, leaderboard_sorting_function);
		array_sort(leaderboardOtherTeam, leaderboard_sorting_function);
		
		draw_set_alpha(leaderboard_blend);
		draw_sprite_ext(HUD_LeaderboardItem, 4, width/2, height/2 - 19, 1, 1, 0, c_white, leaderboard_blend * 0.3);
		draw_text_transformed_shadowed(width/2, height/2, "VS", 0.8, 0.8, 0);
		
		var myTeamCount = array_length(leaderboardMyTeam), otherTeamCount = array_length(leaderboardOtherTeam);
		
		var yy = height/2 - 40 - myTeamCount * 36;
		draw_set_valign(fa_bottom);
		draw_set_halign(fa_left);
		
		var sc = 0.7;
		draw_sprite_ext(HUD_LeaderboardItem, 3, width/2, yy - 38, 1, 1, 0, c_white, leaderboard_blend * 0.5);
		draw_text_transformed_shadowed(width/2 - 300, yy - 4, "USERNAME", sc, sc, 0);
		draw_set_halign(fa_center);
		draw_text_transformed_shadowed(width/2 + 24, yy - 4, "K", sc, sc, 0);
		draw_text_transformed_shadowed(width/2 + 24 + 48, yy -4, "D", sc, sc, 0);
		draw_text_transformed_shadowed(width/2 + 24 + 48 + 48, yy - 4, "A", sc, sc, 0);
		draw_set_halign(fa_center);
		draw_text_transformed_shadowed(width/2 + 28 + 48 + 48 + 70, yy - 4, "GEM PLANTS", sc, sc, 0);
		draw_text_transformed_shadowed(width/2 + 28 + 48 + 48 + 100 + 102, yy - 4, "PING", sc, sc, 0);
		
		draw_set_valign(fa_middle);
		sc = 0.9;
		
		for(var i = 0; i < myTeamCount; i++) {
			draw_set_halign(fa_left);
			var playerObject = leaderboardMyTeam[i];
			draw_sprite_ext(HUD_LeaderboardItem, playerObject.me ? 0 : 1, width/2, yy, 1, 1, 0, c_white, leaderboard_blend);
			draw_sprite_ext(playerObject.sprite, 0, width/2 - 328, yy + 18, 35/256, 35/256, 0, playerObject.dead ? c_red : c_white, leaderboard_blend * (playerObject.dead ? 0.8 : 1));
			draw_text_transformed(width/2 - 300, yy + 18, playerObject.name, sc, sc, 0);
			draw_set_halign(fa_center);
			if playerObject.dead draw_text_transformed(width/2 - 328, yy + 18, playerObject.respawn_time, sc, sc, 0);
			draw_text_transformed(width/2 + 24, yy + 18, playerObject.kills, sc, sc, 0);
			draw_text_transformed(width/2 + 24 + 48, yy + 18, playerObject.deaths, sc, sc, 0);
			draw_text_transformed(width/2 + 24 + 48 + 48, yy + 18, playerObject.assists, sc, sc, 0);
			draw_set_halign(fa_right);
			draw_text_transformed(width/2 + 24 + 48 + 48 + 100, yy + 18, playerObject.gem_plants, sc, sc, 0);
			draw_text_transformed(width/2 + 24 + 48 + 48 + 100 + 102, yy + 18, playerObject.ping, sc, sc, 0);
			yy += 36;
		}
		
		yy = height/2 + 40;
		for(var i = 0; i < otherTeamCount; i++) {
			draw_set_halign(fa_left);
			var playerObject = leaderboardOtherTeam[i];
			draw_sprite_ext(HUD_LeaderboardItem, 2, width/2, yy, 1, 1, 0, c_white, leaderboard_blend);
			draw_sprite_ext(playerObject.sprite, 0, width/2 - 328, yy + 18, 35/256, 35/256, 0, playerObject.dead ? c_red : c_white, leaderboard_blend * (playerObject.dead ? 0.8 : 1));
			draw_text_transformed(width/2 - 300, yy + 18, playerObject.name, sc, sc, 0);
			draw_set_halign(fa_center);
			if playerObject.dead draw_text_transformed(width/2 - 328, yy + 18, playerObject.respawn_time, sc, sc, 0);
			draw_text_transformed(width/2 + 24, yy + 18, playerObject.kills, sc, sc, 0);
			draw_text_transformed(width/2 + 24 + 48, yy + 18, playerObject.deaths, sc, sc, 0);
			draw_text_transformed(width/2 + 24 + 48 + 48, yy + 18, playerObject.assists, sc, sc, 0);
			draw_set_halign(fa_right);
			draw_text_transformed(width/2 + 24 + 48 + 48 + 100, yy + 18, playerObject.gem_plants, sc, sc, 0);
			draw_text_transformed(width/2 + 24 + 48 + 48 + 100 + 102, yy + 18, playerObject.ping, sc, sc, 0);
			yy += 36;
		}
	
	}

}

function leaderboard_sorting_function(player1, player2) {
	return (player2.kills - player1.kills);
}