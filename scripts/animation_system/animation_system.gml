///animation_get_frame(animation, pos, quadratic)

#macro animation_type_full 0
#macro animation_type_partial 1

function animation_get_frame(anim, pos, quadratic) {

	var newframe;

	if !(pos >= 0 and pos < 1){

		pos = abs(pos) mod 1;

	}

	for(var o = 0; o < array_length(anim); o++){

		var current = anim[o];
		var next = anim[0]
		var next_p = 1;

		if o != array_length(anim)-1{
	
			next = anim[o+1]
			next_p = next[1]
	
		}
		
		if is_between(current[1],pos,next_p,true){
		
			var current_frame = current[0]
			var next_frame = next[0]
			new_frame = array_create(array_length(current_frame),0)
			for(var p = 0; p < array_length(current_frame); p++){
			
				var _x = (pos - current[1])/(next_p - current[1])
				var fx = _x < 0.5 ? 2 * _x * _x : 1 - power(-2 * _x + 2, 2) / 2;
				if !quadratic fx = _x;
				
				new_frame[p] = current_frame[p] - fx * angle_difference(current_frame[p],next_frame[p]);
				if p == array_length(current_frame)-1 or p == array_length(current_frame)-2 new_frame[p] = current_frame[p] - fx * (current_frame[p]-next_frame[p]);
			
			}
			
		
		}
		

	}

	return new_frame;



}


function animation_blend(frame1, frame2, pc){

	var newframe = [];
	for(var t = 0; t < array_length(frame1); t++){
	
		newframe[t] = frame1[t] - angle_difference(frame1[t],frame2[t])*pc;
		if t == array_length(frame1)-1 or t == array_length(frame1)-2{
		
			newframe[t] = lerp(frame1[t],frame2[t],pc);
		
		}
	
	}
	
	return newframe;

}

function animation_blend_partial(frame1, frame2, pc, bones){

	var newframe = []
	for(var t = 0; t < array_length(frame1); t++){
	
		newframe[t] = frame1[t]
	
	}
	for(var t = 0; t < array_length(bones); t++){
	
		newframe[bones[t]] = frame1[bones[t]] - angle_difference(frame1[bones[t]],frame2[bones[t]])*pc;
		if t == array_length(frame1)-1 or t == array_length(frame1)-2{
			newframe[bones[t]] = lerp(frame1[bones[t]], frame2[bones[t]], pc);
			
		}
	
	}
	
	return newframe;

}

function animation_construct(frames, timestamps){

	var result = [];
	
	if array_length(frames) != array_length(timestamps) return;
	
	for(var s = 0; s < array_length(frames); s++){
	
		result[s] = [frames[s], timestamps[s]];
	
	}
	
	return result;

}