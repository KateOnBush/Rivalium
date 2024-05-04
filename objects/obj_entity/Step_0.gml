/// @description Insert description here
// You can write your code in this editor

if physics {

	//Physics
	
	my += grav*dtime;
	_x += mx*dtime;
	_y += my*dtime;

}

x = dtlerp(x, _x, .9);
y = dtlerp(y, _y, .9);