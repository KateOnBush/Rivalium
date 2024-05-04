/// @description Insert description here
// You can write your code in this editor

var cam = view.id;
var camw = camera_get_view_width(cam);
var camh = camera_get_view_height(cam)	
var camx = camera_get_view_x(cam) + camw/2;
var camy = camera_get_view_y(cam) + camh/2;

ani = ani + dtime/60;

if (!spectating and instance_exists(obj_player)) {
	view.on = obj_player;	
}

if (instance_exists(view.on)) {

	var movvec = view.on.movvec;
	
	var speedy = max(movvec.length()-6,0)*3.5*sin(ani * 8);
	var speedyx = lengthdir_x(speedy, ani*180/pi);
	var speedyy = lengthdir_y(speedy, ani*180/pi);
	var windx = 15*dsin(ani*1.1*180/pi)	
	var windy = 4*dsin(ani*0.3*180/pi);

	var speedlarg = max(movvec.length()-6.5,0)*18;

	spdlarg = dtlerp(spdlarg, speedlarg, 0.05);

	var dir_camera = directional_camera;
	if (keyboard_check_released(ord("H"))) directional_camera = !directional_camera;

	view.x = dtlerp(view.x, view.on.x +windx+speedyx+(dir_camera ? movvec.x*10 : 0), 0.1);
	view.y = dtlerp(view.y, view.on.y - 32 + windy+speedyy+(dir_camera ? movvec.y*10 : 0), 0.1);

	var z = 1000+spdlarg*0.8;

	var t = ultimate_zoom.time;
	var ein = ultimate_zoom.easeintime;
	var eout = ultimate_zoom.easeouttime;
	var _in = ultimate_zoom._in;
	var _out = ultimate_zoom._out;

	if t > 0 {
	
		if (instance_exists(obj_player)) obj_player.HUDalpha = dtlerp(obj_player.HUDalpha, 0, 0.3);
	
		ultimate_zoom._in = min(ultimate_zoom._in + dtime/60, ein);
		var k = 0;
	
		k = ultimate_zoom.easeinf(_in/ein);
	
		if t <= eout{
		
			k = 1 - ultimate_zoom.easeoutf(_out/eout);
			ultimate_zoom._out = min(ultimate_zoom._out + dtime/60, eout);
	
		}
	
		view.z = dtlerp(view.z, z - k * ultimate_zoom.amount * z, 0.95);
	

	} else {
	
		view.z = dtlerp(view.z, z, 0.1);
		if (instance_exists(obj_player)) obj_player.HUDalpha = dtlerp(obj_player.HUDalpha, 1, 0.3);
	}


	ultimate_zoom.time -= dtime/60;
	ultimate_zoom.time = max(ultimate_zoom.time, 0);

	view.tilt = dtlerp(view.tilt, clamp(movvec.x/8, -1, 1), 0.05)

} else {

	view.tilt = dtlerp(view.tilt, 0, 0.05);
	view.z = dtlerp(view.z, 1000, 0.95);

}

viewmat = matrix_build_lookat(view.x, view.y, -view.z, view.x, view.y, 0, -0.005*view.tilt, 1, 0);
projmat = matrix_build_projection_perspective_fov(view.fov, camw/camh, 3, 8000);

camera_set_view_mat(view.id, viewmat);
camera_set_proj_mat(view.id, projmat);

camera_apply(view.id);