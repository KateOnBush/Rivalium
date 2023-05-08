
// Feather ignore all

/// @desc Create post-processing system instance. The PPFX system essentially contains the effects renderer. It works both for full screen and for layers.
/// @returns {struct} Post-Processing system id.
function PPFX_System() constructor {
	__ppf_trace("System created. From: " + object_get_name(other.object_index));
	
	// Base
	__stack_surface = array_create(17, -1);
	__stack_index = 0;
	__render_x = 0;
	__render_y = 0;
	__render_vw = 0;
	__render_vh = 0;
	__render_res = 1;
	__render_old_res = __render_res;
	__current_profile = noone;
	__source_surf_exists = true;
	__destroyed = false;
	__layered = false;
	__time = 0;
	__skip_stack_list = array_create(3, false);
	
	// Extra
	__sunshaft_surf = -1;
	__sunshaft_downscale = 0;
	__bloom_surface = array_create(16, -1);
	__bloom_downscale = 0;
	__dof_surface = array_create(5, -1);
	__dof_downscale = 0;
	__kawase_blur_surface = array_create(16, -1);
	__gaussian_blur_ping_surface = -1;
	__gaussian_blur_pong_surface = -1;
	__gaussian_blur_downscale = 0;
	__slow_motion_buffer_a_surf = -1;
	
	// Confs
	__is_draw_enabled = true;
	__is_render_enabled = true;
	__global_intensity = 1;
	__surface_tex_format = global.__ppf_main_texture_format;
	
	#region Effects Settings
	__effects_names = [
		"rotation",
		"zoom",
		"shake",
		"lens_distortion",
		"pixelize",
		"swirl",
		"panorama",
		"sine_wave",
		"glitch",
		"shockwaves",
		"displacemap",
		"white_balance",
		"border",
		"hq4x",
		"fxaa",
		"sunshafts",
		"bloom",
		"depth_of_field",
		"slow_motion",
		"motion_blur",
		"radial_blur",
		"lut",
		"exposure",
		"posterization",
		"brightness",
		"contrast",
		"shadow_midtone_highlight",
		"saturation",
		"hue_shift",
		"colorize",
		"color_tint",
		"invert_colors",
		"texture_overlay",
		"lift_gamma_gain",
		"tone_mapping",
		"palette_swap",
		"kawase_blur",
		"gaussian_blur",
		"vhs",
		"chromatic_aberration",
		"mist",
		"speedlines",
		"dithering",
		"noise_grain",
		"vignette",
		"nes_fade",
		"fade",
		"scanlines",
		"cinema_bars",
		"color_blindness",
		"channels",
	];
	
	__fx_cfg = {
		rotation : {
			enabledd : false,
		},
		zoom : {
			enabledd : false,
		},
		shake : {
			enabledd : false,
		},
		lens_distortion : {
			enabledd : false,
		},
		pixelize : {
			enabledd : false,
		},
		swirl : {
			enabledd : false,
		},
		panorama : {
			enabledd : false,
		},
		sine_wave : {
			enabledd : false,
		},
		glitch : {
			enabledd : false,
		},
		shockwaves : {
			enabledd : false,
		},
		displacemap : {
			enabledd : false,
		},
		border : {
			enabledd : false,
		},
		white_balance : {
			enabledd : false,
		},
		hq4x : {
			enabledd : false,
		},
		fxaa : {
			enabledd : false,
		},
		sunshafts : {
			enabledd : false,
		},
		bloom : {
			enabledd : false,
		},
		depth_of_field : {
			enabledd : false,
		},
		slow_motion : {
			enabledd : false,
		},
		motion_blur : {
			enabledd : false,
		},
		radial_blur : {
			enabledd : false,
		},
		lut : {
			enabledd : false,
		},
		exposure : {
			enabledd : false,
		},
		posterization : {
			enabledd : false,
		},
		brightness : {
			enabledd : false,
		},
		contrast : {
			enabledd : false,
		},
		shadow_midtone_highlight : {
			enabledd : false,
		},
		saturation : {
			enabledd : false,
		},
		hue_shift : {
			enabledd : false,
		},
		colorize : {
			enabledd : false,
		},
		color_tint : {
			enabledd : false,
		},
		invert_colors : {
			enabledd : false,
		},
		texture_overlay : {
			enabledd : false,
		},
		lift_gamma_gain : {
			enabledd : false,
		},
		tone_mapping : {
			enabledd : false,
		},
		palette_swap : {
			enabledd : false,
		},
		kawase_blur : {
			enabledd : false,
		},
		gaussian_blur : {
			enabledd : false,
		},
		vhs : {
			enabledd : false,
		},
		chromatic_aberration : {
			enabledd : false,
		},
		mist : {
			enabledd : false,
		},
		speedlines : {
			enabledd : false,
		},
		dithering : {
			enabledd : false,
		},
		noise_grain : {
			enabledd : false,
		},
		vignette : {
			enabledd : false,
		},
		nes_fade : {
			enabledd : false,
		},
		fade : {
			enabledd : false,
		},
		scanlines : {
			enabledd : false,
		},
		cinema_bars : {
			enabledd : false,
		},
		color_blindness : {
			enabledd : false,
		},
		channels : {
			enabledd : false,
		},
	};
	#endregion
	
	__pp_cfg_default = {};
	__ppf_struct_copy(__fx_cfg, __pp_cfg_default);
	
	
	#region Internal Methods
	
	static __Cleanup = function() {
		__ppf_surface_delete_array(__stack_surface);
		__ppf_surface_delete_array(__bloom_surface);
		__ppf_surface_delete_array(__dof_surface);
		__ppf_surface_delete_array(__kawase_blur_surface);
		__ppf_surface_delete(__sunshaft_surf);
		__ppf_surface_delete(__gaussian_blur_ping_surface);
		__ppf_surface_delete(__gaussian_blur_pong_surface);
		__ppf_surface_delete(__slow_motion_buffer_a_surf);
	}
	
	#endregion
	
	#region Public Methods
	
	/// @func Destroy()
	/// @desc Destroy post-processing system.
	/// @returns {undefined}
	static Destroy = function() {
		__ppf_trace("System deleted. From: " + object_get_name(other.object_index));
		__Cleanup();
		__destroyed = true;
	}
	
	/// @func Clean()
	/// @desc Clean post-processing system, without destroying it.
	/// Useful for when toggling effects and want to make sure existing surfaces are destroyed.
	/// @returns {undefined}
	static Clean = function() {
		__Cleanup();
	}
	
	/// @func SetDrawEnable()
	/// @desc Toggle whether the post-processing system can draw.
	/// Please note that if disabled, it may still be rendered if rendering is enabled (will continue to demand GPU).
	/// @param {real} enable Will be either true (enabled, the default value) or false (disabled). The drawing will toggle if nothing or -1 is entered.
	/// @returns {undefined}
	static SetDrawEnable = function(enable=-1) {
		if (enable == -1) {
			__is_draw_enabled = !__is_draw_enabled;
		} else {
			__is_draw_enabled = enable;
		}
	}
	
	/// @func SetRenderEnable(enable)
	/// @desc Toggle whether the post-processing system can render.
	/// Please note that if enabled, it can render to the surface even if not drawing!
	/// @param {Real} enable Will be either true (enabled, the default value) or false (disabled). The rendering will toggle if nothing or -1 is entered.
	/// @returns {undefined}
	static SetRenderEnable = function(enable=-1) {
		if (enable == -1) {
			__is_render_enabled = !__is_render_enabled;
		} else {
			__is_render_enabled = enable;
		}
	}
	
	/// @func SkipStacks(array)
	/// @desc This function allows skipping one or all persistent stacks (Base, Color Grading, Final), avoiding creating unused surfaces.
	/// The array must have 3 entries with booleans. "true" means it's skipping the stack (not rendering).
	/// @param {Array} array The skip array.
	static SkipStacks = function(array) {
		__ppf_exception(!is_array(array), "Invalid array.");
		__ppf_exception(array_length(array) != 3, "The array size needs to be exactly equal to 3.");
		__ppf_exception(!is_bool(array[0]) && !is_bool(array[1]) && !is_bool(array[2]), "Array must contain booleans.");
		__skip_stack_list = array;
	}
	
	/// @func SetGlobalIntensity(value)
	/// @desc Defines the overall draw intensity of the post-processing system.
	/// The global intensity defines the interpolation between the original image and with the effects applied.
	/// @param {real} value Intensity, 0 for none (default image), and 1 for full.
	/// @returns {undefined}
	static SetGlobalIntensity = function(value=1) {
		__global_intensity = value;
	}
	
	/// @func SetRenderResolution(resolution)
	/// @desc This function modifies the final rendering resolution of the post-processing system, based on a percentage (0 to 1).
	/// @param {real} resolution Value from 0 to 1 that is multiplied internally with the final resolution of the system's final rendering view.
	/// @returns {real} Value between 0 and 1.
	static SetRenderResolution = function(resolution=1) {
		__render_res = clamp(resolution, 0.01, 1);
	}
	
	/// @func SetEffectParameter(effect_index, param, value)
	/// @desc Modify a single parameter (setting) of an effect.
	/// Use this to modify an effect's attribute in real-time.
	/// @param {Real} effect_index Effect index. Use the enumerator, example: FX_EFFECT.BLOOM.
	/// @param {String} param Parameter macro. Example: PP_BLOOM_COLOR.
	/// @param {Any} value Parameter value. Example: make_color_rgb_ppfx(255, 255, 255).
	/// @returns {undefined}
	static SetEffectParameter = function(effect_index, param, value) {
		__fx_cfg[$ __effects_names[effect_index]][$ param] = value;
	}
	
	/// @func SetEffectParameters(effect_index, params_array, values_array)
	/// @desc Modify various parameters (settings) of an effect.
	/// Use this if you want to modify an effect's attributes in real-time.
	/// @param {Real} effect_index Effect index. Use the enumerator, example: FX_EFFECT.BLOOM.
	/// @param {Array} params_array Array with the effect parameters. Use the pre-defined macros, for example: [PP_BLOOM_COLOR, PP_BLOOM_INTENSITY].
	/// @param {Array} values_array Array with parameter values, must be in the same order.
	/// @returns {undefined}
	static SetEffectParameters = function(effect_index, params_array, values_array) {
		var _st = __fx_cfg[$ __effects_names[effect_index]],
		_struct_vars = variable_struct_get_names(_st),
		_len_st = array_length(_struct_vars),
		_len_vars = array_length(params_array),
		i = 0;
		repeat(_len_st) {
			var j = 0;
			repeat(_len_vars) {
				if (_struct_vars[i] == params_array[j]) {
					_st[$ params_array[j]] = values_array[j];
				}
				++j;
			}
			++i;
		}
	}
	
	/// @func SetEffectEnable(effect_index, enable)
	/// @desc This function toggles the effect rendering.
	/// @param {Real} effect_index Effect index. Use the enumerator, example: FX_EFFECT.BLOOM.
	/// @param {Real} enable Will be either true (enabled) or false (disabled). The rendering will toggle if nothing or -1 is entered.
	/// @returns {undefined}
	static SetEffectEnable = function(effect_index, enable=-1) {
		var _ef = __effects_names[effect_index];
		__ppf_exception(variable_struct_names_count(__fx_cfg[$ _ef]) <= 1, "It is not possible to toggle an effect that does not exist in the profile.");
		if (enable == -1) {
			__fx_cfg[$ _ef].enabledd = !__fx_cfg[$ _ef].enabledd;
		} else {
			__fx_cfg[$ _ef].enabledd = enable;
		}
	}
	
	/// @func IsDrawEnabled()
	/// @desc Returns true if post-processing system drawing is enabled, and false if not.
	/// @returns {Bool}
	static IsDrawEnabled = function() {
		return __is_draw_enabled;
	}
	
	/// @func IsRenderEnabled()
	/// @desc Returns true if post-processing system rendering is enabled, and false if not.
	/// @returns {Bool}
	static IsRenderEnabled = function() {
		return __is_render_enabled;
	}
	
	/// @func IsEffectEnabled()
	/// @desc Returns true if effect rendering is enabled, and false if not.
	/// @param {Real} effect_index Effect index. Use the enumerator, example: FX_EFFECT.BLOOM.
	/// @returns {Bool}
	static IsEffectEnabled = function(effect_index) {
		var _ef = __effects_names[effect_index];
		return __fx_cfg[$ _ef].enabledd;
	}
	
	/// @func ProfileLoad(profile_id)
	/// @desc This function loads a previously created profile.
	/// Which means that the post-processing system will apply the settings of the effects contained in the profile, showing them consequently.
	/// If you use the same post-processing system throughout the game and want to load different profiles later, you will need to reference the default profile, otherwise the effects settings will not update correctly.
	/// @param {Struct} profile_id Profile id created with ppfx_profile_create().
	/// @returns {undefined}
	static ProfileLoad = function(profile_id) {
		__ppf_exception(!is_struct(profile_id), "Profile Index is not a struct.");
		if (__current_profile != profile_id.__id) {
			__ppf_struct_copy(__pp_cfg_default, __fx_cfg);
			__ppf_struct_copy(profile_id.__settings, __fx_cfg);
			__ppf_trace("Profile loaded: " + string(profile_id.__profile_name));
			__current_profile = profile_id.__id;
		}
	}
	
	/// @func ProfileUnload()
	/// @desc This function removes any profile associated with this post-processing system.
	static ProfileUnload = function() {
		if (__current_profile != noone) {
			__ppf_struct_copy(__pp_cfg_default, __fx_cfg);
			__ppf_trace("Profile unloaded. From: " + string(object_get_name(other.object_index)));
			__current_profile = noone;
		}
	}
	
	/// @func GetRenderSurface()
	/// @desc Returns the post-processing system final rendering surface.
	/// @returns {Id.Surface} Surface index.
	static GetRenderSurface = function() {
		return __stack_surface[__stack_index];
	}
	
	/// @func GetStackSurface()
	/// @desc Returns the specific stack rendering surface.
	/// @param {Real} index The stack index.
	/// @returns {Id.Surface} Surface index.
	static GetStackSurface = function(index) {
		return __stack_surface[min(max(index, 0), __stack_index)];
	}
	
	/// @func GetRenderResolution()
	/// @desc Returns the post-processing system rendering percentage (0 to 1).
	/// @returns {real} Normalized size.
	static GetRenderResolution = function() {
		return __render_res;
	}
	
	/// @func GetEffectParameter()
	/// @desc Get a single parameter (setting) value of an effect.
	/// @param {Real} effect_index Effect index. Use the enumerator, example: FX_EFFECT.BLOOM.
	/// @param {String} param Parameter macro. Example: PP_BLOOM_COLOR.
	/// @returns {Any}
	static GetEffectParameter = function(effect_index, param) {
		return __fx_cfg[$ __effects_names[effect_index]][$ param];
	}
	
	/// @func GetGlobalIntensity()
	/// @desc Get the overall draw intensity of the post-processing system.
	/// The global intensity defines the interpolation between the original image and with the effects applied.
	/// This function returns a value between 0 and 1.
	/// @returns {Real} Value between 0 and 1.
	static GetGlobalIntensity = function() {
		return __global_intensity;
	}
	
	#endregion
	
	#region Render
	
	/// @func DrawInFullscreen(surface)
	/// @desc Easily draw Post-Processing system in full screen. It is an alternative to the normal Draw method.
	///
	/// This function automatically detects the draw event you are drawing (Post-Draw or Draw GUI Begin).
	///
	/// It uses the size of the referenced surface for internal rendering resolution (example: application_surface size).
	/// 
	/// For the width and height size (scaled rendering size): If drawing in Post-Draw, is the size of the window (frame buffer). If in Draw GUI Begin, the size of the GUI.
	/// @param {Id.Surface} surface Render surface to copy from. (You can use application_surface).
	static DrawInFullscreen = function(surface=application_surface) {
		var _view_width = surface_get_width(surface), _view_height = surface_get_height(surface);
		if (event_number == ev_draw_post) {
			var _pos = application_get_position();
			Draw(surface, _pos[0], _pos[1], _pos[2]-_pos[0], _pos[3]-_pos[1], _view_width, _view_height);
		} else
		if (event_number == ev_gui_begin) {
			Draw(surface, 0, 0, display_get_gui_width(), display_get_gui_height(), _view_width, _view_height);
		}
	}
	
	/// @func Draw(surface, x, y, w, h, screen_width, screen_height)
	/// @desc Draw post-processing system on screen.
	/// @param {Id.Surface} surface Render surface to copy from. (You can use application_surface).
	/// @param {real} x Horizontal X position of rendering.
	/// @param {real} y Vertical Y position of rendering.
	/// @param {real} w Width of the stretched game screen.
	/// @param {real} h Height of the stretched game screen.
	/// @param {real} screen_width Width of your game screen (Can use width of application_surface or viewport).
	/// @param {real} screen_height Height of your game screen (Can use height of application_surface or viewport).
	/// @returns {undefined}
	static Draw = function(surface, x, y, w, h, screen_width, screen_height) {
		// Feather disable GM1044
		if (__destroyed) exit;
		__ppf_exception(surface == application_surface && event_number != ev_draw_post && event_number != ev_gui_begin, "Failed to draw using application_surface.\nIt can only be drawn in the Post-Draw or Draw GUI Begin event.");
		__ppf_exception(__layered && (event_number == ev_draw_post || event_number == ev_gui_begin), "You must not draw the system manually if it is already being applied to a Layer Renderer.");
		
		if (!surface_exists(surface)) {
			if (__source_surf_exists) {
				__ppf_trace("WARNING: trying to draw post-processing using non-existent surface.");
				__source_surf_exists = false;
			}
			exit;
		}
		__source_surf_exists = true;
		var _sys_depth_disable = surface_get_depth_disable(),
		_sys_blendenable = gpu_get_blendenable(),
		_sys_blendmode = gpu_get_blendmode(),
		_sys_texrepeat = gpu_get_tex_repeat(),
		_effect = undefined,
		_uniform = undefined;
		
		// sets
		if (__is_render_enabled && __global_intensity > 0) {
			surface_depth_disable(true);
			//gpu_set_cullmode(cull_noculling);
			gpu_set_tex_repeat(false);
			//gpu_set_zwriteenable(false);
			//gpu_set_ztestenable(false);
			
			// time
			__time += PPFX_CFG_SPEED;
			if (PPFX_CFG_TIMER > 0 && __time > PPFX_CFG_TIMER) __time = 0;
			
			// pos and size (read-only)
			__render_x = x;
			__render_y = y;
			__render_vw = screen_width;
			__render_vh = screen_height;
			
			// resize render resolution
			screen_width *= __render_res;
			screen_height *= __render_res;
			screen_width -= frac(screen_width);
			screen_height -= frac(screen_height);
			
			// delete stuff, to be updated
			if (__render_old_res != __render_res) {
				__Cleanup();
				__render_old_res = __render_res;
			}
			
			// persistent = stack is executed directly;
			// note: effects are checked individually yet
			
			__stack_index = 0;
			//__stack_surface[0] = surface;
			
			#region Stack 0 - Base [persistent]
			//if (!__skip_stack_list[0]) { // Buggy on HTML5 (and GX.Games I think)...
				//__stack_index++;
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
					shader_set(__PPF_SH_BASE);
					shader_set_uniform_f(__PPF_SU.base_main.pos_res, x, y, screen_width, screen_height);
					shader_set_uniform_f(__PPF_SU.base_main.u_time_n_intensity, __time, __global_intensity);
					shader_set_uniform_f_array(__PPF_SU.base_main.enabledd, [
						__fx_cfg.rotation.enabledd,
						__fx_cfg.zoom.enabledd,
						__fx_cfg.shake.enabledd,
						__fx_cfg.lens_distortion.enabledd,
						__fx_cfg.pixelize.enabledd,
						__fx_cfg.swirl.enabledd,
						__fx_cfg.panorama.enabledd,
						__fx_cfg.sine_wave.enabledd,
						__fx_cfg.glitch.enabledd,
						__fx_cfg.shockwaves.enabledd,
						__fx_cfg.displacemap.enabledd,
						__fx_cfg.white_balance.enabledd,
					]);
				
					// > effect: rotation
					if (__fx_cfg.rotation.enabledd) {
						shader_set_uniform_f(__PPF_SU.rotation.angle, __fx_cfg.rotation.angle);
					}
					// > effect: zoom
					if (__fx_cfg.zoom.enabledd) {
						shader_set_uniform_f(__PPF_SU.zoom.amount, __fx_cfg.zoom.amount);
						shader_set_uniform_f(__PPF_SU.zoom.range, __fx_cfg.zoom.range);
						shader_set_uniform_f_array(__PPF_SU.zoom.center, __fx_cfg.zoom.center);
					}
					// > effect: shake
					if (__fx_cfg.shake.enabledd) {
						shader_set_uniform_f(__PPF_SU.shake.speedd, __fx_cfg.shake.speedd);
						shader_set_uniform_f(__PPF_SU.shake.magnitude, __fx_cfg.shake.magnitude);
						shader_set_uniform_f(__PPF_SU.shake.hspeedd, __fx_cfg.shake.hspeedd);
						shader_set_uniform_f(__PPF_SU.shake.vspeedd, __fx_cfg.shake.vspeedd);
					}
					// > effect: lens_distortion
					if (__fx_cfg.lens_distortion.enabledd) {
						shader_set_uniform_f(__PPF_SU.lens_distortion.amount, __fx_cfg.lens_distortion.amount);
					}
					// > effect: pixelize
					if (__fx_cfg.pixelize.enabledd) {
						shader_set_uniform_f(__PPF_SU.pixelize.amount, __fx_cfg.pixelize.amount);
						shader_set_uniform_f(__PPF_SU.pixelize.squares_max, __fx_cfg.pixelize.squares_max);
						shader_set_uniform_f(__PPF_SU.pixelize.steps, __fx_cfg.pixelize.steps);
					}
					// > effect: swirl
					if (__fx_cfg.swirl.enabledd) {
						shader_set_uniform_f(__PPF_SU.swirl.angle, __fx_cfg.swirl.angle);
						shader_set_uniform_f(__PPF_SU.swirl.radius, __fx_cfg.swirl.radius);
						shader_set_uniform_f_array(__PPF_SU.swirl.center, __fx_cfg.swirl.center);
					}
					// > effect: panorama
					if (__fx_cfg.panorama.enabledd) {
						shader_set_uniform_f(__PPF_SU.panorama.depth_x, __fx_cfg.panorama.depth_x);
						shader_set_uniform_f(__PPF_SU.panorama.depth_y, __fx_cfg.panorama.depth_y);
					}
					// > effect: sine_wave
					if (__fx_cfg.sine_wave.enabledd) {
						shader_set_uniform_f_array(__PPF_SU.sine_wave.frequency, __fx_cfg.sine_wave.frequency);
						shader_set_uniform_f_array(__PPF_SU.sine_wave.amplitude, __fx_cfg.sine_wave.amplitude);
						shader_set_uniform_f(__PPF_SU.sine_wave.speedd, __fx_cfg.sine_wave.speedd);
						shader_set_uniform_f_array(__PPF_SU.sine_wave.offset, __fx_cfg.sine_wave.offset);
					}
					// > effect: glitch
					if (__fx_cfg.glitch.enabledd) {
						shader_set_uniform_f(__PPF_SU.glitch.speedd, __fx_cfg.glitch.speedd);
						shader_set_uniform_f(__PPF_SU.glitch.block_size, __fx_cfg.glitch.block_size);
						shader_set_uniform_f(__PPF_SU.glitch.interval, __fx_cfg.glitch.interval);
						shader_set_uniform_f(__PPF_SU.glitch.intensity, __fx_cfg.glitch.intensity);
						shader_set_uniform_f(__PPF_SU.glitch.peak_amplitude1, __fx_cfg.glitch.peak_amplitude1);
						shader_set_uniform_f(__PPF_SU.glitch.peak_amplitude2, __fx_cfg.glitch.peak_amplitude2);
					}
					// > effect: shockwaves
					if (__fx_cfg.shockwaves.enabledd) {
						shader_set_uniform_f(__PPF_SU.shockwaves.amount, __fx_cfg.shockwaves.amount);
						shader_set_uniform_f(__PPF_SU.shockwaves.aberration, __fx_cfg.shockwaves.aberration);
						texture_set_stage(__PPF_SU.shockwaves.texture, __fx_cfg.shockwaves.texture);
						texture_set_stage(__PPF_SU.shockwaves.prisma_lut_tex, __fx_cfg.shockwaves.prisma_lut_tex);
					}
					// > effect: displacemap
					if (__fx_cfg.displacemap.enabledd) {
						shader_set_uniform_f(__PPF_SU.displacemap.amount, __fx_cfg.displacemap.amount);
						shader_set_uniform_f(__PPF_SU.displacemap.zoom, __fx_cfg.displacemap.zoom);
						shader_set_uniform_f(__PPF_SU.displacemap.angle, __fx_cfg.displacemap.angle);
						shader_set_uniform_f(__PPF_SU.displacemap.speedd, __fx_cfg.displacemap.speedd);
						texture_set_stage(__PPF_SU.displacemap.texture, __fx_cfg.displacemap.texture);
						shader_set_uniform_f_array(__PPF_SU.displacemap.offset, __fx_cfg.displacemap.offset);
					}
					// > effect: white_balance
					if (__fx_cfg.white_balance.enabledd) {
						shader_set_uniform_f(__PPF_SU.white_balance.temperature, __fx_cfg.white_balance.temperature);
						shader_set_uniform_f(__PPF_SU.white_balance.tint, __fx_cfg.white_balance.tint);
					}
					draw_surface_stretched(surface, 0, 0, screen_width, screen_height);
					shader_reset();
					gpu_set_blendmode(bm_normal);
				
					surface_reset_target();
				}
			//}
			#endregion
			
			#region Stack 1 - HQ4x
			_effect = __fx_cfg.hq4x;
			_uniform = __PPF_SU.hq4x;
			
			if (__fx_cfg.hq4x.enabledd) {
				__stack_index++;
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				// sets
				var _ds = round(clamp(_effect.downscale, 2, 8));
				
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
					shader_set(__PPF_SH_HQ4X);
					shader_set_uniform_f(_uniform.resolution, screen_width/_ds, screen_height/_ds);
					shader_set_uniform_f(_uniform.smoothness, _effect.smoothness);
					shader_set_uniform_f(_uniform.sharpness, _effect.sharpness);
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
			}
			#endregion
			
			#region Stack 2 - Fxaa
			if (__fx_cfg.fxaa.enabledd) {
				_effect = __fx_cfg.fxaa;
				_uniform = __PPF_SU.fxaa;
				
				__stack_index++;
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
					shader_set(__PPF_SH_FXAA);
					shader_set_uniform_f(_uniform.resolution, screen_width, screen_height);
					shader_set_uniform_f(_uniform.strength, _effect.strength);
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
			}
			#endregion
			
			#region Stack 3 - Bloom
			if (__fx_cfg.bloom.enabledd) {
				_effect = __fx_cfg.bloom;
				_uniform = __PPF_SU.bloom;
				
				// sets
				var _cur_aa_filter = gpu_get_tex_filter(),
				_iterations = clamp(_effect.iterations, 2, 8),
				_ds = clamp(_effect.downscale, 0.1, 1),
				_ww = screen_width*_ds, _hh = screen_height*_ds;
				
				if (__bloom_downscale != _ds) {
					__ppf_surface_delete_array(__bloom_surface);
					__bloom_downscale = _ds;
				}
				
				gpu_set_tex_filter(true);
				
				// > pre filter
				var _source = __stack_surface[__stack_index];
				if !surface_exists(__bloom_surface[0]) {
					__bloom_surface[0] = surface_create(_ww, _hh, __surface_tex_format);
				}
				var _current_destination = __bloom_surface[0];
				
				// blit
				surface_set_target(_current_destination);
					shader_set(__PPF_SH_BLOOM_PRE_FILTER);
					shader_set_uniform_f(_uniform.pre_filter_res, _ww, _hh);
					shader_set_uniform_f(_uniform.pre_filter_threshold, _effect.threshold);
					shader_set_uniform_f(_uniform.pre_filter_intensity, _effect.intensity);
					draw_surface_stretched(_source, 0, 0, _ww, _hh);
					shader_reset();
				surface_reset_target();
				
				var _current_source = _current_destination;
				
				
				// downsampling
				var i = 1; // there is already a texture in slot 0
				repeat(_iterations) {
					_ww /= 2;
					_hh /= 2;
					_ww -= frac(_ww);
					_hh -= frac(_hh);
					//if (min(_ww, _hh) < 2) break;
					if (_ww < 2 || _hh < 2) break;
					if !surface_exists(__bloom_surface[i]) {
						__bloom_surface[i] = surface_create(_ww, _hh, __surface_tex_format);
					}
					_current_destination = __bloom_surface[i];
					
					// blit
					surface_set_target(_current_destination);
						shader_set(__PPF_SH_DS_BOX13);
						shader_set_uniform_f(__PPF_SU.downsample_box13_res, _ww, _hh);
						draw_surface_stretched(_current_source, 0, 0, surface_get_width(_current_destination), surface_get_height(_current_destination));
						shader_reset();
					surface_reset_target();
					
					_current_source = _current_destination;
					++i;
				}
				
				
				// upsampling
				gpu_set_blendmode(bm_one);
				for(i -= 2; i >= 0; i--) { // 7, 6, 5, 4, 3, 2, 1, 0
					_current_destination = __bloom_surface[i];
					
					// blit
					_ww = surface_get_width(_current_destination);
					_hh = surface_get_height(_current_destination);
					surface_set_target(_current_destination);
						shader_set(__PPF_SH_US_TENT9);
						shader_set_uniform_f(__PPF_SU.upsample_tent_res, _ww, _hh);
						draw_surface_stretched(_current_source, 0, 0, _ww, _hh);
						shader_reset();
					surface_reset_target();
					
					_current_source = _current_destination;
				}
				gpu_set_blendmode(bm_normal);
				
				__stack_index++;
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
					shader_set(__PPF_SH_BLOOM);
					shader_set_uniform_f(_uniform.resolution, screen_width, screen_height);
					shader_set_uniform_f(_uniform.u_time_n_intensity, __time, __global_intensity);
					shader_set_uniform_f(_uniform.threshold, _effect.threshold);
					shader_set_uniform_f(_uniform.intensity, _effect.intensity);
					shader_set_uniform_f_array(_uniform.colorr, _effect.colorr);
					shader_set_uniform_f(_uniform.white_amount, _effect.white_amount);
					shader_set_uniform_f(_uniform.dirt_enable, _effect.dirt_enable);
					shader_set_uniform_f(_uniform.dirt_intensity, _effect.dirt_intensity);
					shader_set_uniform_f(_uniform.dirt_scale, _effect.dirt_scale);
					texture_set_stage(_uniform.bloom_tex, surface_get_texture(_current_destination));
					texture_set_stage(_uniform.dirt_tex, _effect.dirt_texture);
					gpu_set_tex_repeat_ext(_uniform.dirt_tex, false);
					shader_set_uniform_f(_uniform.debug1, _effect.debug1);
					shader_set_uniform_f(_uniform.debug2, _effect.debug2);
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
				gpu_set_tex_filter(_cur_aa_filter);
			}
			#endregion
			
			#region Stack 4 - Sunshafts
			if (__fx_cfg.sunshafts.enabledd) {
				_effect = __fx_cfg.sunshafts;
				_uniform = __PPF_SU.sunshafts;
				
				// NOTE: this effect is not affected by Bloom.
				// sets
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
				var _ds = clamp(__fx_cfg.sunshafts.downscale, 0.1, 1),
				_ww = screen_width*_ds, _hh = screen_height*_ds;
				
				if (__sunshaft_downscale != _ds) {
					__ppf_surface_delete(__sunshaft_surf);
					__sunshaft_downscale = _ds;
				}
				
				var _source = __stack_surface[0]; // get base surface, to be used by sunshafts
				if !surface_exists(__sunshaft_surf) {
					__sunshaft_surf = surface_create(_ww, _hh, __surface_tex_format);
				}
				surface_set_target(__sunshaft_surf);
				draw_clear_alpha(c_black, 0);
				draw_surface_stretched(_source, 0, 0, _ww, _hh);
				surface_reset_target();
				
				__stack_index++;
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					
					shader_set(__PPF_SH_SUNSHAFTS);
					gpu_set_tex_repeat_ext(_uniform.noise_tex, true);
					
					texture_set_stage(_uniform.sunshaft_tex, surface_get_texture(__sunshaft_surf));
					texture_set_stage(_uniform.noise_tex, _effect.noise_tex);
					shader_set_uniform_f(_uniform.resolution, screen_width, screen_height);
					shader_set_uniform_f(_uniform.u_time_n_intensity, __time, __global_intensity);
					shader_set_uniform_f_array(_uniform.position, _effect.position);
					shader_set_uniform_f(_uniform.center_smoothness, _effect.center_smoothness);
					shader_set_uniform_f(_uniform.threshold, _effect.threshold);
					shader_set_uniform_f(_uniform.intensity, _effect.intensity);
					shader_set_uniform_f(_uniform.dimmer, _effect.dimmer);
					shader_set_uniform_f(_uniform.scattering, _effect.scattering);
					shader_set_uniform_f(_uniform.noise_enable, _effect.noise_enable);
					shader_set_uniform_f(_uniform.rays_intensity, _effect.rays_intensity);
					shader_set_uniform_f(_uniform.rays_tiling, _effect.rays_tiling);
					shader_set_uniform_f(_uniform.rays_speed, _effect.rays_speed);
					shader_set_uniform_f(_uniform.debug, _effect.debug);
					
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					shader_reset();
					
					surface_reset_target();
				}
				
				gpu_set_blendmode(bm_normal);
			}
			#endregion
			
			#region Stack 5 - Depth of Field
			if (__fx_cfg.depth_of_field.enabledd) {
				_effect = __fx_cfg.depth_of_field;
				_uniform = __PPF_SU.depth_of_field;
				
				// sets
				var _source = __stack_surface[__stack_index];
				var _cur_aa_filter = gpu_get_tex_filter();
				gpu_set_tex_filter(false);
				
				var _ds = clamp(_effect.downscale, 0.1, 1);
				
				if (__dof_downscale != _ds) {
					__ppf_surface_delete_array(__dof_surface);
					__dof_downscale = _ds;
				}
				
				// coc
				var _ww = screen_width, _hh = screen_height;
				if !surface_exists(__dof_surface[0]) __dof_surface[0] = surface_create(_ww, _hh, surface_rgba8unorm); 
				__ppf_surface_blit(_source, __dof_surface[0], __PPF_PASS_DOF_COC, {
					lens_distortion_enable : __fx_cfg.lens_distortion.enabledd,
					lens_distortion_amount : __fx_cfg.lens_distortion.enabledd ? __fx_cfg.lens_distortion.amount : 0,
					radius : _effect.radius,
					focus_distance : _effect.focus_distance,
					focus_range : _effect.focus_range,
					use_zdepth : _effect.use_zdepth,
					zdepth_tex : _effect.zdepth_tex,
				});
				gpu_set_tex_filter(true);
				
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
				// pre filter
				_ww = screen_width*_ds; _hh = screen_height*_ds; // half res
				if !surface_exists(__dof_surface[1]) __dof_surface[1] = surface_create(_ww, _hh, surface_rgba8unorm);
				__ppf_surface_blit_alpha(_source, __dof_surface[1], __PPF_PASS_DS_BOX13, {
					ww : _ww,
					hh : _hh,
				});
				
				// bokeh
				if !surface_exists(__dof_surface[2]) __dof_surface[2] = surface_create(_ww, _hh, surface_rgba8unorm);
				__ppf_surface_blit_alpha(__dof_surface[1], __dof_surface[2], __PPF_PASS_DOF_BOKEH, {
					ww : _ww,
					hh : _hh,
					time : __time,
					global_intensity : __global_intensity,
					radius : _effect.radius,
					intensity : _effect.intensity,
					shaped : _effect.shaped,
					blades_aperture : _effect.blades_aperture,
					blades_angle : _effect.blades_angle,
					debug : _effect.debug,
					coc_tex : surface_get_texture(__dof_surface[0]),
				});
				
				// post filter
				//_ww /= 2; _hh /= 2;
				if !surface_exists(__dof_surface[3]) __dof_surface[3] = surface_create(_ww, _hh, surface_rgba8unorm);
				__ppf_surface_blit_alpha(__dof_surface[2], __dof_surface[3], __PPF_PASS_US_TENT9, {
					ww : _ww,
					hh : _hh,
				});
				
				__stack_index++;
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					
					shader_set(__PPF_SH_DOF);
					texture_set_stage(_uniform.final_coc_tex, surface_get_texture(__dof_surface[0]));
					texture_set_stage(_uniform.final_dof_tex, surface_get_texture(__dof_surface[3]));
					shader_set_uniform_f(_uniform.final_downscale, _ds);
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					shader_reset();
					
					surface_reset_target();
				}
				gpu_set_tex_filter(_cur_aa_filter);
				gpu_set_blendmode(bm_normal);
			}
			#endregion
			
			#region Stack 6 - Slow Motion
			if (__fx_cfg.slow_motion.enabledd) {
				__stack_index++;
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				if !surface_exists(__slow_motion_buffer_a_surf) {
					__slow_motion_buffer_a_surf = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				
				// buffer a
				surface_set_target(__slow_motion_buffer_a_surf);
				draw_surface_ext(__stack_surface[__stack_index-1], 0, 0, 1, 1, 0, c_white, 1-clamp(__fx_cfg.slow_motion.intensity, 0, 0.9));
				surface_reset_target();
				
				// draw from buffer a
				surface_set_target(__stack_surface[__stack_index]) {
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					var _iterations = max(1, __fx_cfg.slow_motion.iterations);
					repeat(_iterations) {
						draw_surface_stretched(__slow_motion_buffer_a_surf, 0, 0, screen_width, screen_height);
					}
					surface_reset_target();
				}
			}
			#endregion
			
			#region Stack 7 - Motion Blur
			if (__fx_cfg.motion_blur.enabledd) {
				_effect = __fx_cfg.motion_blur;
				_uniform = __PPF_SU.motion_blur;
				
				__stack_index++;
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
					shader_set(__PPF_SH_MOTION_BLUR);
					shader_set_uniform_f(_uniform.u_time_n_intensity, __time, __global_intensity);
					shader_set_uniform_f(_uniform.angle, _effect.angle);
					shader_set_uniform_f(_uniform.radius, _effect.radius);
					shader_set_uniform_f_array(_uniform.center, _effect.center);
					shader_set_uniform_f(_uniform.mask_power, _effect.mask_power);
					shader_set_uniform_f(_uniform.mask_scale, _effect.mask_scale);
					shader_set_uniform_f(_uniform.mask_smoothness, _effect.mask_smoothness);
					texture_set_stage(_uniform.overlay_texture, _effect.overlay_texture);
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
			}
			#endregion
			
			#region Stack 8 - Radial Blur
			_effect = __fx_cfg.radial_blur;
			_uniform = __PPF_SU.radial_blur;
			
			if (__fx_cfg.radial_blur.enabledd) {
				__stack_index++;
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
				 	shader_set(__PPF_SH_RADIAL_BLUR);
					shader_set_uniform_f(_uniform.u_time_n_intensity, __time, __global_intensity);
					shader_set_uniform_f(_uniform.radius, _effect.radius);
					shader_set_uniform_f_array(_uniform.center, _effect.center);
					shader_set_uniform_f(_uniform.inner, _effect.inner);
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
			}
			#endregion
			
			#region Stack 9 - Color Grading [persistent]
			if (!__skip_stack_list[1]) {
				__stack_index++;
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
				
					shader_set(__PPF_SH_COLOR_GRADING);
					shader_set_uniform_f(__PPF_SU.color_grading.pos_res, x, y, screen_width, screen_height);
					shader_set_uniform_f(__PPF_SU.color_grading.u_time_n_intensity, __time, __global_intensity);
					shader_set_uniform_f_array(__PPF_SU.color_grading.enabledd, [
						__fx_cfg.lens_distortion.enabledd,
						__fx_cfg.lut.enabledd,
						__fx_cfg.exposure.enabledd,
						__fx_cfg.brightness.enabledd,
						__fx_cfg.contrast.enabledd,
						__fx_cfg.shadow_midtone_highlight.enabledd,
						__fx_cfg.saturation.enabledd,
						__fx_cfg.hue_shift.enabledd,
						__fx_cfg.color_tint.enabledd,
						__fx_cfg.colorize.enabledd,
						__fx_cfg.posterization.enabledd,
						__fx_cfg.invert_colors.enabledd,
						__fx_cfg.texture_overlay.enabledd,
						__fx_cfg.lift_gamma_gain.enabledd,
						__fx_cfg.tone_mapping.enabledd,
						__fx_cfg.border.enabledd,
					]);
				
					// > [d] effect: lens_distortion
					if (__fx_cfg.lens_distortion.enabledd) {
						shader_set_uniform_f(__PPF_SU.lens_distortion.amount_c, __fx_cfg.lens_distortion.amount);
					}
					// > effect: lut
					if (__fx_cfg.lut.enabledd) {
						texture_set_stage(__PPF_SU.lut.tex_lookup, __fx_cfg.lut.texture);
						shader_set_uniform_f(__PPF_SU.lut.intensity, __fx_cfg.lut.intensity);
						shader_set_uniform_f_array(__PPF_SU.lut.size, __fx_cfg.lut.size);
						shader_set_uniform_f(__PPF_SU.lut.squares, __fx_cfg.lut.squares);
					}
					// > effect: exposure
					if (__fx_cfg.exposure.enabledd) {
						shader_set_uniform_f(__PPF_SU.exposure.value, __fx_cfg.exposure.value);
					}
					// > effect: brightness
					if (__fx_cfg.brightness.enabledd) {
						shader_set_uniform_f(__PPF_SU.brightness.value, __fx_cfg.brightness.value);
					}
					// > effect: contrast
					if (__fx_cfg.contrast.enabledd) {
						shader_set_uniform_f(__PPF_SU.contrast.value, __fx_cfg.contrast.value);
					}
					// > effect: shadow_midtone_highlight
					if (__fx_cfg.shadow_midtone_highlight.enabledd) {
						shader_set_uniform_f_array(__PPF_SU.shadow_midtone_highlight.shadow_color, __fx_cfg.shadow_midtone_highlight.shadow_color);
						shader_set_uniform_f_array(__PPF_SU.shadow_midtone_highlight.midtone_color, __fx_cfg.shadow_midtone_highlight.midtone_color);
						shader_set_uniform_f_array(__PPF_SU.shadow_midtone_highlight.highlight_color, __fx_cfg.shadow_midtone_highlight.highlight_color);
						shader_set_uniform_f(__PPF_SU.shadow_midtone_highlight.shadow_range, __fx_cfg.shadow_midtone_highlight.shadow_range);
						shader_set_uniform_f(__PPF_SU.shadow_midtone_highlight.highlight_range, __fx_cfg.shadow_midtone_highlight.highlight_range);
					}
					// > effect: saturation
					if (__fx_cfg.saturation.enabledd) {
						shader_set_uniform_f(__PPF_SU.saturation.value, __fx_cfg.saturation.value);
					}
					// > effect: hue_shift
					if (__fx_cfg.hue_shift.enabledd) {
						shader_set_uniform_f(__PPF_SU.hue_shift.hsv, __fx_cfg.hue_shift.hue/255, __fx_cfg.hue_shift.saturation/255, 1);
					}
					// > effect: color_tint
					if (__fx_cfg.color_tint.enabledd) {
						shader_set_uniform_f_array(__PPF_SU.color_tint.color, __fx_cfg.color_tint.color);
					}
					// > effect: colorize
					if (__fx_cfg.colorize.enabledd) {
						shader_set_uniform_f(__PPF_SU.colorize.hsv, __fx_cfg.colorize.hue/255, __fx_cfg.colorize.saturation/255, __fx_cfg.colorize.value/255);
						shader_set_uniform_f(__PPF_SU.colorize.intensity, __fx_cfg.colorize.intensity);
					}
					// > effect: posterization
					if (__fx_cfg.posterization.enabledd) {
						shader_set_uniform_f(__PPF_SU.posterization.color_factor, __fx_cfg.posterization.color_factor);
					}
					// > effect: invert_colors
					if (__fx_cfg.invert_colors.enabledd) {
						shader_set_uniform_f(__PPF_SU.invert_colors.intensity, __fx_cfg.invert_colors.intensity);
					}
					// > effect: texture_overlay
					if (__fx_cfg.texture_overlay.enabledd) {
						shader_set_uniform_f(__PPF_SU.texture_overlay.intensity, __fx_cfg.texture_overlay.intensity);
						shader_set_uniform_f(__PPF_SU.texture_overlay.zoom, __fx_cfg.texture_overlay.zoom);
						texture_set_stage(__PPF_SU.texture_overlay.texture, __fx_cfg.texture_overlay.texture);
					}
					// > effect: lift_gamma_gain
					if (__fx_cfg.lift_gamma_gain.enabledd) {
						shader_set_uniform_f_array(__PPF_SU.lift_gamma_gain.lift, __fx_cfg.lift_gamma_gain.lift);
						shader_set_uniform_f_array(__PPF_SU.lift_gamma_gain.gamma, __fx_cfg.lift_gamma_gain.gamma);
						shader_set_uniform_f_array(__PPF_SU.lift_gamma_gain.gain, __fx_cfg.lift_gamma_gain.gain);
					}
					// > effect: tone_mapping
					if (__fx_cfg.tone_mapping.enabledd) {
						shader_set_uniform_i(__PPF_SU.tone_mapping.mode, __fx_cfg.tone_mapping.mode);
					}
					// > [d] effect: border
					if (__fx_cfg.border.enabledd) {
						shader_set_uniform_f(__PPF_SU.border.curvature_c, __fx_cfg.border.curvature);
						shader_set_uniform_f(__PPF_SU.border.smooth_c, __fx_cfg.border.smooth);
						shader_set_uniform_f_array(__PPF_SU.border.colorr_c, __fx_cfg.border.colorr);
					}
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					shader_reset();
				
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
			}
			#endregion
			
			#region Stack 10 - Palette Swap
			_effect = __fx_cfg.palette_swap;
			_uniform = __PPF_SU.palette_swap;
			
			if (_effect.enabledd) {
				__stack_index++;
				var _cur_aa_filter = gpu_get_tex_filter();
				gpu_set_tex_filter_ext(__PPF_SU.palette_swap.texture, !_effect.limit_colors);
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
					shader_set(__PPF_SH_PALETTE_SWAP);
					shader_set_uniform_f(_uniform.u_time_n_intensity, __time, __global_intensity);
					shader_set_uniform_f(_uniform.row, _effect.row);
					shader_set_uniform_f(_uniform.pal_height, _effect.pal_height);
					shader_set_uniform_f(_uniform.threshold, _effect.threshold);
					shader_set_uniform_f(_uniform.flip, _effect.flip);
					texture_set_stage(_uniform.texture, _effect.texture);
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
				gpu_set_tex_filter(_cur_aa_filter);
			}
			#endregion
			
			#region Stack 11 - Kawase Blur
			if (__fx_cfg.kawase_blur.enabledd) {
				_effect = __fx_cfg.kawase_blur;
				_uniform = __PPF_SU.kawase_blur;
				
				// sets
				var _ds = _effect.downscale,
				_amount = _effect.amount,
				_iterations = clamp(__fx_cfg.kawase_blur.iterations * _amount, 1, 8),
				_ww = screen_width, _hh = screen_height,
				
				_source = __stack_surface[__stack_index],
				_current_destination = _source,
				_current_source = _source,
				
				_cur_aa_filter = gpu_get_tex_filter();
				
				gpu_set_tex_filter(true);
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
				
				// downsampling
				var i = 0;
				repeat(_iterations) {
					_ww /= _ds;
					_hh /= _ds;
					_ww -= frac(_ww);
					_hh -= frac(_hh);
					//if (min(_ww, _hh) < 2) break;
					if (_ww < 2 || _hh < 2) break;
					if !surface_exists(__kawase_blur_surface[i]) {
						__kawase_blur_surface[i] = surface_create(_ww, _hh);
					}
					_current_destination = __kawase_blur_surface[i];
					
					// blit
					surface_set_target(_current_destination);
						shader_set(__PPF_SH_DS_BOX13);
						shader_set_uniform_f(__PPF_SU.downsample_box13_res, _ww, _hh);
						draw_surface_stretched(_current_source, 0, 0, surface_get_width(_current_destination), surface_get_height(_current_destination));
						shader_reset();
					surface_reset_target();
					
					_current_source = _current_destination;
					++i;
				}
				
				// upsampling
				for(i -= 2; i >= 0; i--) {
					_current_destination = __kawase_blur_surface[i];
					
					// blit
					_ww = surface_get_width(_current_destination);
					_hh = surface_get_height(_current_destination);
					surface_set_target(_current_destination);
						shader_set(__PPF_SH_US_TENT9);
						shader_set_uniform_f(__PPF_SU.upsample_tent_res, _ww, _hh);
						draw_surface_stretched(_current_source, 0, 0, _ww, _hh);
						shader_reset();
					surface_reset_target();
					
					_current_source = _current_destination;
				}
				
				__stack_index++;
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					
					shader_set(__PPF_SH_KAWASE_BLUR);
					shader_set_uniform_f(_uniform.u_time_n_intensity, __time, __global_intensity);
					shader_set_uniform_f(_uniform.mask_power, _effect.mask_power);
					shader_set_uniform_f(_uniform.mask_scale, _effect.mask_scale);
					shader_set_uniform_f(_uniform.mask_smoothness, _effect.mask_smoothness);
					texture_set_stage(_uniform.blur_tex, surface_get_texture(_current_destination));
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					shader_reset();
					
					surface_reset_target();
				}
				gpu_set_blendmode(bm_normal);
				gpu_set_tex_filter(_cur_aa_filter);
			}
			#endregion
			
			#region Stack 12 - Gaussian Blur
			if (__fx_cfg.gaussian_blur.enabledd) {
				var _source = __stack_surface[__stack_index],
				_ds = clamp(__fx_cfg.gaussian_blur.downscale, 0.1, 1),
				_ww = screen_width*_ds, _hh = screen_height*_ds,
				
				_cur_aa_filter = gpu_get_tex_filter();
				gpu_set_tex_filter(true);
				
				if (__gaussian_blur_downscale != _ds) {
					__ppf_surface_delete(__gaussian_blur_ping_surface);
					__ppf_surface_delete(__gaussian_blur_pong_surface);
					__gaussian_blur_downscale = _ds;
				}
				if !surface_exists(__gaussian_blur_ping_surface) {
					__gaussian_blur_ping_surface = surface_create(_ww, _hh);
					__gaussian_blur_pong_surface = surface_create(_ww/2, _hh/2);
				}
				
				gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
				shader_set(__PPF_SH_GAUSSIAN_BLUR);
				shader_set_uniform_f(__PPF_SU.gaussian_blur.resolution, _ww, _hh);
				shader_set_uniform_f(__PPF_SU.gaussian_blur.u_time_n_intensity, __time, __global_intensity);
				shader_set_uniform_f(__PPF_SU.gaussian_blur.amount, __fx_cfg.gaussian_blur.amount);
				
				surface_set_target(__gaussian_blur_ping_surface);
				draw_clear_alpha(c_black, 0);
				draw_surface_stretched(_source, 0, 0, _ww, _hh);
				surface_reset_target();
				
				surface_set_target(__gaussian_blur_pong_surface);
				draw_clear_alpha(c_black, 0);
				draw_surface_stretched(__gaussian_blur_ping_surface, 0, 0, _ww/2, _hh/2);
				surface_reset_target();
				shader_reset();
				
				__stack_index++;
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					
					shader_set(__PPF_SH_GNMSK);
					shader_set_uniform_f(__PPF_SU.gnmask_power, __fx_cfg.gaussian_blur.mask_power);
					shader_set_uniform_f(__PPF_SU.gnmask_scale, __fx_cfg.gaussian_blur.mask_scale);
					shader_set_uniform_f(__PPF_SU.gnmask_smoothness, __fx_cfg.gaussian_blur.mask_smoothness);
					texture_set_stage(__PPF_SU.gnmask_texture, surface_get_texture(__gaussian_blur_pong_surface));
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					shader_reset();
					
					surface_reset_target();
				}
				gpu_set_blendmode(bm_normal);
				gpu_set_tex_filter(_cur_aa_filter);
			}
			#endregion
			
			#region Stack 13 - VHS
			if (__fx_cfg.vhs.enabledd) {
				var _cur_tex_repeat = gpu_get_tex_repeat();
				gpu_set_tex_repeat(true);
				
				__stack_index++;
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
					shader_set(__PPF_SH_VHS);
					//if __fx_cfg.lens_distortion.enabledd {
						//shader_set_uniform_f(__PPF_SU.lens_distortion.amount_v, __fx_cfg.lens_distortion.amount); // [d]
						//shader_set_uniform_f(__PPF_SU.vhs._lens_distortion_enable, __fx_cfg.lens_distortion.enabledd);
					//}
					shader_set_uniform_f(__PPF_SU.vhs.pos_res, x, y, screen_width, screen_height);
					shader_set_uniform_f(__PPF_SU.vhs.u_time_n_intensity, __time, __global_intensity);
					shader_set_uniform_f(__PPF_SU.vhs.chromatic_aberration, __fx_cfg.vhs.chromatic_aberration);
					shader_set_uniform_f(__PPF_SU.vhs.scan_aberration, __fx_cfg.vhs.scan_aberration);
					shader_set_uniform_f(__PPF_SU.vhs.grain_intensity, __fx_cfg.vhs.grain_intensity);
					shader_set_uniform_f(__PPF_SU.vhs.grain_height, __fx_cfg.vhs.grain_height);
					shader_set_uniform_f(__PPF_SU.vhs.grain_fade, __fx_cfg.vhs.grain_fade);
					shader_set_uniform_f(__PPF_SU.vhs.grain_amount, __fx_cfg.vhs.grain_amount);
					shader_set_uniform_f(__PPF_SU.vhs.grain_speed, __fx_cfg.vhs.grain_speed);
					shader_set_uniform_f(__PPF_SU.vhs.grain_interval, __fx_cfg.vhs.grain_interval);
					shader_set_uniform_f(__PPF_SU.vhs.scan_speed, __fx_cfg.vhs.scan_speed);
					shader_set_uniform_f(__PPF_SU.vhs.scan_size, __fx_cfg.vhs.scan_size);
					shader_set_uniform_f(__PPF_SU.vhs.scan_offset, __fx_cfg.vhs.scan_offset);
					shader_set_uniform_f(__PPF_SU.vhs.hscan_offset, __fx_cfg.vhs.hscan_offset);
					shader_set_uniform_f(__PPF_SU.vhs.flickering_intensity, __fx_cfg.vhs.flickering_intensity);
					shader_set_uniform_f(__PPF_SU.vhs.flickering_speed, __fx_cfg.vhs.flickering_speed);
					shader_set_uniform_f(__PPF_SU.vhs.wiggle_amplitude, __fx_cfg.vhs.wiggle_amplitude);
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
				
				gpu_set_tex_repeat(_cur_tex_repeat);
			}
			#endregion
			
			#region Stack 14 - Chromatic Aberration
			if (__fx_cfg.chromatic_aberration.enabledd) {
				__stack_index++;
				var _cur_aa_filter = gpu_get_tex_filter();
				gpu_set_tex_filter_ext(__PPF_SU.chromatic_aberration.prisma_lut_tex, false);
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
					
					shader_set(__PPF_SH_CHROMABER);
					shader_set_uniform_f(__PPF_SU.chromatic_aberration.pos_res, x, y, screen_width, screen_height);
					shader_set_uniform_f(__PPF_SU.chromatic_aberration.u_time_n_intensity, __time, __global_intensity);
					shader_set_uniform_f(__PPF_SU.chromatic_aberration.angle, __fx_cfg.chromatic_aberration.angle);
					shader_set_uniform_f(__PPF_SU.chromatic_aberration.intensity, __fx_cfg.chromatic_aberration.intensity);
					shader_set_uniform_f(__PPF_SU.chromatic_aberration.only_outer, __fx_cfg.chromatic_aberration.only_outer);
					shader_set_uniform_f(__PPF_SU.chromatic_aberration.center_radius, __fx_cfg.chromatic_aberration.center_radius);
					shader_set_uniform_f(__PPF_SU.chromatic_aberration.blur_enable, __fx_cfg.chromatic_aberration.blur_enable);
					texture_set_stage(__PPF_SU.chromatic_aberration.prisma_lut_tex, __fx_cfg.chromatic_aberration.prisma_lut_tex);
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
				gpu_set_tex_filter(_cur_aa_filter);
			}
			#endregion
			
			#region Stack 15 - Final [persistent]
			if (!__skip_stack_list[2]) {
				__stack_index++;
				if !surface_exists(__stack_surface[__stack_index]) {
					__stack_surface[__stack_index] = surface_create(screen_width, screen_height, __surface_tex_format);
				}
				surface_set_target(__stack_surface[__stack_index]) {
					draw_clear_alpha(c_black, 0);
					gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
				
					shader_set(__PPF_SH_FINAL);
					shader_set_uniform_f(__PPF_SU.base_final.pos_res, x, y, screen_width, screen_height);
					shader_set_uniform_f(__PPF_SU.base_final.u_time_n_intensity, __time, __global_intensity);
					shader_set_uniform_f_array(__PPF_SU.base_final.enabledd, [
						__fx_cfg.lens_distortion.enabledd,
						__fx_cfg.mist.enabledd,
						__fx_cfg.speedlines.enabledd,
						__fx_cfg.dithering.enabledd,
						__fx_cfg.noise_grain.enabledd,
						__fx_cfg.vignette.enabledd,
						__fx_cfg.nes_fade.enabledd,
						__fx_cfg.scanlines.enabledd,
						__fx_cfg.fade.enabledd,
						__fx_cfg.cinema_bars.enabledd,
						__fx_cfg.color_blindness.enabledd,
						__fx_cfg.channels.enabledd,
						__fx_cfg.border.enabledd,
					]);
				
					// > [d] effect: lens_distortion
					if (__fx_cfg.lens_distortion.enabledd) {
						shader_set_uniform_f(__PPF_SU.lens_distortion.amount_f, __fx_cfg.lens_distortion.amount);
					}
					// > effect: mist
					if (__fx_cfg.mist.enabledd) {
						shader_set_uniform_f(__PPF_SU.mist.intensity, __fx_cfg.mist.intensity);
						shader_set_uniform_f(__PPF_SU.mist.scale, __fx_cfg.mist.scale);
						shader_set_uniform_f(__PPF_SU.mist.tiling, __fx_cfg.mist.tiling);
						shader_set_uniform_f(__PPF_SU.mist.speedd, __fx_cfg.mist.speedd);
						shader_set_uniform_f(__PPF_SU.mist.angle, __fx_cfg.mist.angle);
						shader_set_uniform_f(__PPF_SU.mist.contrast, __fx_cfg.mist.contrast);
						shader_set_uniform_f(__PPF_SU.mist.powerr, __fx_cfg.mist.powerr);
						shader_set_uniform_f(__PPF_SU.mist.remap, __fx_cfg.mist.remap);
						shader_set_uniform_f_array(__PPF_SU.mist.colorr, __fx_cfg.mist.colorr);
						shader_set_uniform_f(__PPF_SU.mist.mix, __fx_cfg.mist.mix);
						shader_set_uniform_f(__PPF_SU.mist.mix_threshold, __fx_cfg.mist.mix_threshold);
						texture_set_stage(__PPF_SU.mist.noise_tex, __fx_cfg.mist.noise_tex);
						gpu_set_tex_repeat_ext(__PPF_SU.mist.noise_tex, true);
						shader_set_uniform_f_array(__PPF_SU.mist.offset, __fx_cfg.mist.offset);
						shader_set_uniform_f(__PPF_SU.mist.fade_amount, __fx_cfg.mist.fade_amount);
						shader_set_uniform_f(__PPF_SU.mist.fade_angle, __fx_cfg.mist.fade_angle);
					}
					// > effect: speedlines
					if (__fx_cfg.speedlines.enabledd) {
						shader_set_uniform_f(__PPF_SU.speedlines.scale, __fx_cfg.speedlines.scale);
						shader_set_uniform_f(__PPF_SU.speedlines.tiling, __fx_cfg.speedlines.tiling);
						shader_set_uniform_f(__PPF_SU.speedlines.speedd, __fx_cfg.speedlines.speedd);
						shader_set_uniform_f(__PPF_SU.speedlines.rot_speed, __fx_cfg.speedlines.rot_speed);
						shader_set_uniform_f(__PPF_SU.speedlines.contrast, __fx_cfg.speedlines.contrast);
						shader_set_uniform_f(__PPF_SU.speedlines.powerr, __fx_cfg.speedlines.powerr);
						shader_set_uniform_f(__PPF_SU.speedlines.remap, __fx_cfg.speedlines.remap);
						shader_set_uniform_f(__PPF_SU.speedlines.mask_power, __fx_cfg.speedlines.mask_power);
						shader_set_uniform_f(__PPF_SU.speedlines.mask_scale, __fx_cfg.speedlines.mask_scale);
						shader_set_uniform_f(__PPF_SU.speedlines.mask_smoothness, __fx_cfg.speedlines.mask_smoothness);
						shader_set_uniform_f_array(__PPF_SU.speedlines.colorr, __fx_cfg.speedlines.colorr);
						texture_set_stage(__PPF_SU.speedlines.noise_tex, __fx_cfg.speedlines.noise_tex);
						gpu_set_tex_repeat_ext(__PPF_SU.speedlines.noise_tex, true);
					}
					// > effect: dithering
					if (__fx_cfg.dithering.enabledd) {
						//gpu_set_tex_filter_ext(__PPF_SU.dithering.bayer_texture, false); // not working ???
						texture_set_stage(__PPF_SU.dithering.bayer_texture, __fx_cfg.dithering.bayer_texture);
						shader_set_uniform_f(__PPF_SU.dithering.threshold, __fx_cfg.dithering.threshold);
						shader_set_uniform_f(__PPF_SU.dithering.strength, __fx_cfg.dithering.strength);
						shader_set_uniform_f(__PPF_SU.dithering.mode, __fx_cfg.dithering.mode);
						shader_set_uniform_f(__PPF_SU.dithering.scale, __fx_cfg.dithering.scale);
						shader_set_uniform_f(__PPF_SU.dithering.bayer_size, __fx_cfg.dithering.bayer_size);
					}
					// > effect: noise_grain
					if (__fx_cfg.noise_grain.enabledd) {
						shader_set_uniform_f(__PPF_SU.noise_grain.intensity, __fx_cfg.noise_grain.intensity);
						shader_set_uniform_f(__PPF_SU.noise_grain.luminosity, __fx_cfg.noise_grain.luminosity);
						shader_set_uniform_f(__PPF_SU.noise_grain.scale, __fx_cfg.noise_grain.scale);
						shader_set_uniform_f(__PPF_SU.noise_grain.speedd, __fx_cfg.noise_grain.speedd);
						shader_set_uniform_f(__PPF_SU.noise_grain.mix, __fx_cfg.noise_grain.mix);
						texture_set_stage(__PPF_SU.noise_grain.noise_tex, __fx_cfg.noise_grain.noise_tex);
						gpu_set_tex_repeat_ext(__PPF_SU.noise_grain.noise_tex, true);
					}
					// > effect: vignette
					if (__fx_cfg.vignette.enabledd) {
						shader_set_uniform_f(__PPF_SU.vignette.intensity, __fx_cfg.vignette.intensity);
						shader_set_uniform_f(__PPF_SU.vignette.curvature, __fx_cfg.vignette.curvature);
						shader_set_uniform_f(__PPF_SU.vignette.inner, __fx_cfg.vignette.inner);
						shader_set_uniform_f(__PPF_SU.vignette.outer, __fx_cfg.vignette.outer);
						shader_set_uniform_f_array(__PPF_SU.vignette.colorr, __fx_cfg.vignette.colorr);
						shader_set_uniform_f_array(__PPF_SU.vignette.center, __fx_cfg.vignette.center);
						shader_set_uniform_f(__PPF_SU.vignette.rounded, __fx_cfg.vignette.rounded);
						shader_set_uniform_f(__PPF_SU.vignette.linear, __fx_cfg.vignette.linear);
					}
					// > effect: nes_fade
					if (__fx_cfg.nes_fade.enabledd) {
						shader_set_uniform_f(__PPF_SU.nes_fade.amount, __fx_cfg.nes_fade.amount);
						shader_set_uniform_f(__PPF_SU.nes_fade.levels, __fx_cfg.nes_fade.levels);
					}
					// > effect: scanlines
					if (__fx_cfg.scanlines.enabledd) {
						shader_set_uniform_f(__PPF_SU.scanlines.intensity, __fx_cfg.scanlines.intensity);
						shader_set_uniform_f(__PPF_SU.scanlines.speedd, __fx_cfg.scanlines.speedd);
						shader_set_uniform_f(__PPF_SU.scanlines.amount, __fx_cfg.scanlines.amount);
						shader_set_uniform_f_array(__PPF_SU.scanlines.colorr, __fx_cfg.scanlines.colorr);
						shader_set_uniform_f(__PPF_SU.scanlines.mask_power, __fx_cfg.scanlines.mask_power);
						shader_set_uniform_f(__PPF_SU.scanlines.mask_scale, __fx_cfg.scanlines.mask_scale);
						shader_set_uniform_f(__PPF_SU.scanlines.mask_smoothness, __fx_cfg.scanlines.mask_smoothness);
					}
					// > effect: fade
					if (__fx_cfg.fade.enabledd) {
						shader_set_uniform_f(__PPF_SU.fade.amount, __fx_cfg.fade.amount);
						shader_set_uniform_f_array(__PPF_SU.fade.colorr, __fx_cfg.fade.colorr);
					}
					// > effect: cinema_bars
					if (__fx_cfg.cinema_bars.enabledd) {
						shader_set_uniform_f(__PPF_SU.cinema_bars.amount, __fx_cfg.cinema_bars.amount);
						shader_set_uniform_f_array(__PPF_SU.cinema_bars.colorr, __fx_cfg.cinema_bars.colorr);
						shader_set_uniform_f(__PPF_SU.cinema_bars.vertical_enable, __fx_cfg.cinema_bars.vertical_enable);
						shader_set_uniform_f(__PPF_SU.cinema_bars.horizontal_enable, __fx_cfg.cinema_bars.horizontal_enable);
						shader_set_uniform_f(__PPF_SU.cinema_bars.is_fixed, __fx_cfg.cinema_bars.is_fixed);
					}
					// > effect: color_blindness
					if (__fx_cfg.color_blindness.enabledd) {
						shader_set_uniform_f(__PPF_SU.color_blindness.mode, __fx_cfg.color_blindness.mode);
					}
					// > effect: channels
					if (__fx_cfg.channels.enabledd) {
						shader_set_uniform_f(__PPF_SU.channels.rgb, __fx_cfg.channels.red, __fx_cfg.channels.green, __fx_cfg.channels.blue);
					}
					// > [d] effect: border
					if (__fx_cfg.border.enabledd) {
						shader_set_uniform_f(__PPF_SU.border.curvature_f, __fx_cfg.border.curvature);
						shader_set_uniform_f(__PPF_SU.border.smooth_f, __fx_cfg.border.smooth);
						shader_set_uniform_f_array(__PPF_SU.border.colorr_f, __fx_cfg.border.colorr);
					}
					draw_surface_stretched(__stack_surface[__stack_index-1], 0, 0, screen_width, screen_height);
					shader_reset();
					
					gpu_set_blendmode(bm_normal);
					surface_reset_target();
				}
			}
			#endregion
			
			// final render
			gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
			if (__is_draw_enabled) draw_surface_stretched(__stack_surface[__stack_index], x, y, w, h);
			//gpu_set_blendmode(_sys_blendmode);
			//draw_text(x+20, y+h-40, __stack_surface);
		} else {
			// default surface render
			gpu_set_blendenable(false);
			if (__is_draw_enabled) draw_surface_stretched(surface, x, y, w, h);
		}
		gpu_set_blendenable(_sys_blendenable);
		gpu_set_blendmode(_sys_blendmode);
		gpu_set_tex_repeat(_sys_texrepeat);
		surface_depth_disable(_sys_depth_disable);
	}
	#endregion
}

/// @desc Check if post-processing system exists.
/// @param {Struct} pp_index The returned variable by ppfx_create().
/// @returns {Bool} description.
function ppfx_system_exists(pp_index) {
	return (is_struct(pp_index) && instanceof(pp_index) == "PPFX_System" && !pp_index.__destroyed);
}
