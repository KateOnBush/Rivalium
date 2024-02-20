// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.mouse = {

	update: function(){
	
		var cm = view_camera[view_current];
	
		var vecs = camera_2dpoint_to_vector(cm, window_mouse_get_x(), window_get_height() - window_mouse_get_y());

		var point = raycast_line_to_plane(vecs[1], vecs[0], new Vector3(0, 0 ,0), new Vector3(0, 0, 1));
		
		x = point.x;
		y = point.y;
	
	},

	get_x: function(){
	
		update();
		
		return x;
	
	},
		
	get_y: function(){
	
		update();
		
		return y;
	
	},

}

function screen_shake(aintensity, afrequency, aduration){

	with(obj_player){
		/*
		if abs(screenshake.frequency - afrequency)<10{
			screenshake.intensity += aintensity;
		} else screenshake.intensity = max(aintensity, screenshake.intensity);
		screenshake.frequency = max(afrequency, screenshake.frequency);
		screenshake.duration = aduration;
		*/
		
		ppfx_id.SetEffectParameter(FX_EFFECT.SHAKE, PP_SHAKE_SPEED, afrequency);
		ppfx_id.SetEffectParameter(FX_EFFECT.SHAKE, PP_SHAKE_MAGNITUDE, 0.006 * aintensity);
		createEvent(aduration, function(){
		
			ppfx_id.SetEffectParameter(FX_EFFECT.SHAKE, PP_SHAKE_SPEED, 0);
			ppfx_id.SetEffectParameter(FX_EFFECT.SHAKE, PP_SHAKE_MAGNITUDE, 0);
		
		}, obj_player)
		

	}

}

function camera_ultimate_zoom(amount, time, ease_in_func, easeintime, ease_out_func, easeouttime){
	
	with(obj_player){
	
		ultimate_zoom.amount = amount;
		ultimate_zoom.time = time;
		ultimate_zoom.easeinf = ease_in_func;
		ultimate_zoom.easeoutf = ease_in_func;
		ultimate_zoom.easeintime = easeintime;
		ultimate_zoom.easeouttime = easeouttime;
		ultimate_zoom._in = 0;
		ultimate_zoom._out = 0;
	
	}

}

function screen_shake_position(aintensity, afrequency, aduration, x, y){

	var nint = aintensity*min(200/point_distance(x, y, obj_player.x, obj_player.y), 1.3);
	screen_shake(nint, afrequency, aduration);

}
