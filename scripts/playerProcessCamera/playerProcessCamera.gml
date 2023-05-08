function playerProcessCamera(){

	var cam = camera.id;
	var camw = camera_get_view_width(cam);
	var camh = camera_get_view_height(cam)	
	var camx = camera_get_view_x(cam) + camw/2;
	var camy = camera_get_view_y(cam) + camh/2;

	var speedy = max(movvec.length()-6,0)*3.5*sin(ani * 8);
	var speedyx = lengthdir_x(speedy, ani*180/pi);
	var speedyy = lengthdir_y(speedy, ani*180/pi);
	var windx = 15*dsin(ani*1.1*180/pi)	
	var windy = 4*dsin(ani*0.3*180/pi)	

	var speedlarg = max(movvec.length()-6.5,0)*18;

	spdlarg = dtlerp(spdlarg, speedlarg, 0.05);

	screenshake.duration = max(screenshake.duration - global.dt/60, 0);

	ftimer = max(ftimer - global.dt/60, 0);

	if screenshake.duration > 0 and screenshake.frequency != 0 and ftimer == 0{

		var d = irandom(360);
		ftimer = 1/screenshake.frequency;
		var l = screenshake.intensity;
	
		ssx = lengthdir_x(l, d);
		ssy = lengthdir_y(l, d);

	} else if screenshake.duration == 0{

		ssx *= 0.9;
		ssy *= 0.9;
		screenshake.intensity = 0;
		screenshake.frequency = 0;

	} 

	var dir_camera = false;

	camera.x = dtlerp(camera.x, x+windx+speedyx+ssx+(dir_camera ? movvec.x*10 : 0), 0.1);
	camera.y = dtlerp(camera.y, y+windy+speedyy+ssy+(dir_camera ? movvec.y*10 : 0), 0.1);

	zoom -= 0.2*(mouse_wheel_down()-mouse_wheel_up())*dtime

	zoom = clamp(zoom, 0, 1)

	var z = (690+spdlarg*0.8)*(0.2 + (1-zoom)*0.8);

	var t = ultimate_zoom.time
	var ein = ultimate_zoom.easeintime;
	var eout = ultimate_zoom.easeouttime;
	var _in = ultimate_zoom._in;
	var _out = ultimate_zoom._out;

	if t > 0 {
	
		HUDalpha = dtlerp(HUDalpha, 0, 0.3);
	
		ultimate_zoom._in = min(ultimate_zoom._in + dtime/60, ein);
		var k = 0;
	
		k = ultimate_zoom.easeinf(_in/ein);
	
		if t <= eout{
		
			k = 1 - ultimate_zoom.easeoutf(_out/eout);
			ultimate_zoom._out = min(ultimate_zoom._out + dtime/60, eout);
	
		}
	
		camera.z = dtlerp(camera.z, z - k * ultimate_zoom.amount * z, 0.95);
	

	} else {
	
		camera.z = dtlerp(camera.z, z, 0.1);
		if HUDalpha < 1 HUDalpha = dtlerp(HUDalpha, 1, 0.3);
	}


	ultimate_zoom.time -= dtime/60;
	ultimate_zoom.time = max(ultimate_zoom.time, 0);


	camera.tilt = dtlerp(camera.tilt, clamp(movvec.x/8, -1, 1), 0.05)

	viewmat = matrix_build_lookat(camera.x, camera.y, -camera.z, camera.x, camera.y, 0, -0.005*camera.tilt, 1, 0);
	projmat = matrix_build_projection_perspective_fov(camera.fov, camw/camh, 3, 8000);

	camera_set_view_mat(camera.id, viewmat);
	camera_set_proj_mat(camera.id, projmat);

	camera_apply(camera.id);

}