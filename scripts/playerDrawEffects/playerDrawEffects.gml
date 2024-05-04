function playerDrawEffects(width, height){

	draw_set_font(font_game)
	draw_set_valign(fa_middle)
	draw_set_halign(fa_center)
	draw_set_color(c_white)
	var start_buffs = height - 300, start_nerfs = 40, spw = sprite_get_width(HUD_DEF), sph = sprite_get_height(HUD_DEF);
	
	var g_alpha = (1 - preroundBlend) * HUDalpha;
		
	for(var i = 0; i < array_length(playerEffects); i++) {
		
		var currentEffect = playerEffects[i], effectType = currentEffect.type, percent = currentEffect.elapsed/currentEffect.duration;
		var effectData = global.effect_data[effectType];
		var name = effectData[0], backColor = effectData[1], textColor = effectData[2], isBuff = effectData[3];
		
		var xx = width - 110, yy = isBuff ? start_buffs : start_nerfs;
		draw_sprite_ext(HUD_DEF, 0, xx, yy, 1.2, 1.2, 0, backColor, 0.5 * g_alpha);
		draw_sprite_part_ext(HUD_DEF, 0, 0, 0, spw * percent, sph, xx - spw * 1.2/2, yy - sph * 1.2/2, 1.2, 1.2, backColor, 0.5 * g_alpha);
		draw_set_color(textColor);
		draw_set_alpha(g_alpha);
		draw_text_transformed(xx - 14, yy, name, 1.1, 1.1, 0);
		draw_sprite_ext(HUD_EffectIcons, effectType, xx + 1.2 * 155/2 - 28, yy, 0.8, 0.8, 0, textColor, 0.9 * g_alpha);
		
		if (isBuff) start_buffs -= 40 else start_nerfs += 40;
		
	}
	
	draw_set_color(c_white);
	draw_set_alpha(1);

}