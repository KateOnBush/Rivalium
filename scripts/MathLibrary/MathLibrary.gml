#macro dtime global.dt
#macro fpstime global.__fps

function easeInOutQuad(x) {
	return x < 0.5 ? 2 * x * x : 1 - power(-2 * x + 2, 2) / 2;
}

function easeInOutSine(x) {
	return -(cos(pi * x) - 1) / 2;
}


function easeOutElastic(x) {
	var c4 = (2 * pi) / 3;
	return x == 0 ? 0 : (x == 1 ? 1 : power(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1);
}

function easeInOutExpo(x) {
return x == 0 ? 0
  : (x == 1
  ? 1
  : (x < 0.5 ? power(2, 20 * x - 10) / 2
  : (2 - power(2, -20 * x + 10)) / 2));
}


function easeInOutBack(x) {
var c1 = 1.70158;
var c2 = c1 * 1.525;

return x < 0.5
  ? (power(2 * x, 2) * ((c2 + 1) * 2 * x - c2)) / 2
  : (power(2 * x - 2, 2) * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2;
}

function easeInCirc(x) {
	
	return 1 - sqrt(1 - power(x, 2));
}

function easeInSixth(x){

	return x*x*x*x*x*x;

}


function is_between(argument0, argument1, argument2, argument3) {

	if argument3 and (argument1 == argument0 or argument1 == argument2) return true;

	if argument1 > argument0 and argument1 < argument2 return true;

	return false


}


function array_contains(array, element){
	
	for(var n = 0; n < array_length(array); n++){
	
		if element == array[n] return true;
	
	}
	
	return false;
	

}

function array_contains_compare(array, element, compare_func){
	
	for(var n = 0; n < array_length(array); n++){
	
		if compare_func(element, array[n]) return true;
	
	}
	
	return false;
	

}

function array_find_by_value(array, val){

	for(var n = 0; n < array_length(array); n++){
	
		if val == array[n] return n;
	
	}

	return -1;

}

function array_find_by_function(array, func){

	for(var n = 0; n < array_length(array); n++){
	
		if func(array[n]) return n;
	
	}

	return -1;

}

function dtlerp(a, b, n){

	return lerp(a, b, 1 - power(1 - n, global.dt));

}