enum input {

	keyboard,
	mouse

}



function Input(inputKey) constructor{

	self.inputid = inputKey;

}

function InputKeyboard(inputKey) : Input(inputKey) constructor{

	static check = function(){
	
		return keyboard_check(inputid);
	
	}
	
	static pressed = function(){
	
		return keyboard_check_pressed(inputid);
	
	}
	
	static released = function(){
	
		return keyboard_check_released(inputid);
	
	}
	
	name = key_to_name(inputid);
	
	shortname = key_to_short_name(inputid)
	
	draw = function(x, y){
	
		draw_text_transformed(x, y, shortname, 0.5, 0.5, 0);
	
	}

}

function InputMouse(inputKey) : Input(inputKey) constructor{

	static check = function(){
	
		return mouse_check_button(inputid);
	
	}
	
	static pressed = function(){
	
		return mouse_check_button_pressed(inputid);
	
	}
	
	static released = function(){
	
		return mouse_check_button_released(inputid);
	
	}
	
	name = mouse_to_name(inputid);
	sprind = mouse_to_ind(inputid);
	
	draw = function(x, y){
	
		draw_sprite(mouse_icon, sprind, x, y);
	
	}

}


function get_input(inputType, inputKey){

	if inputType == input.keyboard{
		
		return new InputKeyboard(inputKey);
		
	} else {
	
		return new InputMouse(inputKey);
		
	}

}

function mouse_to_name(key){

	switch(key){
	
		case mb_left: return "Mouse Left";
		case mb_right: return "Mouse Right";
		case mb_middle: return "Mouse Middle";
		case mb_side1: return "Mouse Side 1";
		case mb_side2: return "Mouse Side 2";
		default: return "Mouse Button";
	
	}

}

function mouse_to_ind(key){

	switch(key){
	
		case mb_left: return 1;
		case mb_right: return 2;
		case mb_middle: return 3;
		case mb_side1: return 4;
		case mb_side2: return 4;
		default: return 0;
	
	}

}


function key_to_name(key){

	if( key > 48 && key < 91 ) 
	{ return chr(key); }
	switch( key )
	{
	    case -1: return "No Key";
	    case 8: return "Backspace";
	    case 9: return "Tab";
	    case 13: return "Enter";
	    case 16: return "Shift";
	    case 17: return "Ctrl";
	    case 18: return "Alt";
	    case 19: return "Pause/Break";
	    case 20: return "CAPS";
	    case 27: return "Esc";
	    case 33: return "Page Up";
	    case 34: return "Page Down";
	    case 35: return "End";
	    case 36: return "Home";
	    case 37: return "Left Arrow";
	    case 38: return "Up Arrow";
	    case 39: return "Right Arrow";
	    case 40: return "Down Arrow";
	    case 45: return "Insert";
	    case 46: return "Delete";
	    case 96: return "Numpad 0";
	    case 97: return "Numpad 1";
	    case 98: return "Numpad 2";
	    case 99: return "Numpad 3";
	    case 100: return "Numpad 4";
	    case 101: return "Numpad 5";
	    case 102: return "Numpad 6";
	    case 103: return "Numpad 7";
	    case 104: return "Numpad 8";
	    case 105: return "Numpad 9";
	    case 106: return "Numpad *";
	    case 107: return "Numpad +";
	    case 109: return "Numpad -";
	    case 110: return "Numpad .";
	    case 111: return "Numpad /";
	    case 112: return "F1";
	    case 113: return "F2";
	    case 114: return "F3";
	    case 115: return "F4";
	    case 116: return "F5";
	    case 117: return "F6";
	    case 118: return "F7";
	    case 119: return "F8";
	    case 120: return "F9";
	    case 121: return "F10";
	    case 122: return "F11";
	    case 123: return "F12";
	    case 144: return "Num Lock";
	    case 145: return "Scroll Lock";
	    case 186: return ";";
	    case 187: return "=";
	    case 188: return ",";
	    case 189: return "-";
	    case 190: return ".";
	    case 191: return @"\";
	    case 192: return "`";
	    case 219: return "/";
	    case 220: return "[";
	    case 221: return "]";
	    case 222: return "'";
		default: return "Keyboard Key"
	}

}

function key_to_short_name(key){

	if( key > 48 && key < 91 ) 
	{ return chr(key); }
	switch( key )
	{
	    case -1: return "-";
	    case 8: return "BACK";
	    case 9: return "TAB";
	    case 13: return "ENTR";
	    case 16: return "SHFT";
	    case 17: return "CTRL";
	    case 18: return "ALT";
	    case 19: return "PAU";
	    case 20: return "CAPS";
	    case 27: return "ESC";
	    case 33: return "P-UP";
	    case 34: return "P-DO";
	    case 35: return "END";
	    case 36: return "HOME";
	    case 37: return "←";
	    case 38: return "↑";
	    case 39: return "→";
	    case 40: return "↓";
	    case 45: return "INS";
	    case 46: return "DEL";
	    case 96: return "0";
	    case 97: return "1";
	    case 98: return "2";
	    case 99: return "3";
	    case 100: return "4";
	    case 101: return "5";
	    case 102: return "6";
	    case 103: return "7";
	    case 104: return "8";
	    case 105: return "9";
	    case 106: return "*";
	    case 107: return "+";
	    case 109: return "-";
	    case 110: return ".";
	    case 111: return "/";
	    case 112: return "F1";
	    case 113: return "F2";
	    case 114: return "F3";
	    case 115: return "F4";
	    case 116: return "F5";
	    case 117: return "F6";
	    case 118: return "F7";
	    case 119: return "F8";
	    case 120: return "F9";
	    case 121: return "F10";
	    case 122: return "F11";
	    case 123: return "F12";
	    case 144: return "NLOCK";
	    case 145: return "SLOCK";
	    case 186: return ";";
	    case 187: return "=";
	    case 188: return ",";
	    case 189: return "-";
	    case 190: return ".";
	    case 191: return @"\";
	    case 192: return "`";
	    case 219: return "/";
	    case 220: return "[";
	    case 221: return "]";
	    case 222: return "'";
		default: return "--"
	}

}