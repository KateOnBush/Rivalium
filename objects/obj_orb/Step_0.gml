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

image_index += 12/60 * dtime;
rot += 5 * dtime;

var pick = instance_exists(pickedup);

spawned_size = dtlerp(spawned_size, pick ? 0.1 : spawned, 0.02);
fire_size = dtlerp(fire_size, spawned and !pick, 0.05);

if pick {

	pickup_blend = dtlerp(pickup_blend, 1, 0.005 + pickup_blend * 0.03);

	_x = dtlerp(_x, pickedup.x, pickup_blend);
	_y = dtlerp(_y, pickedup.y, pickup_blend);
	
	if (pickup_blend > 0.9) {
		instance_destroy();
	}

}

if (isFpsFrame) {
	if random(1) > 0.5 part_particles_create(global.partSystemBehind, x + random_range(-8, 8), y, parts, 1);
}