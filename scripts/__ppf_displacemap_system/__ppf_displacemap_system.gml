
/*-------------------------------------------------------------------------------------------------
	These functions are independent, so if you delete them from the asset, it will not interfere
	with other features of PPFX.
-------------------------------------------------------------------------------------------------*/

// Feather ignore all

/// @desc Create displacemap system id to be used by the other functions.
/// @returns {Struct}
function PPFX_DisplaceMapRenderer() constructor {
	__ppf_trace("Displacemap renderer created. From: " + object_get_name(other.object_index));
	
	__surf = -1;
	__displace_renderer_list = [];
	
	#region Public Methods
	
	/// @desc Destroy displacemap system, freeing it from memory.
	static Destroy = function() {
		__ppf_surface_delete(__surf);
	}
	
	/// @func AddObject(object)
	/// @desc Adds a displacemap object to the renderer. The system will call the Draw event of the added object whenever it exists.
	/// @param {Asset.GMObject} object Distortion object that will be used to call the Draw Event. Example: An object that renders rain with normal maps.
	static AddObject = function(object) {
		array_push(__displace_renderer_list, object);
	}
	
	/// @func RemoveObject(object)
	/// @desc This function removes a previously added renderer object.
	/// @param {Asset.GMObject} object The renderer object.
	static RemoveObject = function(object) {
		var _array = __displace_renderer_list;
		var i = 0, isize = array_length(_array);
		repeat(isize) {
			var _object = _array[i];
			if (_object == object) {
				array_delete(_array, i, 1); i -= 1;
				exit;
			}
			++i;
		}
	}
	
	/// @desc Get the surface used in the displacemap system. Used for debugging generally.
	/// @param {Struct} system_index description
	static GetSurface = function() {
		return __surf;
	}
	
	#endregion
	
	#region Render
	
	/// @func Render(pp_index, objects_array, camera)
	/// @desc Renderize displacemap surface. Please note that this will not draw the surface, only generate the content.
	/// Basically this function will call the Draw Event of the objects in the array and draw them on the surface.
	/// This surface will be sent to the post-processing system automatically.
	/// @param {Struct} pp_index The returned variable by "new PPFX_System()".
	/// @param {Id.Camera} camera Your current active camera id. You can use view_camera[0].
	static Render = function(pp_index, camera) {
		// Feather disable GM1044
		__ppf_exception(!ppfx_system_exists(pp_index), "Post-processing system does not exist.");
		
		var _cam = camera,
		_camx = camera_get_view_x(_cam),
		_camy = camera_get_view_y(_cam),
		_camw = camera_get_view_width(_cam),
		_camh = camera_get_view_height(_cam),
		_ww = surface_get_width(application_surface),
		_hh = surface_get_height(application_surface);
		
		// generate distortion surface
		if (_ww > 0 && _hh > 0) {
			var _old_blendmode = gpu_get_blendmode(),
			_old_tex_filter = gpu_get_tex_filter(),
			_old_tex_repeat = gpu_get_tex_repeat();
			
			if !surface_exists(__surf) {
				__surf = surface_create(_ww, _hh, global.__ppf_main_texture_format);
				// send "normal map" texture to ppfx (you only need to reference it once - when the surface is created, for example)
				pp_index.SetEffectParameter(FX_EFFECT.DISPLACEMAP, PP_DISPLACEMAP_TEXTURE, surface_get_texture(__surf));
			}
			surface_set_target(__surf);
				draw_clear(make_color_rgb(128, 128, 255));
				gpu_set_tex_filter(true);
				gpu_set_tex_repeat(false);
				//gpu_set_blendmode_ext(bm_dest_color, bm_src_color);
				camera_apply(_cam);
				
				var _array = __displace_renderer_list;
				var i = 0, isize = array_length(_array);
				repeat(isize) {
					// draw normal map sprites to distort screen
					with(_array[i]) {
						cam = _cam;
						cam_x = _camx;
						cam_y = _camy;
						cam_w = _camw;
						cam_h = _camh;
						width = _ww;
						height = _hh;
						event_perform(ev_draw, 0);
					}
					++i;
				}
				
				gpu_set_blendmode(_old_blendmode);
				gpu_set_tex_filter(_old_tex_filter);
				gpu_set_tex_repeat(_old_tex_repeat);
			surface_reset_target();
		}
	}
	
	#endregion
}

/// @desc Check if displacemap renderer exists
/// @param {Struct} system_index The returned variable by shockwave_create().
/// @returns {Bool}
function ppfx_displacemap_renderer_exists(system_index) {
	return (is_struct(system_index) && instanceof(system_index) == "PPFX_ShockwaveRenderer");
}
