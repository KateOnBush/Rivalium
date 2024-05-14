/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if keyboard_check_released(vk_enter) {
	
	if instance_exists(addFriendsView) {
		addFriendsView.search(content);	
	}
	
}