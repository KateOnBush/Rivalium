/// @description Insert description here
// You can write your code in this editor

draw_sprite(s_healthbar, 0, x-50, y-64);
draw_sprite_part(s_healthbar, 1, 0, 0, 100*health_blend_red, 40, x-50, y-64);
draw_sprite_part(s_healthbar, 2, 0, 0, 100*health_blend, 40, x-50, y-64);
draw_sprite_part(s_healthbar, 3, 0, 0, 100*ultimatecharge_blend, 40, x-50, y-64);

var hitcol = merge_color(c_white, c_red, hitind);

if dir==0 dir=1;

//draw_circle(rec_x, rec_y, 5, false)

if global.debugmode { 
	
	draw_set_color(c_aqua)
	draw_arrow(x, y, x+movvec.x*10, y+movvec.y*10, 5);

}


draw_set_color(c_black)
if grappling draw_line(x,y,grappling_coords[0],grappling_coords[1])

/*matrix_set(matrix_world, matrix_build(x,y,0,0,mousex/10,0,100,100,100))

vertex_submit(global.modelzwin, pr_trianglestrip, sprite_get_texture(tMbow, -1));

matrix_set(matrix_world, matrix_build(0,0,0,0,0,0,1,1,1))*/


var _sortedframe = [];
var sort = false;
for(var i = 0; i < sprite_get_number(sprite); i++){
	_sortedframe[i] = i;
	if currentframe[i][4] > 0 sort = true;
}

if sort array_sort(_sortedframe, bone_depth_sorting);

for(var e = array_length(_sortedframe)-1; e >= 0;e--){

	var i = _sortedframe[e];

	var bone = base[i];
	
	var rotation = currentframe[i][0];
	var coords = [bone[0],bone[1]];
	
	var _bone = base[i]
	
	var _parent = [], _parent_b = 0;
	
	coords = calculate_bone_position(base, currentframe, i);
	
	var _last = array_length(currentframe)-1;
	
	pos[i] = [coords[0]*dir+currentframe[_last-3],coords[1]+currentframe[_last-2],rotation + coords[2]];
	
}

for(var o = 0; o < array_length(char.attach); o++){

	var l = movvec.length();
	var d = movvec.dir();
	var att = char.attach[o];
	var w = char.attach[o][3];
	
	var _x = pos[att[4]][0];
	var _y = pos[att[4]][1];
	
	draw_sprite_ext(att[0],0,x+att[1]+_x,y+att[2]+_y,dir,1,w*clamp(l/18,0,1)*angle_difference(d+180+sin(ani*4)*8,-90),c_white,1)
	
	
}

for(var e = array_length(_sortedframe)-1; e >= 0;e--){

	var i = _sortedframe[e];

	var scale = currentframe[i][1];
	
	draw_sprite_ext(sprite,i,x+pos[i][0], y+pos[i][1], dir, scale, pos[i][2]*dir,c_white,1)

}

for(var n = 0; n < array_length(filters); n++){

	var spr = filters[n].sprite;
	var a = filters[n].alpha*filters[n].maxalpha;
	
	for(var i = sprite_get_number(sprite)-1; i >= 0;i--){
	
		var scale = currentframe[i][1];
		draw_sprite_ext(spr,i,x+pos[i][0],y+pos[i][1],dir,scale,pos[i][2]*dir,hitcol,a)
	
	}

}



