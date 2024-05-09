/// @description Insert description here
// You can write your code in this editor

var dd = 0.48;
var dt = 0.1;

progress += (dtime/60) / 3;

var ww = 1920, hh = 1080;

if progress < dt {

	var mp = progress/dt;
	al = mp;
	disp = lerp(-ww/2, ww * dd, mp);

} else if progress > (1 - dt) {
	
	var mp = (progress - (1 - dt))/dt;
	al = 1 - mp;
	disp = lerp(ww * (1 - dd), ww + ww/2, mp);
	
} else {
	
	var mp = (progress - dt)/(1 - 2 * dt);
	al = 1;
	disp = lerp(ww * dd, ww * (1 - dd), mp);
	
}

if (progress > 1) {
	close_current_message();
	transition_to_room(roomGame);
}

disp1 = dtlerp(disp1, disp, 0.5);
disp2 = dtlerp(disp2, ww - disp, 0.5);