/// @description Insert description here
// You can write your code in this editor

if growbranches < growMaxBranches and !grown {

	growbranches += 0.45*dtime;
	growbranches = min(growbranches, growMaxBranches)

} else grown = true;

if !grown and ownerID == global.playerid and obj_player.input_ability1.check(){

	parameters[1] = dtlerp(parameters[1], 
	point_direction(obj_player.x, obj_player.y, obj_player.mousex, obj_player.mousey), 0.2);
	
	entity_update_request(self);

}


// Inherit the parent event
event_inherited();