///animation_get_frame(animation, pos, quadratic)

#macro animation_type_full 0
#macro animation_type_partial 1

enum framestyle {

	linear,
	quadratic,
	backease,
	exponential

}

function empty_bone_base(i){

	return array_create(i, [0, 0, -1]);

}

function empty_bone(){

	return [0, 1, 0, 0, 0, 1]; //rot, hscale, xoffset, yoffset, depth, wscale

}

function empty_frame(sprite){

	var arr = array_create(sprite_get_number(sprite)+4,empty_bone()); //bones
	
	arr[array_length(arr)-1] = 0; //xoffset
	arr[array_length(arr)-2] = 0; //yoffset
	arr[array_length(arr)-3] = 0; //style
	arr[array_length(arr)-4] = 0; //timestamp
	
	return arr;
	

}

function empty_animation(sprite){
	
	return [empty_frame(sprite)];

}

function calculate_bone_position(base, frame, n){
	
	var bone = base[n];
	
	var parent_n = bone[2]
	
	if parent_n == -1 {
		
		return [base[n][0], base[n][1], 0];
		
	
	} else {
	
		var parent = base[parent_n];
		
		var pos = calculate_bone_position(base, frame, parent_n);
		
		var _dir = -90;
		
		var _doth = (bone[0] - parent[0]) * lengthdir_x(1, _dir) + (bone[1] - parent[1]) * lengthdir_y(1, _dir),
			_dotw = (bone[0] - parent[0]) * lengthdir_x(1, _dir + 90) + (bone[1] - parent[1]) * lengthdir_y(1, _dir + 90);
		
		var disth = _doth * frame[parent_n][1],
			distw = _dotw * frame[parent_n][5];
		
		var dist = point_distance(0, 0, distw, disth);
		var angl = point_direction(0, 0, distw, disth);
		
		var rot = pos[2] + frame[parent_n][0];
		
		return [
		pos[0] + lengthdir_x(dist, angl + rot) + frame[n][2],
		pos[1] + lengthdir_y(dist, angl + rot) + frame[n][3],
		rot
		]
		
	}

}

function animation_get_frame(anim, pos) {

	var newframe = [];

	if (pos < 0 or pos >= 1){

		pos = abs(pos) mod 1;

	}

	for(var o = 0; o < array_length(anim); o++){

		var current_frame = anim[o];
		var l = array_length(current_frame);
		
		var current_t = current_frame[l-1];
		var current_style = current_frame[l-2];
		
		var next_frame;
		var next_style;
		var next_t;
		
		if (o == array_length(anim)-1) {
		
			next_frame = anim[0];
			next_style = next_frame[l-2];
			next_t = 1;
			
		} else {
			next_frame = anim[o+1];
			next_style = next_frame[l-2];
			next_t = next_frame[l-1];
			
			if (pos > next_t) continue;
			
		}
		
		var ind = (pos - current_t)/(next_t - current_t);

		var style = ind > 0.5 ? next_style : current_style;
		
		if style == 1 ind = easeInOutQuad(ind);
		
		else if style == 2 ind = easeInOutBack(ind);
		
		else if style == 3 ind = easeInOutExpo(ind);

		newframe = animation_blend(current_frame, next_frame, ind);
		
		newframe[l-1] = pos;
		
		break;
		
		
	}
	
	return newframe;

}


function animation_blend(frame1, frame2, pc){

	var nframe = [];
	
	var l = array_length(frame1);
	
	for(var p = 0; p < l - 4; p++){

		var d = frame1[p][0] - pc * angle_difference(frame1[p][0], frame2[p][0]);
		var yscale = lerp(frame1[p][1], frame2[p][1], pc);
		var xoffset, yoffset, dep;
		xoffset = lerp(frame1[p][2], frame2[p][2], pc);
		yoffset = lerp(frame1[p][3], frame2[p][3], pc);
		var de = frame2[p][4];
		var xscale = lerp(frame1[p][5], frame2[p][5], pc);
		
		nframe[p] = [d, yscale, xoffset, yoffset, de, xscale];
			
			
	}
		
	nframe[l-3] = lerp(frame1[l-3], frame2[l-3], pc);
	nframe[l-4] = lerp(frame1[l-4], frame2[l-4], pc);
		
	nframe[l-1] = 0;
	
	return nframe;

}

function animation_blend_partial(frame1, frame2, pc, bones){

	var newframe = frame1, temparr = animation_blend(frame1, frame2, pc);
	
	for(var t = 0; t < array_length(bones); t++){
	
		newframe[bones[t]] = temparr[bones[t]];
	
	}
	
	return newframe;

}

function animation_construct(frames, keytimes, styles){

	var animation = [];
	
	var l = array_length(frames[0]);
	
	for(var i = 0; i < array_length(frames); i++){
	
		frames[i][l-1] = keytimes[i];
		frames[i][l-2] = styles[i];
		array_push(animation, frames[i]);
	
	}
	
	return animation;

}

function require_animation_file(path) {

	static loadedAnimations = {};
	
	if loadedAnimations[$ path] != undefined {
	
		return loadedAnimations[$ path];
	
	} else {
	
		try {
	
			var f = file_text_open_read(path);
			var str = file_text_read_string(f);
			
			loadedAnimations[$ path] = json_parse(base64_decode(str));
			
			file_text_close(f);
			
			return loadedAnimations[$ path];
	
		} catch(err){
	
			throw "Unable to load animation file: " + path;
		
		}
		
	}

}