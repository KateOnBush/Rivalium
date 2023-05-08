
/// @desc Generate RGB color array to be usable in Post-Processing FX.
/// @param {Real} color The color. Example: c_white, make_color_rgb, make_color_hsv, #ffffff.
/// @returns {Array<Real>}
function make_color_ppfx(color) {
	gml_pragma("forceinline");
	return [color_get_red(color)/255, color_get_green(color)/255, color_get_blue(color)/255];
}

/// @desc Generate HDR RGB color array to be usable in Post-Processing FX.
/// @param {Real} color The color. Example: c_white, make_color_rgb, make_color_hsv, #ffffff.
/// @param {Real} intensity The color multiplier intensity. 1 is default.
/// @returns {Array<Real>}
function make_color_hdr_ppfx(color, intensity=1) {
	gml_pragma("forceinline");
	return [(color_get_red(color)/255)*intensity, (color_get_green(color)/255)*intensity, (color_get_blue(color)/255)*intensity];
}

/// @desc Generate RGB color array to be usable in Post-Processing FX. Only RGB colors supported.
/// @param {Real} red Red Color
/// @param {Real} green Green Color
/// @param {Real} blue Blur Color
/// @returns {Array<Real>}
function make_color_rgb_ppfx(red, green, blue) {
	gml_pragma("forceinline");
	return [red/255, green/255, blue/255];
}

/// @desc Generate RGB color array to be usable in Post-Processing FX. Only RGB colors supported. With intensity, for HDR.
/// @param {Real} red Red Color
/// @param {Real} green Green Color
/// @param {Real} blue Blur Color
/// @returns {Array<Real>}
function make_color_rgb_hdr_ppfx(red, green, blue, intensity) {
	gml_pragma("forceinline");
	return [(red/255)*intensity, (green/255)*intensity, (blue/255)*intensity];
}


/// @ignore
/// @func __ppf_trace(text)
/// @param {String} text
function __ppf_trace(text) {
	gml_pragma("forceinline");
	if (PPFX_CFG_TRACE_ENABLE) show_debug_message("# PPFX >> " + string(text));
}

/// @ignore
function __ppf_exception(condition, text) {
	gml_pragma("forceinline");
	if (PPFX_CFG_ERROR_CHECKING_ENABLE && condition) {
		// the loop below doesn't always run...
		var _stack = debug_get_callstack(4), _txt = "";
		var _len = array_length(_stack);
		for(var i = _len-2; i > 0; --i) _txt += string(_stack[i]) + "\n";
		show_error("Post-Processing FX >> " + string(text) + "\n\n\n" + _txt + "\n\n", true);
	}
}

/// @ignore
function __ppf_struct_copy(src, dest) {
	gml_pragma("forceinline");
	if is_struct(src) {
		var _names = variable_struct_get_names(src);
		var _size = array_length(_names), i = _size-1;
		repeat(_size) {
			var _name = _names[i];
			dest[$ _name] = src[$ _name];
			--i;
		}
	}
}


/// @ignore
#macro __PPF_PASS_BLOOM_PREFILTER 0
#macro __PPF_PASS_DS_BOX4 1
#macro __PPF_PASS_DS_BOX13 2
#macro __PPF_PASS_US_TENT9 3

#macro __PPF_PASS_DOF_COC 4
#macro __PPF_PASS_DOF_BOKEH 5
global.__ppf_sample_passes = [
	// BLOOM pre filter box down 4 pass
	function(data) {
		gml_pragma("forceinline");
		shader_set(__PPF_SH_BLOOM_PRE_FILTER);
		shader_set_uniform_f(__PPF_SU.bloom.pre_filter_res, data.ww, data.hh);
		shader_set_uniform_f(__PPF_SU.bloom.pre_filter_threshold, data.threshold);
		shader_set_uniform_f(__PPF_SU.bloom.pre_filter_intensity, data.intensity);
	},
	// box down 4 pass
	function(data) {
		gml_pragma("forceinline");
		shader_set(__PPF_SH_DS_BOX4);
		shader_set_uniform_f(__PPF_SU.downsample_box4_res, data.ww, data.hh);
	},
	// box down 13 pass
	function(data) {
		gml_pragma("forceinline");
		shader_set(__PPF_SH_DS_BOX13);
		shader_set_uniform_f(__PPF_SU.downsample_box13_res, data.ww, data.hh);
	},
	// tent up 9 pass
	function(data) {
		gml_pragma("forceinline");
		shader_set(__PPF_SH_US_TENT9);
		shader_set_uniform_f(__PPF_SU.upsample_tent_res, data.ww, data.hh);
	},
	
	// DOF coc
	function(data) {
		gml_pragma("forceinline");
		shader_set(__PPF_SH_DOF_COC);
		shader_set_uniform_f(__PPF_SU.depth_of_field._coc_lens_distortion_enable, data.lens_distortion_enable); // [d]
		shader_set_uniform_f(__PPF_SU.lens_distortion.amount_d, data.lens_distortion_amount);
		shader_set_uniform_f(__PPF_SU.depth_of_field.coc_bokeh_radius, data.radius);
		shader_set_uniform_f(__PPF_SU.depth_of_field.coc_focus_distance, data.focus_distance);
		shader_set_uniform_f(__PPF_SU.depth_of_field.coc_focus_range, data.focus_range);
		shader_set_uniform_f(__PPF_SU.depth_of_field.coc_use_zdepth, data.use_zdepth);
		texture_set_stage(__PPF_SU.depth_of_field.coc_zdepth_tex, data.zdepth_tex);
	},
	// DOF bokeh
	function(data) {
		gml_pragma("forceinline");
		shader_set(__PPF_SH_DOF_BOKEH);
		shader_set_uniform_f(__PPF_SU.depth_of_field.bokeh_resolution, data.ww, data.hh);
		shader_set_uniform_f(__PPF_SU.depth_of_field.bokeh_time_n_intensity, data.time, data.global_intensity);
		shader_set_uniform_f(__PPF_SU.depth_of_field.bokeh_radius, data.radius);
		shader_set_uniform_f(__PPF_SU.depth_of_field.bokeh_intensity,  data.intensity);
		shader_set_uniform_f(__PPF_SU.depth_of_field.bokeh_shaped, data.shaped);
		shader_set_uniform_f(__PPF_SU.depth_of_field.bokeh_blades_aperture, data.blades_aperture);
		shader_set_uniform_f(__PPF_SU.depth_of_field.bokeh_blades_angle, data.blades_angle);
		shader_set_uniform_f(__PPF_SU.depth_of_field.bokeh_debug, data.debug);
		texture_set_stage(__PPF_SU.depth_of_field.bokeh_coc_tex, data.coc_tex);
	},
]
/// @ignore
function __ppf_surface_blit(source, dest, pass, pass_json_data) {
	gml_pragma("forceinline");
	surface_set_target(dest);
	global.__ppf_sample_passes[pass](pass_json_data);
	draw_surface_stretched(source, 0, 0, surface_get_width(dest), surface_get_height(dest));
	shader_reset();
	surface_reset_target();
}

/// @ignore
function __ppf_surface_blit_alpha(source, dest, pass, pass_json_data) {
	gml_pragma("forceinline");
	surface_set_target(dest);
	draw_clear_alpha(c_black, 0);
	global.__ppf_sample_passes[pass](pass_json_data);
	draw_surface_stretched(source, 0, 0, surface_get_width(dest), surface_get_height(dest));
	shader_reset();
	surface_reset_target();
}

/// @ignore
function __ppf_surface_delete_array(surfaces_array) {
	gml_pragma("forceinline");
	var i = 0, isize = array_length(surfaces_array), _surf = -1;
	repeat(isize) {
		_surf = surfaces_array[i];
		if surface_exists(_surf) surface_free(_surf);
		++i;
	}
}

/// @ignore
function __ppf_surface_delete(surface_index) {
	gml_pragma("forceinline");
	if surface_exists(surface_index) surface_free(surface_index);
}

/// @ignore
function __ppf_assert_and_func_array(func, values_array) {
	gml_pragma("forceinline");
	if !is_array(values_array) exit;
	var _sum = 0;
	var i = 0, isize = array_length(values_array);
	repeat(isize) {
		if func(values_array[i]) _sum++;
		++i;
	}
	return (_sum == isize);
}

/// @desc Check if is undefined (for ppfx usage only)
/// @param {Any} val Value
/// @returns {Bool}
/// @ignore
function __ppf_is_undefined(val) {
	return (val < 0 || val == undefined);
}


// temporary fix for application_get_position function while this function is not fixed by YYG
#macro application_get_position __mod_app_getpos
#macro __application_get_position application_get_position

/// @ignore
function __mod_app_getpos() {
	if (os_type != os_operagx) {
		return __application_get_position();
	} else {
		return [0, 0, display_get_gui_width(), display_get_gui_height()];
	}
}

