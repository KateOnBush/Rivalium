/// @description Insert description here
// You can write your code in this editor

if (currentAbility != lastAbility) {
	opacity = dtlerp(opacity, 0, 0.2);
	if (opacity < 0.01) {
		lastAbility = currentAbility;
	}
} else {
	opacity = dtlerp(opacity, 1, 0.2);
}