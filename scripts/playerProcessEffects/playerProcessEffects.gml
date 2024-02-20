function playerProcessEffects(){
	
	invisible = false;

	static efnms = ["Healing", "Bleeding", "Acceleration", "Slow", "Vulnerability", "Invisibility"];

	playerEffects = process_effects(playerEffects);

	var lerpspd = 1;
	effects_str = "";
	for(var t = 0; t < array_length(playerEffects); t++){
	
		var l = playerEffects[t];
		if (l.type == EFFECT.SWIFTNESS) lerpspd *= l.data.multiplier;
		if (l.type == EFFECT.SLOWNESS) lerpspd /= l.data.multiplier;
		if (l.type == EFFECT.INVISIBILITY) invisible = true;
	
	}


	for(var s = 0; s < array_length(filters); s++){

		if filters[s].removing filters[s].alpha = dtlerp(filters[s].alpha, 0, 0.1);
		else filters[s].alpha = dtlerp(filters[s].alpha, 1, 0.1);

		if filters[s].alpha < 0.05 and filters[s].removing array_delete(filters, s, 1);

	}
	
	spdboost = dtlerp(spdboost, lerpspd, 0.2);

}