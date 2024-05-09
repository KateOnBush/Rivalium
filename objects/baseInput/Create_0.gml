/// @description Insert description here
// You can write your code in this editor

event_inherited();

content = "";
displayText = "";
password = false

placeholder = "";
placeholderBlend = 0;

selected = false;
selectedBlend = 0;

baseSize = .85;
size = 0.5;

totalSize = baseSize;

backspaceHoldTime = 0;
backspaceThreshold = 0.6;
backspaceInterval = .04;

cursorPosition = 1;
cursorCooldown = 0;
cursorInterval = 0.5;

holdTime = 0;
holdTimeThreshold = 0.05;
holdStartCursor = 0;
holdStartedInside = false;

hasSelection = true;
selectionStart = 1;
selectionEnd = 1;

pChar = "*";

textOffset = 0;

state = InputState.NORMAL; //0 = normal, 1 = correct, 2 = incorrect
stateTimer = 0;
stateThreshold = 1.6;
correctBlend = 0;
incorrectBlend = 0;

finalXOff = 0;
shakeTheta = 0;

image_speed = 0;

displaySurface = -1;

mouseIsInside = false;

definitionScale = 1;

nine = 8;
ww = sprite_width - nine*2;
hh = sprite_height - nine*2;

function updateCursor() {
	var distanceFromStart = (mouse_x - (x - ww/2) + textOffset);
	draw_set_font(mainFont);
	var dist = 0;
	var char = 1;
	while(dist < distanceFromStart && char <= string_length(content)) {
		dist += string_width(string_char_at(displayText, char)) * totalSize;
		char++;
	}
	cursorPosition = char - 1;	
}