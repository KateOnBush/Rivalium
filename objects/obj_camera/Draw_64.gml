/// @description Insert description here
// You can write your code in this editor

var ww = display_get_gui_width(), hh = display_get_gui_height();

var mousex = ww * display_mouse_get_x()/display_get_width(), 
	mousey = hh * display_mouse_get_y()/display_get_height();

draw_sprite(crosshair, 0, mousex, mousey);
with(obj_player) {
	if (char.abilities.basic_attack.cooldown > 0) {
		var cooldown = char.abilities.basic_attack.cooldown,
			max_cooldown = char.abilities.basic_attack.last_max_cooldown,
			percent = 1 - cooldown/max_cooldown;
		draw_sprite(crosshair_cooldown, 0, mousex - 12, mousey + 12);
		draw_sprite_part(crosshair_cooldown, 1, 0, 0, 24 * percent, 4, mousex - 12, mousey + 12);
		
	}
}

with (obj_player_other) {
	
	if (dead or invisible) break;
	
	var dd = convert_3d_to_2d(other.viewmat, other.projmat, x, y - 100, 0);
	var barx = dd.x * ww - 50, bary = (1 - dd.y) * hh;
	var on_same_team = not is_an_enemy();
	draw_sprite(s_healthbar, 0, barx, bary);
	draw_sprite_part(s_healthbar, 1, 0, 0, 100*health_blend_red, 40, barx, bary);
	draw_sprite_part(s_healthbar, on_same_team ? 2 : 3, 0, 0, 100*health_blend, 40, barx, bary);
	draw_sprite_part(s_healthbar, 4, 0, 0, 100*ultimatecharge_blend, 40, barx, bary);
	
}

with (obj_entity) {

	if (show_hp_timer <= 0) break;
	
	var dd = convert_3d_to_2d(other.viewmat, other.projmat, x, y - 100, 0);
	var barx = dd.x * ww - 100, bary = (1 - dd.y) * hh;
	var percent = hp_blend/maxhp;
	draw_sprite(s_healthbar_entity, 0, barx, bary);
	draw_sprite_part(s_healthbar_entity, 1, 0, 0, 200*percent, 10, barx, bary);

}

