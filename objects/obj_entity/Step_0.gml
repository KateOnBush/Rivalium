/// @description Insert description here
// You can write your code in this editor

if show_hp_timer > 0 {
	show_hp_timer -= dtime/60;
}
hp_blend = dtlerp(hp_blend, hp, 0.05);

if physics {

	//Physics
	
	my += grav*dtime;
	_x += mx*dtime;
	_y += my*dtime;

}

x = dtlerp(x, _x, .9);
y = dtlerp(y, _y, .9);