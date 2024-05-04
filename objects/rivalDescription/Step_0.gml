/// @description Insert description here
// You can write your code in this editor

if (playerOwnCard.loadedCharacter) currentName = playerOwnCard.char.name;

if (currentName != lastName) {
	opacity = dtlerp(opacity, 1, 0.1);
	if (opacity > 0.99) {
		lastName = currentName;
	}
} else {
	opacity = 0;
}