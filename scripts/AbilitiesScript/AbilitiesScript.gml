// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum ability_type{

	onetime,
	active,
	charges,
	activecharges

}

function secstr(s){
	
	return (s > 1 ? string(ceil(s)) : string_format(s, 1, 1)) + "s";
	
}

function Ability(acooldown, atype, atype_data, acast_fake, acast_func, acast_visual_func, acasting_func, acast_time, asprite, acolor, aultimate = false, castblock = false) constructor{

	init_cooldown = acooldown;
	ultimate = aultimate;
	if !is_array(init_cooldown) init_cooldown = [init_cooldown];
	cooldown = 0;
	type = atype;
	typedata = atype_data;
	cast_fake = acast_fake;
	cast_func = acast_func;
	cast_visual_func = acast_visual_func;
	casting_func = acasting_func;
	cast_time = 0;
	init_cast_time = acast_time;
	active = false;
	init_charges = 2;
	charges = 2;
	iscasting = false;
	init_active_time = 1;
	active_time = 0;
	init_cooldown_charge = 0;
	charge_time = 0;
	init_charge_time = 0;
	sprite = asprite;
	cast_block = castblock;
	cooldown_blend = 0;
	active_blend = 0;
	color = acolor;
	available = false;
	c = 0;
	s = -1;
	availableblend = 0;
	
	cooldownHasCondition = false;
	if variable_struct_exists(typedata, "cooldownCondition"){
		if typeof(typedata.cooldownCondition) == "method"{
			cooldownHasCondition = true;
			cooldownCondition = method(other, typedata.cooldownCondition);
		}
	}
	
	castHasCondition = false;
	if variable_struct_exists(typedata, "castCondition"){
		if typeof(typedata.castCondition) == "method"{
			castHasCondition = true;
			castCondition = method(other, typedata.castCondition);
		}
	}
	
	if type == ability_type.charges or type == ability_type.activecharges{
		init_charges = typedata.charges;
		charges = init_charges;
		init_cooldown_charge = typedata.cooldown_charge;
		init_charge_time = typedata.charge_time;
		
	}
	if type == ability_type.active or type == ability_type.activecharges {
		init_active_time = typedata.active_time;
		init_active_func = method(other, typedata.active_func);
		init_end_func = method(other, typedata.end_func);
	}
	
	if type == ability_type.activecharges charge_cast_time = typedata.charge_cast_time;
	
	static forceCooldown = function(n = 0){
	
		cooldown = (cooldownHasCondition ? cooldownCondition(n) : init_cooldown[n]);
		active = false;
		charges = 0;
		active_time = 0;
	
	}
	
	static requestCast = function(n = 0){
	
		if cooldown > 0 return false;
		if active && type == ability_type.active return false;
		if charges == 0 && (type == ability_type.charges or type == ability_type.activecharges) return;
		if castHasCondition && !castCondition() return;
			
		cast_fake(n);
			
		if global.connected {
			
			var cb = other.castedAbility;
			
			var buff = buffer_create(global.dataSize, buffer_fixed, 1);
			buffer_seek(buff, buffer_seek_start, 0);
			buffer_write(buff, buffer_u8, SERVER_REQUEST.ABILITY_CAST);
			buffer_write(buff, buffer_u8, cb);
			buffer_write(buff, buffer_u8, n);
				
			network_send_raw(obj_network.server, buff, global.dataSize);
				
			buffer_delete(buff);
			
		}
	
	}
	
	static cast = function(n = 0){
	
		if other.object_index == obj_player {
			
			if cooldown > 0 return false;
			if active && type == ability_type.active return false;
			if charges == 0 && (type == ability_type.charges or type == ability_type.activecharges) return;
			if castHasCondition && !castCondition() return;
			
		}
		
		if (ultimate && (other.ultimatecharge != other.ultimatechargemax) && !active && charges == init_charges) return;
		
		cast_time = type == ability_type.activecharges && active ? charge_cast_time : init_cast_time;
		
		if other.object_index == obj_player cast_func(n);
		
		cast_visual(n);
		
		if type == ability_type.onetime {
		
			cooldown = (cooldownHasCondition ? cooldownCondition(n) : init_cooldown[n]);
		
		}
		if type == ability_type.charges or type == ability_type.activecharges {
		
			if type != ability_type.activecharges or active {
		
				if charges == 0 return false;
		
				charges -= 1;
		
				if charges > 0 {
			
					cooldown = init_cooldown_charge;
					if type == ability_type.activecharges charge_time = 0;
			
				} else {
					cooldown = init_cooldown[n];
					charge_time = init_charge_time;
					if type == ability_type.activecharges {
						charges = 0;
						charge_time = 0;
						cooldown = 0;
					}
				}
			
			}
		
		}
		if type == ability_type.active or type == ability_type.activecharges{
		
			if (type != ability_type.activecharges or !active) active_time = init_active_time;
			active = true;
		
		}
	
	}
	
	static cast_visual = function(n) {
	
		cast_visual_func(n);
	
	}
	
	static step = function() {
	
		if cooldown>0 cooldown -= global.dt/60;
		else {
		
			cooldown = 0;
			if type == ability_type.activecharges && charges == 0 && !active charges = init_charges;
		
		}
		
		if active_time>0 {
			active_time -= global.dt/60;
			init_active_func();
		}
		else if active{
			active_time = 0;
			if type == ability_type.active or type == ability_type.activecharges init_end_func();
			if active { 
				active = false
				cooldown = (cooldownHasCondition ? cooldownCondition(0) : init_cooldown[0]);
				charges = 0;
			}
		}
		
		if charge_time>0 && (cooldown == 0 or charges > 0) charge_time -= global.dt/60;
		else if charge_time<0 charge_time = 0;
		
		if charge_time == 0 && charges < init_charges && !(type == ability_type.activecharges){
			charge_time = init_charge_time;
			charges = min(charges+1, init_charges);
		}
		
		if charges == init_charges charge_time = init_charge_time;
		
		cast_time = max(cast_time - dtime/60, 0);
		if cast_time > 0 iscasting = true else {
			iscasting = false;
		}
		
		if iscasting casting_func();
		
		c += dtime;
		active_blend = dtlerp(active_blend, active, 0.2);
		cooldown_blend = dtlerp(cooldown_blend, cooldown>0, 0.2);
	
	}
	
	static casting = function(){
	
		casting_func();
	
	}
	
	static draw = function(x, y, scale, alpha){
	
		draw_set_color(c_white)
		draw_set_font(font_game)
		draw_sprite_ext(ability_glow, 0, x, y, 0.5*scale+0.03, 0.5*scale+0.03, 0, color, abs(dsin(c*2))*active_blend*alpha);
		var castcond = !castHasCondition or castCondition();
		var available = (cooldown>0 or (ultimate && (other.ultimatecharge < other.ultimatechargemax) && !active && charges == init_charges) or !castcond);
		availableblend = dtlerp(availableblend, available, 0.03);
		draw_sprite_ext(sprite, 0, x, y, scale, scale, 1, c_white, alpha);
		draw_sprite_ext(sprite, 1, x, y, scale, scale, 1, c_white, availableblend*alpha);
		
		if type == ability_type.charges or (type == ability_type.activecharges && active) {
		
			if !surface_exists(s) s = surface_create(128, 128)
			surface_set_target(s);
		
			draw_clear_alpha(c_white,0);
			
			var n = 0;
			
			for(n = 0; n < charges; n++){
		
				draw_set_alpha(alpha)
				draw_set_color(c_white)
				draw_arc(0, 0, 128, 128,
				64+lengthdir_x(130, (25 + 360*n)/init_charges), 64+lengthdir_y(130, (25 + 360*n)/init_charges),
				64+lengthdir_x(130, (-25 + 360*(n+1))/init_charges), 64+lengthdir_y(130, (-25 + 360*(n+1))/init_charges), 16)
		
			}
			n--;
			if n < init_charges - 1{
				var k = 1 - charge_time/init_charge_time;
				if k != 1 draw_arc(0, 0, 128, 128,
				64+lengthdir_x(130, (25 + 360*(n+1))/init_charges), 64+lengthdir_y(130, (25 + 360*(n+1))/init_charges),
				64+lengthdir_x(130, max(-25 + 360*(n+1+k),25 + 360*(n+1))/init_charges), 64+lengthdir_y(130, max(-25 + 360*(n+1+k),25 + 360*(n+1))/init_charges), 16)
			}
		
			draw_set_color(c_white);
			draw_set_alpha(alpha)
			draw_sprite(ability_add,0,64,64)
		
			surface_reset_target()
		
			gpu_set_blendmode(bm_add);
		
			draw_surface_ext(s, x-64*scale, y+64*scale, scale, scale, 90, c_white, ((0.7 + 0.3*abs(dsin(c*1.2)))*.75)*(cooldown == 0 or charges > 0)*alpha)
		
			gpu_set_blendmode(bm_normal);
		
			draw_set_valign(fa_middle)
			draw_set_halign(fa_center)
			
			draw_set_alpha(0.6 * (charges != init_charges) * !cooldown_blend * alpha)
			if type == ability_type.charges draw_text_transformed(x,y+32*scale, secstr(charge_time), 0.8, 0.8, 0);
			
		} 
		
		if type == ability_type.active or type == ability_type.activecharges {
		
			draw_set_alpha(0.6*active_blend*alpha)
			draw_text_transformed(x,y+32*scale, secstr(active_time), 0.8, 0.8, 0);
		
		}
		
		draw_set_alpha(cooldown_blend*alpha)
		draw_text(x,y, secstr(cooldown));
		
		draw_set_alpha(alpha)
		draw_sprite_ext(ability_unavailable, 0, x, y, scale, scale, 1, c_white, 0.2*cooldown_blend*alpha)
		draw_sprite_ext(ability_active, 0, x, y, scale, scale, 1, c_white, abs(dsin(c*2))*0.1*active_blend*alpha)
		draw_set_alpha(1)
	
	}
	

}