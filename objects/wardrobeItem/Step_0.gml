/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if !initialized {
	
	initialized = true;

	switch(type) {
		case WardrobePages.RIVAL: {
			var character = Characters[itemId]();
			icon = character.circle;
			iconSize = 3;
			onClick = function() {
				global.wardrobeLoadingItem = id;
				account_server_send_message("wardrobe.change.char", {target: itemId}, function(){
					global.wardrobeLoadingItem = noone;
				}, function() {
					global.wardrobeLoadingItem = noone;
					queue_message("Something went wrong. Try again.", false);
				});
			}
			break;
		}
		case WardrobePages.AVATAR: {
			icon = IconList[itemId];
			iconSize = 3;
			break;
		}
	}
	
}

if (global.wardrobeLoadingItem != noone) {
	state = buttonState.UNAVAILABLE;
	if (global.wardrobeLoadingItem == id) {
		state = buttonState.ON;
	}
} else {
	state = buttonState.ON;
}

var a = 1;
switch(type) {
	case WardrobePages.RIVAL: {
		if (playerOwnCard.loadedCharacter and playerOwnCard.char.id == (itemId + 1)) {
			a = 0.2;
		}
		break;
	}
}
alpha = dtlerp(alpha, a, 0.1);