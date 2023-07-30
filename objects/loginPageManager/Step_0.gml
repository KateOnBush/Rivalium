/// @description Insert description here
// You can write your code in this editor

var target = global.loginSide ? 0 : room_width - camera_get_view_width(cam);
var vx = dtlerp(camera_get_view_x(cam), target, 0.08);

camera_set_view_pos(cam, vx, 0)

var back_target = global.loginSide ? 100 : 320;
var bx = dtlerp(layer_get_x("Splash"), back_target, 0.08);
layer_x("Splash", bx);