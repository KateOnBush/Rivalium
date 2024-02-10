#macro gParts global.__particles

gParts = {};

function cleanParticles() {

	part_type_destroy(gParts.blood);

}

function setupParticles() {
	
	var setup;
	
	gParts = {

		blood: part_type_create(),
		death: part_type_create(),
		dustRun: part_type_create(),
		dustGround: part_type_create(),

		kennSpeedParticle: part_type_create(),

	};
	
	setup = gParts.blood;

	part_type_speed(setup, 3.5, 4.5, 0, 0)
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
	
	setup = gParts.dustRun;
	part_type_sprite(setup, sDustParticle, false, false, true);
	part_type_speed(setup, 4, 5, -0.3, 0);
	part_type_orientation(setup, 0, 360 , 0, 0 , 0);
	part_type_direction(setup, 30, 150, 0, 0.4);
	part_type_size(setup, 0.5, 0.65, -0.03, 0);
	part_type_alpha3(setup, 0.9, 0.7, 0);
	part_type_life(setup, 150, 200);
	
	setup = gParts.dustGround;
	part_type_sprite(setup, sDustParticle, false, false, true);
	part_type_speed(setup, 7, 8, -0.5, 0);
	part_type_orientation(setup, 0, 360 , 0, 0 , 0);
	part_type_direction(setup, 0, 180, 0, 0.4);
	part_type_size(setup, 0.6, 0.75, -0.03, 0);
	part_type_alpha3(setup, 1, 0.8, 0);
	part_type_life(setup, 150, 200);
	
	setup = gParts.kennSpeedParticle;
	part_type_sprite(setup, base_character_kenn_speed_particle, false, false, true);
	part_type_speed(setup, 4, 6, -0.12, 0);
	part_type_orientation(setup, 0, 360, 0, 0 , 0);
	part_type_direction(setup, 70, 110, 0, 0.2);
	part_type_size(setup, 1.2, 1.5, -0.01, 0);
	part_type_alpha3(setup, 1, 0.8, 0.2);
	part_type_life(setup, 200, 250);
	

}