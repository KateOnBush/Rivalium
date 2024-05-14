/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

switch(type){
	case OrbType.LETHALITY: 
		color = #ff3224;
		break;
	case OrbType.RESISTANCE: 
		color = #2462ff;
		break;
	case OrbType.HASTE: 
		color = c_white;
		break;
}
part_type_color1(parts, color);

if (isFpsFrame) {
	part_particles_create(global.partSystem, x + random_range(-150, 150), y - random(400), parts, 1);
}