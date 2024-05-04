/// @description Insert description here
// You can write your code in this editor

view = {

	id: view_camera[0],
	x: 0,
	y: 0,
	z: 0,
	tilt: 0,
	fov: 60,
	on: noone

}

ultimate_zoom = {

	amount: 0,
	time: 0,
	easeinf: function(n){},
	easeoutf: function(n){},
	easeintime: 0,
	_in: 0,
	easeouttime: 0,
	_out: 0

}

spectating = false;

ani = 0;

spdlarg = 0;

directional_camera = false;

//SHADER

// Call it only once
application_surface_draw_enable(false);

// Create ppfx system
global.ppfx = new PPFX_System();

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
	new FX_Vignette(true, 0.53, 0.1, 0.13, 1, make_color_rgb(192, 0, 0), [0.50, 0.50]), //vignette
	new FX_Saturation(true, 1)

];
	
main_profile = new PPFX_Profile("Main", effects);

// Load profile, so all effects will be used
global.ppfx.ProfileLoad(main_profile);