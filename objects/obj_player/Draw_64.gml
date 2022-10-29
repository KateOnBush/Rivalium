/// @description Insert description here
// You can write your code in this editor

display_set_gui_size(1280,720)

draw_set_halign(fa_left);

draw_text(32,128,dir)

for(var n = 0; n<ds_map_size(global.players); n++){

	draw_text(32,32+n*32,ds_map_keys_to_array(global.players)[n]);

}

draw_text(160,32,"ping "+ string(global.ping) + "ms");
draw_text(160,64,string(fps) + " fps");
draw_text(160,96,zoom);



var width = 1920;
var height = 1080;

display_set_gui_size(width,height)

draw_set_alpha(0.8*HUDalpha)
draw_sprite_stretched(HUD_vignette,0,0,0,width,height)
draw_set_alpha(1*HUDalpha)

part_system_drawit(lines)

part_particles_create(lines, width/2, height/2, linepart, max((2+linethreshold*2)*global.dt,1))

//sprite_set_offset(HUD,1920/2, 1080);

draw_sprite(HUD,0,width/2 - 1920/2,height - 1080)

draw_sprite_part(HUD, 1, 436, 0, (1490-436)*health_blend_red, 1080, width/2 + (436 - 1920/2) , height-1080);

draw_sprite_part(HUD, 2, 436, 0, (1490-436)*health_blend, 1080, width/2 + (436 - 1920/2) , height-1080);

draw_sprite_part(HUD, 3, 466, 0, (1460-466)*ultimatecharge_blend, 1080, width/2 + (466 - 1920/2), height-1080);

//sprite_set_offset(HUD, 0, 1080);

draw_sprite(HUD, 4, 0, height-1080);

//sprite_set_offset(HUD, 1920, 1080);

draw_sprite(HUD, 5, width-1920, height-1080);

//part_particles_create(ultimatePart, width-128*1.15+random_range(-64,64), height-128, ult, 50)

draw_set_font(font_game)
draw_set_valign(fa_middle)
draw_set_halign(fa_center)
draw_set_color(c_white)
char.abilities.basic_attack.draw(128, height-128,1, HUDalpha);
draw_sprite_ext(ability_outline, 0, 128, height-128, 0.52, 0.52, 0, c_white, HUDalpha)
draw_sprite(mouse_icon,0,128, height-64+28)

if char.abilities.ultimate.cooldown == 0 && !char.abilities.ultimate.active && ultimatecharge == ultimatechargemax {

	part_particles_create(ultimatePart, width-128*1.15 + random_range(-64,64)*1.3, height-128, ult, irandom(15*global.dt))
	
}

part_system_drawit(ultimatePart)

char.abilities.ultimate.draw(width-128*1.15, height-128, 1.3, HUDalpha);
draw_set_alpha(HUDalpha)
draw_sprite_ext(ability_outline, 0, width-128*1.15, height-128, 0.02 + 1.3/2, 0.02 + 1.3/2, 0, c_white, HUDalpha);
draw_text(width-128*1.15, height-128+64*1.3+22,"X")

char.abilities.ability1.draw(width-128*1.15-144, height-128+32, 0.5, HUDalpha);
draw_set_alpha(1*HUDalpha)
draw_sprite_ext(ability_outline, 0, width-128*1.15-144, height-128+32, 0.02 + 0.25, 0.02 + 0.25, 0, c_white, HUDalpha)
draw_text(width-128*1.15-144+32+16, height-128+32+16,"A")

char.abilities.ability2.draw(width-128*1.15-208, height-48, 0.5, HUDalpha);
draw_set_alpha(1*HUDalpha)
draw_sprite_ext(ability_outline, 0, width-128*1.15-208, height-48, 0.02 + 0.25, 0.02 + 0.25, 0, c_white, HUDalpha)
draw_text(width-128*1.15-208+32+16, height-48+16,"E")
draw_set_alpha(1)

var k = HUDalpha*0.1*height;

draw_sprite_pos(blackBorders, 0, 0, -k,     width, -k,      width, .1*height-k,      0, 0.1*height-k,          1);
draw_sprite_pos(blackBorders, 0, 0, 0.9*height+k,     width, 0.9*height+k,      width, height+k,          0, height+k, 1);