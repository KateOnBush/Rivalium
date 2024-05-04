/// @description Insert description here
// You can write your code in this editor

if (playerOwnCard.loadedCharacter) {
	switch(abilityId){
		case 1:
			currentCircle = playerOwnCard.char.abilities.ability1.sprite;
			break;
		case 2:
			currentCircle = playerOwnCard.char.abilities.ability2.sprite;
			break;
		case 3:
			currentCircle = playerOwnCard.char.abilities.ultimate.sprite;
			break;
		default:
			currentCircle = playerOwnCard.char.abilities.basic_attack.sprite;
			break;
	}
}

if (currentCircle != lastCircle) {
	opacity = dtlerp(opacity, 1, 0.1);
	if (opacity > 0.99) {
		lastCircle = currentCircle;
	}
} else {
	opacity = 0;
}

if is_hovering() {
	rivalCurrentAbilityDesc.currentAbility = abilityId;
}

selected = dtlerp(selected, (rivalCurrentAbilityDesc.currentAbility == abilityId), 0.2);