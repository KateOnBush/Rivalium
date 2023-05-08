function playerProcessAbilities(){

	if (array_length(base) != array_length(char.base)) {
		spd = char.speed;
		sprite = char.sprite
		offset = [sprite_get_xoffset(sprite),sprite_get_yoffset(sprite)]
		currentframe = animation_get_frame(char.anims.animation_idle, 0);
		base = char.base;
	}

	char.abilities.basic_attack.step();
	char.abilities.ability1.step();
	char.abilities.ability2.step();
	char.abilities.ultimate.step();

	casting = 
	(char.abilities.basic_attack.iscasting && char.abilities.basic_attack.cast_block) || 
	(char.abilities.ability1.iscasting && char.abilities.ability1.cast_block) || 
	(char.abilities.ability2.iscasting && char.abilities.ability2.cast_block) || 
	(char.abilities.ultimate.iscasting && char.abilities.ultimate.cast_block);

}