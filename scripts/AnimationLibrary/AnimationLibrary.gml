///animation_get_frame(animation, pos, quadratic)

#macro animation_type_full 0
#macro animation_type_partial 1

function empty_bone_base(i){

	return array_create(i, [0, 0, -1]);

}

function empty_bone(){

	return [0, 1 , 0, 0, 0]; //rot, scale, xoffset, yoffset, depth

}

function empty_frame(sprite){

	var arr = array_create(sprite_get_number(sprite)+4,empty_bone());
	
	arr[array_length(arr)-1] = 0;
	arr[array_length(arr)-2] = 0;
	arr[array_length(arr)-3] = 0;
	arr[array_length(arr)-4] = 0;
	
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
		
		var dot = (bone[0] - parent[0]) * lengthdir_x(1, _dir) + (bone[1] - parent[1]) * lengthdir_y(1, _dir);
		
		dot *= frame[parent_n][1] - 1;
		
		var dist = point_distance(parent[0], parent[1], bone[0], bone[1]);
		var angl = point_direction(parent[0], parent[1], bone[0], bone[1]);
		
		var rot = pos[2] + frame[parent_n][0];
		
		return [
		pos[0] + lengthdir_x(dist, angl + rot) + lengthdir_x(dot, _dir + frame[parent_n][0]) + frame[n][2], 
		pos[1] + lengthdir_y(dist, angl + rot) + lengthdir_y(dot, _dir + frame[parent_n][0]) + frame[n][3],
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
		var scale = lerp(frame1[p][1], frame2[p][1], pc);
		var xoffset, yoffset, dep;
		xoffset = lerp(frame1[p][2], frame2[p][2], pc);
		yoffset = lerp(frame1[p][3], frame2[p][3], pc);
		var de = frame2[p][4];
		
		nframe[p] = [d, scale, xoffset, yoffset, de];
			
			
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

function animation_construct(){

	var result = [];
	
	for(var s = 0; s < argument_count; s++){
	
		result[s] = argument[s];
	
	}
	
	return result;

}