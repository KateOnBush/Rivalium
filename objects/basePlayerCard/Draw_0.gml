/// @description Insert description here
// You can write your code in this edito

var sc = image_xscale/1.1;

//draw_sprite_ext(playerCardBackground, 0, x, y, image_xscale, image_yscale, 0, c_white, image_alpha * global_alpha);

draw_sprite_ext(playerPodiumSprite, 0, x, y, sc, sc, 0, c_white, global_alpha);

playerDrawSimple(x, y - 36 * sc, sc * 1.2, global_alpha);

draw_set_color(COLOR_LIGHT);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_alpha(.8 * global_alpha);

var username = struct_get_key_failsafe(user, "username");
if (!is_undefined(username)) {
	
	draw_set_alpha(details_alpha * global_alpha);
	
	var skillTier = struct_get_key_failsafe(user, "skill.tier") ?? "N/A";
	var rankTier = struct_get_key_failsafe(user, "rank.tier") ?? 0;
	var rankRating = struct_get_key_failsafe(user, "rank.rating") ?? 0;
	var iconIndex = struct_get_key_failsafe(user, "wardrobe.selectedIcon") ?? 0;
	var rankName;
	if (rankTier > 0) rankName = $"{rank_number_to_name(rankTier)}: {rank_division(rankTier, rankRating)}";
	else rankName = rank_number_to_name(rankTier);
	draw_text_transformed(x + 12, y - 105 * sc, username, 0.5, 0.5, details_alpha * global_alpha);
	
	//draw icon
	draw_sprite_ext(rankIconSprite, rankTier, x - string_width(username)/4 - 8, y - 105 * sc, .5, .5, 0, c_white, details_alpha * global_alpha);
	
	var _w = string_width($"ST {skillTier} RT {rankName}") * .32,
		_s = string_width(" ") * .32,
		_ss = string_width("ST") * .32 ,
		_wst = string_width(string(skillTier)) * .32,
		_wrt = string_width(string(rankTier)) * .32;
	var _ic = _ss/32;
	draw_set_halign(fa_left);
	
	draw_sprite_ext(skillTierIconSprite, 0, x - _w / 2 + _ss/2, y - 90 * sc, _ic, _ic, 0, c_white, details_alpha * global_alpha)
	draw_text_transformed(x - _w / 2 + _ss + _s, y - 90 * sc, skillTier, .32, .32, 0);
	
	draw_sprite_ext(rankTierIconSprite, 0, x - _w / 2 + _ss + _s + _wst + _s + _ss/2, y - 90 * sc, _ic, _ic, 0, c_white, details_alpha * global_alpha)
	draw_text_transformed(x - _w / 2 + _ss + _s + _wst + _s + _ss + _s, y - 90 * sc, rankName, .32, .32, 0);
	
	draw_sprite_ext(defaultIconBorder, 0, x, y - (138 - inWardrobeAlpha * 20) * sc, 1.2 + 0.8 * inWardrobeAlpha, 1.2 + 0.8 * inWardrobeAlpha, 0, c_white, global_alpha);
	draw_sprite_ext(IconList[iconIndex], 0, x, y - (138 - inWardrobeAlpha * 20) * sc, 1.2 + 0.8 * inWardrobeAlpha, 1.2 + 0.8 * inWardrobeAlpha, 0, c_white, global_alpha);
	
	draw_set_alpha(1);

}


