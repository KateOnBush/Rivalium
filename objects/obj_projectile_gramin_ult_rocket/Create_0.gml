/// @description Insert description here
// You can write your code in this editor

event_inherited()

trail = part_type_create();
part_type_shape(trail, pt_shape_line)
part_type_color3(trail, c_orange, c_red, c_yellow)
part_type_alpha3(trail, 0.6, 0.4, 0)

on_collision = function(){

	screen_shake_position(50, 100, 0.1, x, y);
	if ownerID == global.playerid {
		explosion_create_request(obj_explosion_gramin_ult, x, y, 150, 100);
		var d = 45;
		repeat(4){
			projectile_create_request(obj_projectile_gramin_ult_smalldebris, x, y, 15, d, true, false, 10, 20, 0, 0, true);
			d += 90;
		}
	}

}
