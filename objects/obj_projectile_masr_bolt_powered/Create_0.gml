/// @description Insert description here
// You can write your code in this editor
bolttime = 1.5;


trail = part_type_create();
part_type_sprite(trail, base_character_masr_slash_part, false, false, true);
part_type_alpha3(trail, .8, 0.6, 0)
part_type_size(trail, .01, 1.1, 0, 0)
part_type_life(trail, 30, 30)

line = part_type_create();
part_type_shape(line, pt_shape_line)
part_type_size(line, .3, .3, 0, 0)
part_type_color2(line, #7dacff, #c9ddff);
part_type_alpha2(line, .8, 0)
part_type_life(line, 15, 15)
part_type_scale(line, 9, 1);

// Inherit the parent event
event_inherited();
