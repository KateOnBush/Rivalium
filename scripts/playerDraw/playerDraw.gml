function playerDraw(color, borderX){
	
	if invisible_blend < 0.01 return;
	
	var playerAlpha = 0.2 + invisible_blend * 0.8;

	for(var o = 0; o < array_length(char.attach); o++){

		var l = movvec.length();
		var d = movvec.dir();
		var att = char.attach[o];
		var w = char.attach[o][3];
		
		if (att[4] >= array_length(sortedframe)) continue;
	
		if (array_length(pos) <= att[4]) continue;
	
		var _x = pos[att[4]][0];
		var _y = pos[att[4]][1];
	
		draw_sprite_ext(att[0],0, x+att[1]+_x, y+att[2]+_y,cdir,1,w*clamp(l/18,0,1)*angle_difference(d+180+sin(ani*4)*8,-90),c_white, playerAlpha)
	
	
	}

	playerDrawSimple(x, y, 1, playerAlpha);

	for(var n = 0; n < array_length(filters); n++){

		var spr = filters[n].sprite;
		var a = filters[n].alpha*filters[n].maxalpha;
	
		for(var i = sprite_get_number(sprite)-1; i >= 0;i--){
	
			var scale = currentframe[i][1];
			draw_sprite_ext(spr,i, x+pos[i][0], y+pos[i][1],cdir,scale,pos[i][2]*cdir, c_white, a * playerAlpha)
	
		}

	}

}