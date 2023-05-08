/// @description Insert description here
// You can write your code in this editor

var hitcol = merge_color(c_white, c_red, hitind);

if dir==0 dir=1;

//draw_circle(rec_x, rec_y, 5, false)

draw_text(x, y - 96, fps);

if global.debugmode { 
	
	if mask_index draw_sprite(mask_index, 0, x, y);
	draw_set_color(c_aqua)
	draw_arrow(x, y, x+movvec.x*10, y+movvec.y*10, 5);

}

draw_set_color(c_red)
if state == PLAYER_STATE.GRAPPLED or state == PLAYER_STATE.GRAPPLE_THROW draw_line(x, y, grappling_coords[0],grappling_coords[1])

/*matrix_set(matrix_world, matrix_build(x,y,0,0,mousex/10,0,10,10,10))

mesh.zabi.Render();

matrix_set(matrix_world, matrix_build(0,0,0,0,0,0,1,1,1))*/

for(var e = array_length(sortedframe)-1; e >= 0;e--){

	var i = sortedframe[e];

	var scale = currentframe[i][1];
	
	draw_sprite_ext(sprite,i,x+pos[i][0], y+pos[i][1], dir, scale, pos[i][2]*dir,c_white, invisible_blend)

}

for(var o = 0; o < array_length(char.attach); o++){

	var l = movvec.length();
	var d = movvec.dir();
	var att = char.attach[o];
	var w = char.attach[o][3];
	
	var _x = pos[att[4]][0];
	var _y = pos[att[4]][1];
	
	draw_sprite_ext(att[0],0,x+att[1]+_x,y+att[2]+_y,dir,1,w*clamp(l/18,0,1)*angle_difference(d+180+sin(ani*4)*8,-90),c_white, invisible_blend)
	
	
}

for(var n = 0; n < array_length(filters); n++){

	var spr = filters[n].sprite;
	var a = filters[n].alpha*filters[n].maxalpha;
	
	for(var i = sprite_get_number(sprite)-1; i >= 0;i--){
	
		var scale = currentframe[i][1];
		draw_sprite_ext(spr,i,x+pos[i][0],y+pos[i][1],dir,scale,pos[i][2]*dir,hitcol, a * invisible_blend)
	
	}

}



