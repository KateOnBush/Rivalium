/// @description Insert description here
// You can write your code in this editor

if growbranches < growMaxBranches and !grown {

	growbranches += 0.45*dtime;
	growbranches = min(growbranches, growMaxBranches)

} else grown = true;

if takingdir and !obj_player.input_ability1.check() takingdir = false;

if takingdir {

	newdir = point_direction(x, y, obj_player.mousex, obj_player.mousey);
	
	if takingdirtimer>0.4 {
	
		parameters[1] = angular_dtlerp(parameters[1], newdir, .1);
		parameters[2] = parameters[1];
	
	} else if takingdirtimer>0.2 {
	
		parameters[2] = angular_dtlerp(parameters[2], newdir, .1);
		parameters[3] = parameters[2];
	
	} else if takingdirtimer>0 {
	
		parameters[3] = angular_dtlerp(parameters[3], newdir, .1);

	} else takingdir = 0
	
	takingdirtimer -= dtime/60;

}


if ownerID == global.playerid and current_time - last_updated > 16 and takingdir {

	entity_update_request(self);
	last_updated = current_time;

}


// Inherit the parent event
event_inherited();