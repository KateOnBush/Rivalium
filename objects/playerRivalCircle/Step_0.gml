/// @description Insert description here
// You can write your code in this editor

if (playerOwnCard.loadedCharacter) currentCircle = playerOwnCard.char.circle;

if (currentCircle != lastCircle) {
	opacity = dtlerp(opacity, 1, 0.1);
	if (opacity > 0.99) {
		lastCircle = currentCircle;
	}
} else {
	opacity = 0;
}