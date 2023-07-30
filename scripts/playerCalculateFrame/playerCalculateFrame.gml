function playerCalculateFrame(rotoff){

	var sort = false;
	for(var i = 0; i < sprite_get_number(sprite); i++){
		sortedframe[i] = i;
		if currentframe[i][4] > 0 sort = true;
	}

	if sort sortedframe = array_bubble_sort(sortedframe, bone_depth_sorting);
	cdir = dir;

	for(var e = array_length(sortedframe)-1; e >= 0; e--){

		var i = sortedframe[e];

		var bone = base[i];
	
		var rotation = currentframe[i][0];
		var coords = [bone[0],bone[1]];
	
		var _bone = base[i]
	
		var _parent = [], _parent_b = 0;
	
		coords = calculate_bone_position(base, currentframe, i);
	
		var _last = array_length(currentframe)-1;
		
		var _xx = coords[0],
			_yy = coords[1];
			
		var __dir = point_direction(0, 0, _xx, _yy),
			__dist = point_distance(0, 0, _xx, _yy);
			
		_xx = lengthdir_x(__dist, __dir + rotoff) * cdir + currentframe[_last-3];
		_yy = lengthdir_y(__dist, __dir + rotoff) + currentframe[_last-2];
	
		pos[i] = [_xx, _yy, rotation + coords[2] + rotoff];
	
	}

}