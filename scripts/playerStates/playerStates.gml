#macro PLAYER_DASH_COOLDOWN 80
#macro PLAYER_GRAPPLE_COOLDOWN 40
#macro PLAYER_MAX_WALK_ANGLE 48
#macro PLAYER_VAULT_PIXEL 5
#macro SLOPE_NOT_FORCED_INTERVAL 7

enum PlayerState {

	FREE,
	DASHING,
	GRAPPLE_THROW,
	GRAPPLED,
	WALL_SLIDING,
	GROUNDED,
	DEAD,
	BLOCKED,

}

function playerPostState(){

	on_ground = false;

	if place_meeting(x - 2, y + 10, obj_solid) && place_meeting(x + 2, y + 10, obj_solid){

		on_ground = true;
		double_jump = false;
		double_jump_boost = false;

	}
	
	mousex = global.mouse.get_x();
	mousey = global.mouse.get_y();

}