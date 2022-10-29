/// @description Insert description here
// You can write your code in this editor

if dir==0 dir=1;

draw_set_color(c_black)
if grappling draw_line(x,y,grappling_coords[0],grappling_coords[1])

var hitcol = merge_color(c_white, c_red, hitind);

draw_circle(mousex, mousey, 5, false);

var pos = [];

draw_sprite(s_healthbar, 0, x-50, y-64);
draw_sprite_part(s_healthbar, 1, 0, 0, 100*health_blend_red, 40, x-50, y-64);
draw_sprite_part(s_healthbar, 2, 0, 0, 100*health_blend, 40, x-50, y-64);
draw_sprite_part(s_healthbar, 3, 0, 0, 100*ultimatecharge_blend, 40, x-50, y-64);

for(var i = sprite_get_number(sprite)-1; i >= 0;i--){

	var bone = base[i];
	
	var rotation = currentframe[i];
	var coords = [bone[0],bone[1]];
	
	var _bone = base[i]
	
	var _parent = [], _parent_b = [];
	
	
	for(var n = i; _bone[2] != -1; n = _bone[2]){
	
		_parent = base[_bone[2]];
		_parent_b = _bone[2];
		
		var distance = point_distance(_parent[0],_parent[1],coords[0],coords[1]);
		var init_angle = point_direction(_parent[0],_parent[1],coords[0],coords[1]);
		
		coords = [_parent[0]+lengthdir_x(distance,init_angle+currentframe[_parent_b]),_parent[1]+lengthdir_y(distance,init_angle+currentframe[_parent_b])]
		rotation += currentframe[_parent_b];
	
		_bone = _parent;
	
	}
	
	var _last = array_length(currentframe)-1;
	
	pos[i] = [(coords[0]-offset[0])*dir+currentframe[_last-1],coords[1]-offset[1]+currentframe[_last],rotation];


}

for(var o = 0; o < array_length(char.attach); o++){

	var l = movvec.length();
	var d = movvec.dir();
	var att = char.attach[o];
	var w = char.attach[o][3];
	
	var _x = pos[att[4]][0] - base[att[4]][0];
	var _y = pos[att[4]][1] - base[att[4]][1];
	
	draw_sprite_ext(att[0],0,x+att[1]+_x,y+att[2]+_y,dir,1,w*clamp(l/18,0,1)*angle_difference(d+180+sin(ani*4)*8,-90),c_white,1)
	
	
}

var size = 1;

var midx = sprite_get_width(sprite)/2;
var midy = sprite_get_height(sprite)/2;

for(var i = sprite_get_number(sprite)-1; i >= 0;i--){
	
	var bone = base[i];
	
	var dist = point_distance(bone[0], bone[1], midx, midy)
	var ray = point_direction(bone[0], bone[1], midx, midy);
	var addx = lengthdir_x(dist, pos[i][2]+ray);
	var addy = lengthdir_y(dist, pos[i][2]+ray);
	
	pos[i][0] += addx*dir;
	pos[i][1] += addy;

	draw_sprite_ext(sprite,i,x+pos[i][0]*size,y+pos[i][1]*size-30*(size-1),dir*size,size,pos[i][2]*dir,hitcol,1)

}

for(var n = 0; n < array_length(filters); n++){

	var spr = filters[n].sprite;
	var a = filters[n].alpha*filters[n].maxalpha;
	
	for(var i = sprite_get_number(sprite)-1; i >= 0;i--){
	
		draw_sprite_ext(spr,i,x+pos[i][0]*size,y+pos[i][1]*size-30*(size-1),dir*size,size,pos[i][2]*dir,hitcol,a)
	
	}

}

