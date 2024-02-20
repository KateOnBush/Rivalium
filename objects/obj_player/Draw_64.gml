/// @description Insert description here
// You can write your code in this editor

var w = 1280, h = 720;

display_set_gui_size(w, h)

draw_set_halign(fa_left);
draw_set_valign(fa_top);

var dd = convert_3d_to_2d(viewmat, projmat, x, y - 104, 0);
var barx = dd.x * w - 50, bary = (1 - dd.y) * h;
draw_sprite(s_healthbar, 0, barx, bary);
draw_sprite_part(s_healthbar, 1, 0, 0, 100*health_blend_red, 40, barx, bary);
draw_sprite_part(s_healthbar, 2, 0, 0, 100*health_blend, 40, barx, bary);
draw_sprite_part(s_healthbar, 3, 0, 0, 100*ultimatecharge_blend, 40, barx, bary);

if global.debugmode {

	draw_set_font(font_debug)
	draw_set_alpha(0.4)
	draw_set_color(c_black)
	draw_rectangle(10,20,10+200, 10+310, false);
	
	draw_set_alpha(1)
	
	var dp = 0;
	var dis = 20;
	
	draw_set_color(c_lime)
	draw_text(20, 30+dp, "x: " + string(x) + ", y: " + string(y));
	dp+=dis;
	
	draw_set_color(c_aqua)
	draw_text(20, 30+dp, "mx: " + string(movvec.x) + ", my: " + string(movvec.y));
	dp+=dis;
	
	draw_set_color(c_orange)
	draw_text(20, 30+dp, "fps: " + string(fps) + ", ping: " + string(global.ping) + "ms");
	dp+=dis;
	
	draw_set_color(#f696ff)
	draw_text(20, 30+dp, "on_ground: " + string(on_ground) + ", slide: " + string(slide));
	dp+=dis;
	
	draw_text(20, 30+dp, "slope: " + string(slope_angle) + ", state: " + string(state));
	dp+=dis;
	
	draw_set_color(c_white)
	draw_text(20, 30+dp, "player ids: " + array_join(ds_map_keys_to_array(global.players), ", "));
	dp+=dis;
	
	draw_set_color(c_white);
	draw_text(20, 30+dp, "player id: " + string(global.playerid));
	dp+=dis;
	
	draw_set_color(c_white)
	draw_text(20, 30+dp, "speed: " + string(spd) + ", boost: " + string(spdboost));
	dp+=dis;
	
	draw_set_color(c_white)
	draw_text(20, 30+dp, "effects: " + string(effects_str));
	dp+=dis;
	
	
	
	

}



var width = 1920;
var height = 1080;

display_set_gui_size(width,height)

draw_set_alpha(0.8*HUDalpha)
//draw_sprite_stretched(HUD_vignette,0,0,0,width,height)
draw_set_alpha(1*HUDalpha)

var preroundOff = preroundBlend * 800;

//sprite_set_offset(HUD,1920/2, 1080);

draw_sprite(HUD,0,width/2 - 1920/2,height - 1080 + preroundOff)

draw_sprite_part(HUD, 1, 436, 0, (1490-436)*health_blend_red, 1080, width/2 + (436 - 1920/2) , height-1080 + preroundOff);

draw_sprite_part(HUD, 2, 436, 0, (1490-436)*health_blend, 1080, width/2 + (436 - 1920/2) , height-1080 + preroundOff);

draw_sprite_part(HUD, 3, 466, 0, (1460-466)*ultimatecharge_blend, 1080, width/2 + (466 - 1920/2), height-1080 + preroundOff);

draw_sprite(HUD, 4, 0 - preroundOff, height-1080);

draw_sprite(HUD, 5, width-1920 + preroundOff, height-1080);

draw_sprite(HUD_Round, 0, width/2, 0);


//part_particles_create(ultimatePart, width-128*1.15+random_range(-64,64), height-128, ult, 50)

draw_set_font(font_game)
draw_set_valign(fa_middle)
draw_set_halign(fa_center)
draw_set_color(c_white)

draw_line(width/2, 5, width/2, 42);

draw_text(width/2 - 220/4, 22, "Round " + string(obj_gameplay.currentRound));
draw_text(width/2 + 220/4, 22, timeText);

char.abilities.basic_attack.draw(128 - preroundOff, height-128,1, HUDalpha);
draw_sprite_ext(ability_outline, 0, 128 - preroundOff, height-128, 0.52, 0.52, 0, c_white, HUDalpha)
input_basicAttack.draw(128-20 - preroundOff, height-64+28);
input_basicAttackAlternate.draw(128+20 - preroundOff, height-64+28);

char.abilities.ultimate.draw(width-128*1.15 + preroundOff, height-128, 1.3, HUDalpha);
draw_set_alpha(HUDalpha)
draw_sprite_ext(ability_outline, 0, width-128*1.15 + preroundOff, height-128, 0.02 + 1.3/2, 0.02 + 1.3/2, 0, c_white, HUDalpha);
input_ultimate.draw(width-128*1.15 + preroundOff, height-128+64*1.3+22);

char.abilities.ability1.draw(width-128*1.15-144 + preroundOff, height-128+32, 0.5, HUDalpha);
draw_set_alpha(1*HUDalpha)
draw_sprite_ext(ability_outline, 0, width-128*1.15-144 + preroundOff, height-128+32, 0.02 + 0.25, 0.02 + 0.25, 0, c_white, HUDalpha)
input_ability1.draw(width-128*1.15-144+32+16 + preroundOff, height-128+32+16)

char.abilities.ability2.draw(width-128*1.15-208 + preroundOff, height-48, 0.5, HUDalpha);
draw_set_alpha(1*HUDalpha)
draw_sprite_ext(ability_outline, 0, width-128*1.15-208 + preroundOff, height-48, 0.02 + 0.25, 0.02 + 0.25, 0, c_white, HUDalpha)
input_ability2.draw(width-128*1.15-208+32+16 + preroundOff, height-48+16);
draw_set_alpha(1)

if (GUIText != GUITextDisplay) {
	GUITextBlend = dtlerp(GUITextBlend, 0, 0.2);	
	if (GUITextBlend < 0.01) {
		GUITextDisplay = GUIText;	
	}
} else {
	GUITextBlend = dtlerp(GUITextBlend, 1, 0.2);	
}

draw_set_font(font_game);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_black);
draw_set_alpha(GUITextBlend * 0.3)
draw_text_transformed(width/2, height * 0.2 + 2, GUITextDisplay, 2, 2.1, 0);
draw_set_color(c_white);
draw_set_alpha(GUITextBlend);
draw_text_transformed(width/2, height * 0.2, GUITextDisplay, 2, 2, 0);

draw_set_alpha(1);

var k = HUDalpha*0.1*height;

draw_sprite_pos(blackBorders, 0, 0, -k,     width, -k,      width, .1*height-k,      0, 0.1*height-k,          1);
draw_sprite_pos(blackBorders, 0, 0, 0.9*height+k,     width, 0.9*height+k,      width, height+k,          0, height+k, 1);
