function playerHit(visual = true){

	hitind = 1;
	screen_shake_position(10, 100, 0.05, x, y + random_range(-30, 30));
	if (visual) part_particles_create(global.partSystem, x, y, gParts.blood, 40);

}