/// @description Insert description here
// You can write your code in this editor

var currentdir = parameters[0];

var posx = x, posy = y;
for(var i = 0; i < growbranches; i++){

	var s = 1;
	if i+2 > growbranches s = growbranches mod 1;
	
	draw_sprite_ext(sprite, spr_inds[i], posx, posy , 1, 1,currentdir,c_white,1);
	
	blocks[i].x = posx;
	blocks[i].y = posy;
	blocks[i].image_angle = currentdir
	
	posx += lengthdir_x(s*dist, currentdir);
	posy += lengthdir_y(s*dist, currentdir);
	
	var n = i * 3 / growMaxBranches, rn = floor(n);
	var stepGrow = 3/growMaxBranches;
	
	currentdir += angle_difference(parameters[1 + rn], currentdir)*stepGrow*lerpmom;

}

event_inherited();