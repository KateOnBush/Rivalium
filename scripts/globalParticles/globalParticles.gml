#macro gParts global.__particles

gParts = {};

function cleanParticles() {

	part_type_destroy(gParts.blood);

}

function setupParticles() {
	
	var setup;
	
	gParts = {

		blood: part_type_create(),
		death: part_type_create()

	};
	
	setup = gParts.blood;

	part_type_speed(setup, 2, 3.5, 0, 0)
	part_type_direction(setup, -20, 200, 0, 0)
	part_type_orientation(setup, 0,0, 0, 0, true);
	part_type_sprite(setup, sBloodParticle, 0, 0, 0);
	part_type_size(setup, 0.8, 1.8, -0.08, 0.01)
	part_type_gravity(setup, grav/2, -90)
	part_type_life(setup, 8, 25)
	
	setup = gParts.death;
	
	part_type_shape(setup, pt_shape_pixel);
	part_type_speed(setup, 8, 9, -0.06, 0);
	part_type_direction(setup, 0, 360, 0, 0.3);
	part_type_size(setup, 2.2, 3.8, 0, 0);
	part_type_alpha2(setup, 1, 0)
	part_type_color2(setup, c_black, c_ltgrey);
	part_type_life(setup, 60, 100);

}