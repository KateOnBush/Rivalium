/// @description Insert description here
// You can write your code in this editor

ani += dtime/60;

var charid = struct_get_key_failsafe(user, "wardrobe.selectedChar");

if (charid != undefined && !loadedCharacter) {
	currentCharId = charid;
	loadedCharacter = true;
	setup_character(charid);
	show_debug_message($"Loaded character {charid}");
}

if (loadedCharacter) {

	currentframe = animation_get_frame(char.anims.animation_idle, 0.4*ani mod 1);
	playerCalculateFrame(0);

}

if (charid != currentCharId) {
	loadedCharacter = false;
}

