	/// @description Insert description here
// You can write your code in this editor

parallax_off = 200;
ratio = 9/16;
size = 6.01;

background_vbuffs = [];

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

	background_vbuffs[i] = vertex_create_buffer()

	vertex_begin(background_vbuffs[i], global.v_format)

	var b = sprite_get_uvs(_back, 0)

	vertex_add_square(background_vbuffs[i], 
		new Vector3(-ww/2, -hh/2, 3500),
		new Vector3(ww/2, -hh/2, 3500),
		new Vector3(-ww/2, hh/2, 3500),
		new Vector3(ww/2, hh/2, 3500),
		new Vector2(b[0], b[1]),
		new Vector2(b[2], b[1]),
		new Vector2(b[0], b[3]),
		new Vector2(b[2], b[3]),
	c_white);

	vertex_end(background_vbuffs[i]);

}

