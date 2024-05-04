/// @description Insert description here
// You can write your code in this editor

draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_font(mainFont);
draw_set_color(COLOR_DARK);
draw_set_alpha(1);

if (playerOwnCard.loadedCharacter) {

	var abilityName = "", abilityDesc = "";
	if lastAbility != -1 {
		abilityName = playerOwnCard.char.ability_info[lastAbility].name;
		abilityDesc = playerOwnCard.char.ability_info[lastAbility].desc;
	}
	switch (lastAbility) {
		default:
			abilityName = "HOVER AN ABILITY FOR DETAILS";
			break;
		case 0:
			abilityName = "BASIC ATTACK - " + abilityName;
			break;
		case 1:
			abilityName = "SIGNATURE ABILITY I - " + abilityName;
			break;
		case 2:
			abilityName = "SIGNATURE ABILITY II - " + abilityName;
			break;
		case 3:
			abilityName = "ULTIMATE - " + abilityName;
			break;
	}
	
	draw_set_alpha(opacity)
	draw_text_transformed(x, y, string_upper(abilityName), 0.9, 0.9, 0);
	draw_set_font(font_game)
	draw_set_alpha(0.8 * opacity);
	draw_text_ext_transformed(x, y + 18, abilityDesc, 18, 600, 0.75, 0.75, 0);

}



