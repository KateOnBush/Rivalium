function playerHit(){

	hitind = 1;
	if (object_index == obj_player) screen_shake_position(0.5, 2, 0.05, x, y);
	part_particles_create(global.partSystem, x, y, gParts.blood, 40);

}

function playerHeal() {

	healind = 1;

}