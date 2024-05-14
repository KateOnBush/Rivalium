	/// @description Insert description here
// You can write your code in this editor

parallax_off = 250;
ratio = 9/16;
size = 5.90;

background_data = [];

map = MAPS[0];

currentState = 0;
currentRound = 1;
startingIn = 0;

defendingTeam = 0;
firstTeamScore = 0;
secondTeamScore = 0;
type = GameType.CASUAL;

teams = [];


for(var i = 0; i < array_length(map.backgrounds); i++){

	var _back = map.backgrounds[i];
	var ww = size * 1280 + i * parallax_off, hh = size * 720 + i * parallax_off * ratio;

	background_data[i] = [ww, hh, 3500];

}

