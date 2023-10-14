/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

iconSprite = clientIcons;
iconIndex = 0;

z = 1;
followUI = true;

onClick = function() {

	if !isMessageOpen or currentMessage.id != "close" {
		var m = queue_question_message("Are you sure you want to close Rivalium?", "YES", "NO", game_end, close_current_message, true);
		m.id = "close";
	}
}
