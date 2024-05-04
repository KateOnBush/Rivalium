function playerDrawSimple(x, y, size = 1, alpha = 1){
	
	var xx = x, yy = y;

	for(var e = array_length(pos) - 1; e >= 0;e--){

		var i = sortedframe[e];

		var scale = currentframe[i][1];
	
		draw_sprite_ext(sprite,i, xx+pos[i][0] * size, yy+pos[i][1] * size, cdir*size, scale * size, pos[i][2]*cdir, c_white, alpha)

	}
	
}