/// @description Insert description here
// You can write your code in this editor

nine = 8;
ww = sprite_width - nine*2;
hh = sprite_height - nine*2;

totalSize = dtlerp(totalSize, size * baseSize, 0.3);

if is_between(bbox_left, mouse_x, bbox_right, true) &&
	is_between(bbox_top, mouse_y, bbox_bottom, true) {

	if (!mouseIsInside) {
		window_set_cursor(cr_beam);
		mouseIsInside = true;
	}

	if mouse_check_button_pressed(mb_left){
		keyboard_string = "";
		if (selected) {
			updateCursor();
			holdStartCursor = cursorPosition;
		}
		global.selectedInput = id;
		selected = true;
		holdStartedInside = true;
	}

} else {
	
	if mouse_check_button_pressed(mb_left){
		selected = false;	
	}
	
	holdTime = 0;
	
	if (mouseIsInside) {
		window_set_cursor(cr_default);
		mouseIsInside = false;	
	}

}

if mouse_check_button_released(mb_left) && holdStartedInside {
	if (holdTime < holdTimeThreshold) { 
		hasSelection = false;
	}
	holdTime = 0;
	holdStartedInside = false;
} else if mouse_check_button(mb_left) && holdStartedInside{
	cursorCooldown = 0;
	holdTime += dtime/60;
	if (holdTime > holdTimeThreshold) {
		var oldPosition = holdStartCursor;
		updateCursor()
		hasSelection = true;
		if cursorPosition > oldPosition {
			selectionStart = oldPosition;
			selectionEnd = cursorPosition;
		} else {
			selectionStart = cursorPosition;
			selectionEnd = oldPosition;
		}
	}
}

selectedBlend = dtlerp(selectedBlend, selected, .1);
correctBlend = dtlerp(correctBlend, state == InputState.CORRECT, .1);
incorrectBlend = dtlerp(incorrectBlend, state == InputState.INCORRECT, .1);

if selected {
	
	if keyboard_check(vk_control) {
	
		if keyboard_check_pressed(ord("C")) && hasSelection {
			clipboard_set_text(string_copy(content, selectionStart + 1, selectionEnd - selectionStart));
		}
		
		if keyboard_check_pressed(ord("X")) && hasSelection {
			clipboard_set_text(string_copy(content, selectionStart + 1, selectionEnd - selectionStart));
			cursorPosition = selectionStart;
			content = string_delete(content, selectionStart + 1, selectionEnd - selectionStart);
			hasSelection = false;
		}
		
		if keyboard_check_pressed(ord("V")) && clipboard_has_text() {
			var paste = clipboard_get_text();
			if (hasSelection) {
				cursorPosition = selectionStart;
				content = string_delete(content, selectionStart + 1, selectionEnd - selectionStart);
				hasSelection = false;	
			}
			content = string_insert(paste, content, cursorPosition + 1);
			cursorPosition += string_length(paste);
		}
		
		if keyboard_check_pressed(ord("A")) && string_length(content) > 0 {
			hasSelection = true;
			selectionStart = 1;
			selectionEnd = string_length(content);
		}
	
	}
	
	if keyboard_check_pressed(vk_backspace) {
		backspaceHoldTime = 0;
		if (hasSelection) {
			cursorPosition = selectionStart;
			content = string_delete(content, selectionStart + 1, selectionEnd - selectionStart);
			hasSelection = false;
		} else if (string_length(content) > 0) {
			content = string_delete(content, cursorPosition, 1);
			cursorPosition--;
		}
	} else if keyboard_check(vk_backspace) {
		backspaceHoldTime += dtime/60;
		if (backspaceHoldTime > backspaceThreshold + backspaceInterval) {
			if (string_length(content) > 0) content = string_delete(content, cursorPosition, 1);
			cursorPosition--;
			backspaceHoldTime -= backspaceInterval;
		}
	} else if keyboard_check_pressed(vk_anykey) && keyboard_string != "" {
		if (hasSelection) {
			cursorPosition = selectionStart;
			content = string_delete(content, selectionStart + 1, selectionEnd - selectionStart);
			hasSelection = false;
		}
		content = string_insert(keyboard_string, content, cursorPosition + 1);
		cursorCooldown = 0;
		cursorPosition++;
		keyboard_string = "";
	}
}

cursorPosition += keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
cursorPosition = clamp(cursorPosition, 0, string_length(content));

displayText = content;
if (password) displayText = string_repeat(pChar, string_length(content));

var dist = string_width(string_copy(displayText, 1, cursorPosition)) * totalSize + textOffset;
/*if (dist < 0) {
	textOffset -= dist;	
}
if (dist > ww) {
	textOffset += dist - ww;	
}*/

cursorCooldown += dtime/60;
if cursorCooldown >= 2 * cursorInterval cursorCooldown = 0;