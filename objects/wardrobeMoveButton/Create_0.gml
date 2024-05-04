/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

text = ""
icon = moveIcon;
color = COLOR_DARK;
size = .4;
noBox = true;
move = 1;

onClick = function(){ 
	
	with(wardrobeManager) {
		currentPage += other.move;
		if (currentPage == WardrobePages.FIRST) {
			currentPage = WardrobePages.LAST - 1;	
		} else if (currentPage == WardrobePages.LAST) {
			currentPage = WardrobePages.FIRST + 1;	
		}
	}
	
}