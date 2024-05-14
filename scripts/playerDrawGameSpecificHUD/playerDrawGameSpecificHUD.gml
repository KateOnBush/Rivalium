function playerDrawGameSpecificHUD(width, height){

	if (obj_gameplay.type == GameType.CASUAL) {

		draw_set_alpha(HUDalpha);

		draw_sprite(HUD_Round, 0, width/2, 0);

		draw_set_font(font_game)
		draw_set_valign(fa_middle)
		draw_set_halign(fa_center)
		draw_set_color(c_white)

		var len = string_length(timer_text), sp = 18;
		for(var i = 1; i <= len; i++) {
			draw_text_transformed(width/2 - len * (sp/2) + (i - 0.5) * sp, 24, string_char_at(timer_text, i), 1, 1, 0);
		}

		draw_set_halign(fa_center)
		draw_text_transformed(width/2, 63, timer_desc, 0.45, 0.45, 0);

		draw_text_transformed(width/2 - 150, 18, obj_gameplay.currentRound, 0.75, 0.75, 0)
		draw_text_transformed(width/2 - 156 + 16, 48, "ROUND", 0.3, 0.3, 0)

		draw_text_transformed(width/2 + 150, 18, "15", 0.75, 0.75, 0)
		draw_text_transformed(width/2 + 156 - 16, 48, "TARGET", 0.3, 0.3, 0)

		var defending = (obj_gameplay.defendingTeam == team);
		var color = defending ? #095f9c : #9c1f09;
		draw_sprite_ext(HUD_DEF, 0, width/2, 120, 1.3, 1.45, 0, color, 0.6 * HUDalpha)
		draw_text_transformed(width/2, 120, defending ? "DEFENDING" : "ATTACKING", 0.7, 0.7, 0);
		
		if (gem_holder_blend > 0.01) {
			draw_sprite_ext(HUD_DEF, 0, width/2, height - 128, 1.1, 1.3, 0, #8100b8, 0.6 * HUDalpha * gem_holder_blend);
			draw_set_alpha(gem_holder_blend * HUDalpha);
			draw_text_transformed(width/2, height - 128, "GEM HOLDER", 0.6, 0.6, 0);
		}
		draw_set_alpha(HUDalpha)
		
		draw_set_color(c_white);

		draw_text_transformed(width/2 - 234, 26, (team == 0) ? obj_gameplay.firstTeamScore : obj_gameplay.secondTeamScore, 1, 1, 0);
		draw_text_transformed(width/2 + 234, 26, (team == 0) ? obj_gameplay.secondTeamScore : obj_gameplay.firstTeamScore, 1, 1, 0);

	}
	
	if (dead_blend > 0.01) {
		draw_sprite_ext(HUD_DEF, 0, width/2, height - 160, 1.5, 1.3, 0, #ba0000, 0.6 * HUDalpha * dead_blend);
		draw_set_alpha(dead_blend * HUDalpha);
		draw_text_transformed(width/2, height - 160, "RESPAWNING IN " + string(ceil(respawn_time)), 0.6, 0.6, 0);
		
		draw_sprite_ext(HUD_DEF, 0, width/2, height - 220, 2, 1.3, 0, #ba0000, 0.6 * HUDalpha * dead_blend);
		draw_set_alpha(dead_blend * HUDalpha);
		draw_text_transformed(width/2, height - 220, "KILLED BY " + string(killername), 0.6, 0.6, 0);
	}

}