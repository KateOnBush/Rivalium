/// @description Insert description here
// You can write your code in this editor

draw_self();

draw_sprite_ext(IconList[iconindex], 0, x, y, image_xscale, image_yscale, 0, c_white, 1);

draw_set_font(mainFont);
draw_set_alpha(.8);
draw_set_valign(fa_bottom)
draw_set_halign(fa_left)
draw_set_color(COLOR_LIGHT);

var dis = .7;

draw_text_transformed(x + sprite_width * dis, y - 5, username, 0.5, 0.5, 0);

draw_set_valign(fa_middle)
var sc = .72/2;
draw_set_alpha(.8);
draw_text_transformed(x + sprite_width * dis, y, "Skill Tier", sc, sc, 0);
draw_sprite_ext(skillTierIconSprite, 0, x + sprite_width * dis + string_width("Skill Tier ") * sc + 8, y, .6, .6, 0, c_white, 1);
draw_text_transformed(x + sprite_width * dis + string_width("Skill Tier  ") * sc + 16, y, skilltier, sc, sc, 0);
draw_set_alpha(1);

var psc = 2;
draw_sprite_ext(progressBarSprite, 0, x + sprite_width * .5, y + 18, psc, psc, 0, c_white, 1);
draw_sprite_part_ext(progressBarSprite, 1, 0, 0, pww * skillxp/skillxpmax, phh, x + sprite_width * .5, y + 18, psc, psc, c_white, 1);

draw_set_valign(fa_bottom)
draw_set_halign(fa_center)
draw_set_color(COLOR_LIGHT)
draw_text_transformed(x + sprite_width * .5 + psc * pww/2, y + 16, $"{skillxp} / {skillxpmax}", .3, .3, 0);

var xx = room_width/3 + 2/3 * room_width/6;

draw_sprite_ext(rankIconSprite, ranktier, xx + 2 * 16, y, 1.35, 1.35, 0, c_white, 1);
xx += 2.7 * 32;

var rankName = rank_number_to_name(ranktier);
var division = rank_division(ranktier, rankrating);
var longDiv = "";
if (division == "B") longDiv = ": Basis"
if (division == "M") longDiv = ": Medium"
if (division == "A") longDiv = ": Altum"

draw_set_valign(fa_bottom)
draw_set_halign(fa_left)
draw_text_transformed(xx, y - 5, $"{rank_number_to_name(ranktier)}{longDiv}", 0.5, 0.5, 0);

draw_set_valign(fa_middle)
draw_set_alpha(.8);
draw_text_transformed(xx, y, "Rank Tier", sc, sc, 0);
draw_sprite_ext(rankTierIconSprite, 0, xx + string_width("Rank Tier ") * sc + 8, y, .6, .6, 0, c_white, 1);
draw_text_transformed(xx + string_width("Rank Tier  ") * sc + 16, y, rankName, sc, sc, 0);
draw_set_alpha(1);

draw_text_transformed(xx, y + 28, $"{rankrating} RR", 0.5, 0.5, 0);

xx = room_width/3 + 8/3 * room_width/6;

var ics = .85, diff = 28;

draw_sprite_ext(currencyIcons, 0, xx, y - diff, ics, ics, 0, c_white, 1);
draw_sprite_ext(currencyIcons, 1, xx, y - 0, ics, ics, 0, c_white, 1);
draw_sprite_ext(currencyIcons, 2, xx, y + diff, ics, ics, 0, c_white, 1);

xx += 16 * (ics + .3);

draw_text_transformed(xx, y - diff, gold, sc, sc, 0);
draw_text_transformed(xx, y - 0, amethyst, sc, sc, 0);
draw_text_transformed(xx, y + diff, rivalite, sc, sc, 0);

xx += max(string_width(string(gold)), string_width(string(rivalite)), string_width(string(amethyst))) * sc + 10;
draw_set_alpha(.8);

draw_text_transformed(xx, y - diff, "GOLD", sc, sc, 0);
draw_text_transformed(xx, y - 0, "AMETHYST", sc, sc, 0);
draw_text_transformed(xx, y + diff, "RIVALITE", sc, sc, 0);

draw_set_alpha(1);