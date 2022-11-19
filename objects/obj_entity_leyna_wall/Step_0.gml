/// @description Insert description here
// You can write your code in this editor

if growbranches < growMaxBranches and !grown {

	growbranches += 0.45*dtime;
	growbranches = min(growbranches, growMaxBranches)

} else grown = true;

if takingdir and !obj_player.input_ability1.check() takingdir = false;

if takingdir {

	if takingdirtimer>0{
	
		newdir = point_direction(obj_player.x, obj_player.y, obj_player.mousex, obj_player.mousey);
		parameters[1] -= angle_difference(parameters[1], newdir)*0.1*dtime;

	} else takingdir = 0
	
	takingdirtimer -= dtime/60;

}


if ownerID == global.playerid and current_time - last_updated > 16 and takingdir {

	entity_update_request(self);
	last_updated = current_time;

}


// Inherit the parent event
event_inherited();