/// @description Insert description here
// You can write your code in this editor


isHovering = is_hovering();
canScroll = maxY > (y + sprite_height);

if isHovering and canScroll {
	
	if mouse_wheel_down() {
		scrollYReal += scrollSens * 10 * dtime;
	}

	if mouse_wheel_up() {
		scrollYReal -= scrollSens * 10 * dtime;
	}
	
}

scrollYReal = clamp(scrollYReal, 0, max(maxY - sprite_height, 0));
scrollY = dtlerp(scrollY, scrollYReal, 0.3);