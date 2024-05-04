/// @description Insert description here
// You can write your code in this editor

var dotProductGravity = - grav * lengthdir_y(1, direction + 90);
angular_speed += dotProductGravity * 0.1 * dtime;

movvec.y += grav*dtime;
if place_meeting(x + movvec.x, y + movvec.y, obj_solid) {
	movvec.x = 0; movvec.y = 0;
} else {
	x += movvec.x * dtime; y += movvec.y * dtime;
}

lifetime -= dtime/60;
image_alpha = min(1, lifetime);
if lifetime < 0 {
	instance_destroy();
}

angular_speed *= power(0.9, dtime);

rotation += angular_speed * dtime;
image_angle = rotation;
if place_meeting(x, y, obj_solid) {
	rotation -= angular_speed * dtime;
	image_angle = rotation;
	angular_speed -= angular_speed * dtime;
}