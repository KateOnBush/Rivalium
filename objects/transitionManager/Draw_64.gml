/// @description Insert description here
// You can write your code in this editor

var ww = display_get_gui_width(), hh = display_get_gui_height();

var logoPos = lerp(lerp(hh * 1.5, hh/2, transitionProgress), hh * 0.08, gameLoadingBlend);
var logoSize = lerp(lerp(0.7, 0.85, loadingProgress), 0.3, gameLoadingBlend);
var loadingPos = lerp(lerp(hh * 1.5, hh * .75, transitionProgress), hh * 0.95, gameLoadingBlend);

draw_set_alpha(transitionProgress);

draw_set_color(#1E2266)
draw_rectangle(0, 0, ww, hh, false);
draw_sprite_stretched_ext(splashLoading, 0, 0, 0, ww, hh, c_white, 0.1 * transitionProgress);

draw_sprite_ext(logoSprite, 0, 
	ww/2, 
	logoPos, 
	logoSize, logoSize,
	0, c_white, 
	transitionProgress * transitionProgress);

draw_set_font(mainFont);
draw_set_color(c_white)
draw_set_alpha(loadingProgress);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

var textScale = lerp(2.5, 1.2, gameLoadingBlend)/2;
loadingW = dtlerp(loadingW, string_width(displayLoadingText) * textScale, 0.4);
var loadingScale = 1.5 * textScale/2.5;
var spriteW = sprite_get_width(loadingSymbol) * loadingScale;

draw_sprite_ext(loadingSymbol, 0, ww/2 - loadingW / 2 - 12, loadingPos, loadingScale, loadingScale, angle, c_white, loadingProgress * loadingBlend);
draw_text_transformed(ww/2 + spriteW / 2 + 12, loadingPos, displayLoadingText, textScale, textScale, 0);
	

	

if gameLoadingBlend > 0.01 {

	var match = MatchPreMatchData;
	var teams = match.players;

	var nTeams = array_length(teams);

	var lx = ww * 0.2, hx = ww * .8,
	ly = hh * 0.2, hy = hh * .8;

	var a = transitionProgress * loadingBlend * gameLoadingBlend;
	a = a * a * a;

	draw_set_alpha(a);

	draw_set_font(secondaryFont);

	for(var t = 0; t < nTeams; t++) {

		var team = teams[t];
		var teamSize = array_length(team);
		var dy = ly + ((t+.5)/nTeams) * (hy - ly);
	
		for(var p = 0; p < teamSize; p++) {
	
			var player = team[p];
			var dataLoaded = userdata_other_loaded(player.userId);
			var data;
			if (player.userId == UserData.id) {
				dataLoaded = true;
				data = UserData;
			} else {
				data = dataLoaded ? userdata_other_get(player.userId) : {};
			}
	
			var dx = lx + ((p+.5)/teamSize) * (hx - lx);
		
			draw_sprite(playerLoadingCard, 0, dx, dy);
		
			if dataLoaded {
		
				draw_sprite(defaultIconSprite, 0, dx, dy + 56);
				draw_sprite(defaultIconBorder, 0, dx, dy + 56);
			
				draw_set_valign(fa_middle);
				draw_set_halign(fa_center);
				draw_set_color(c_white)
				draw_text_transformed(dx, dy + dh/2 - 16, data.username, .5, .5, 0);
			
				draw_text_transformed(dx - dw/4 + 2, dy + dh/2 - 22, data.skill.tier, .5, .5, 0);
				draw_sprite_ext(skillTierIconSprite, 0, dx - dw/4 - 16, dy + dh/2 - 22, .5, .5, 0, c_white, a);
			
				draw_sprite_ext(rankIconSprite, data.rank.tier, dx + dh/4, dy + dh/2 - 22, .7, .7, 0, c_white, a);
			
			} else {
		
				draw_sprite_ext(loadingSymbol, 0, dx, dy - 20, 0.3, 0.3, angle, COLOR_LIGHT, a);
		
			}
		
		}

	}
	
}

draw_set_alpha(1);