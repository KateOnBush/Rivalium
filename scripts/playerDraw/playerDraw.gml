function playerDraw(color, borderX){
	
	if invisible_blend < 0.01 return;
	
	if !surface_exists(playerSurf) playerSurf = surface_create(256, 256);

	surface_set_target(playerSurf);
	draw_clear_alpha(color, 0);

	var xx = 128, yy = 128;

	playerDrawSimple(xx, yy, 1);

	/*for(var o = 0; o < array_length(char.attach); o++){

		var l = movvec.length();
		var d = movvec.dir();
		var att = char.attach[o];
		var w = char.attach[o][3];
	
		var _x = pos[att[4]][0];
		var _y = pos[att[4]][1];
	
		draw_sprite_ext(att[0],0, xx+att[1]+_x, yy+att[2]+_y,cdir,1,w*clamp(l/18,0,1)*angle_difference(d+180+sin(ani*4)*8,-90),c_white, 1)
	
	
	}*/

	for(var n = 0; n < array_length(filters); n++){

		var spr = filters[n].sprite;
		var a = filters[n].alpha*filters[n].maxalpha;
	
		for(var i = sprite_get_number(sprite)-1; i >= 0;i--){
	
			var scale = currentframe[i][1];
			draw_sprite_ext(spr,i, xx+pos[i][0], yy+pos[i][1],cdir,scale,pos[i][2]*cdir, c_white, a)
	
		}

	}

	surface_reset_target();

	if borderX <= 0 {
		
		draw_surface_ext(playerSurf, x - xx, y - yy, 1, 1, 0, c_white, invisible_blend);
		
	} else {
	
		var texelW = texture_get_texel_width(surface_get_texture(playerSurf)),
		texelH = texture_get_texel_height(surface_get_texture(playerSurf));
		
		var upixelW = shader_get_uniform(RedBorderEnemy, "pixelW"),
			upixelH = shader_get_uniform(RedBorderEnemy, "pixelH");

		shader_set(RedBorderEnemy);
		shader_set_uniform_f(upixelW, texelW * borderX);
		shader_set_uniform_f(upixelH, texelH * borderX);

		draw_surface_ext(playerSurf, x - xx, y - yy, 1, 1, 0, c_white, invisible_blend);

		shader_reset();

	}
	

}