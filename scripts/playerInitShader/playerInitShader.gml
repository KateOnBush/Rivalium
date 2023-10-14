function playerInitShader(){

	// Call it only once
	application_surface_draw_enable(false);

	// Create ppfx system
	ppfx_id = new PPFX_System();

	// Create profile with all effects
	var effects = [
		new FX_Bloom(true, 4, 0.88, 2.66, c_white),
		//new FX_SunShafts(true, [0.8, 0.19], 0.8, 10, 1.13, 1, 0.25, true, 1, 1, 0.03, 0.50, undefined, false),
		new FX_Shake(true, 0, 0),
		new FX_SpeedLines(true, 0, 12.3, 1, 3, 0.2, 1.69, 0.7),
		new FX_Channels(true, 1.05, 1, 1),
		new FX_MotionBlur(true),
		
		new FX_ChromaticAberration(true, 0),
		new FX_LensDistortion(true, 0),
		new FX_Shockwaves(true, 0, 0.09),
		new FX_Vignette(true, 0)
	];
	
	main_profile = new PPFX_Profile("Main", effects);

	// Load profile, so all effects will be used
	ppfx_id.ProfileLoad(main_profile);

}