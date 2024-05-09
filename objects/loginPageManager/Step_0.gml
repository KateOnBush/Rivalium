/// @description Insert description here
// You can write your code in this editor

if loginSuccessful {
	
	animationTime += dtime/60;
	if animationStep == 0 {
		
		var target = room_width/2 - camera_get_view_width(cam)/2;
		var vx = dtlerp(camera_get_view_x(cam), target, 0.08);
		camera_set_view_pos(cam, vx, 0);
		
		var back_target = room_width/2 - camera_get_view_width(cam)/2;
		var bx = dtlerp(layer_get_x("Splash"), back_target, 0.08);
		layer_x("BackSplash", bx);
		layer_x("Splash", bx);
		layer_x("SplashLayer1", bx);
		layer_x("SplashLayer2", bx);
		
		if animationTime > stabilizeTime {
			animationStep = 1;
			animationTime = 0;
		}
		initWidth = camera_get_view_width(cam);
		initHeight = camera_get_view_height(cam);
	} else if animationStep == 1 or animationStep == 2 {
	
		var zoom = layer_get_fx("AnimationZoom")
		zoomIntensity = dtlerp(zoomIntensity, 1, 0.05);
		
		if zoomIntensity > 0.5 && animationStep == 1 {
			animationStep = 2;
			transition_to_room(roomMainProfile);
		}
		
		fx_set_parameter(zoom, "g_ZoomBlurIntensity", zoomIntensity);
		
	}
	
	
	exit;
} 

var target = global.loginSide ? 0 : room_width - camera_get_view_width(cam);
var vx = dtlerp(camera_get_view_x(cam), target, 0.08);

camera_set_view_pos(cam, vx, 0)

var offset = 0;
var back_target = global.loginSide ? offset : room_width - camera_get_view_width(cam) - offset;
var bx = camera_get_view_x(cam);
layer_x("BackSplash", bx);
layer_x("Splash", bx);
layer_x("SplashLayer1", bx);
layer_x("SplashLayer2", bx);
