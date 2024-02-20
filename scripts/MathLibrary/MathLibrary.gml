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
function easeInOutExpoEarly(x) {
	return x < 0.01 ? easeInOutExpo(min(x * 100, 1)) : 1;
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


function is_between(m, a, M, equals) {

	if equals && (m == a or M == a) return true;

	if a > m and a < M return true;

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

function array_join(array, join){

	var res = "";
	
	for(var i = 0; i < array_length(array); i++){
	
		res += string(array[i]) + (i != array_length(array)-1 ? join : "");
	
	}

	return res;

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

function angular_lerp(a, b, n){

	return a + angle_difference(b, a) * n;

}

function angular_dtlerp(a, b, n){

	return angular_lerp(a, b, 1 - power(1 - n, dtime));

}

function array_duplicate(array){

	var n = array_length(array);
	var nArr = array_create(n, 0);
	array_copy(nArr, 0, array, 0, n);

	return nArr;

}

function array_bubble_sort(arr, predicateFn) {
	
   var n = array_length(arr);
   var swapped = true;
  
   while (swapped) {
		swapped = false;
		for (var i = 0; i < n - 1; i++) {
			if (predicateFn(arr[i], arr[i + 1]) > 0) {
				var c = arr[i + 1];
				arr[i + 1] = arr[i];
				arr[i] = c;
				swapped = true;
			}
		}
		n--;
	};
  
	return arr;
}

function fibonnacciSequence(n) {
	return (n == 1 or n == 0 ? 1 : fibonnacciSequence(n - 1) + fibonnacciSequence(n - 2));	
}

function struct_get_key_failsafe(struct, keylist){

	var keyarr = string_split(keylist, ".", true);
	var select = struct;
	var i = 0;
	while(is_struct(select) && i < array_length(keyarr)) {
		select = select[$ keyarr[i]];
		i++;
	}
	return array_length(keyarr) == i ? select : undefined;

}