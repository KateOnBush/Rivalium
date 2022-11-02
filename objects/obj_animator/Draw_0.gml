/// @description Insert description here
// You can write your code in this editor
//350,200

function update_frame(){

	currentframe = global.animation[global.selected_keyframe][0];

}

var midx = sprite_get_width(sprite)/2;
var midy = sprite_get_height(sprite)/2;

draw_set_font(font0)
var dep = 0;
var d = 20;
var addk = draw_button_simple(10,10,140,20,"Add keyframe")
dep+=d;
var delk = draw_button_simple(10,10+dep,140,20+dep,"Delete keyframe")
dep+=d;
var dupk = draw_button_simple(10,10+dep,140,20+dep,"Duplicate keyframe")
dep+=d;
var copycode = draw_button_simple(10,10+dep,140,20+dep,"Copy code")
dep+=d;
var saveanim = draw_button_simple(10,10+dep,140,20+dep,"Save animation")
dep+=d;
var openanim = draw_button_simple(10,10+dep,140,20+dep,"Open animation")
dep+=d;
var playanim = draw_button_simple(10,10+dep,140,20+dep,global.playing ? "Stop animation" : "Play animation")
dep+=d;
var setquad = draw_button_simple(10,10+dep,140,20+dep,play_quad ? "Set to linear" : "Set to quadratic")
dep+=d;
var setspd = draw_button_simple(10,10+dep,140,20+dep,"Set speed")
dep+=d;
var sbones = draw_button_simple(10,10+dep,140,20+dep,show_bones ? "Hide bones" : "Show bones")
dep+=d;
var resetpos = draw_button_simple(10,10+dep,140,20+dep,"Reset position")
dep+=d;
var resetbones = draw_button_simple(10,10+dep,140,20+dep,"Reset keyframe")
var resetx = draw_button_simple(150,10+dep,150+100,20+dep,"Reset X position")
var resety = draw_button_simple(260,10+dep,260+100,20+dep,"Reset Y position")
dep+=d;
var resetbon = draw_button_simple(10,10+dep,140,20+dep,"Reset bone")
var importtext = draw_button_simple(150,10+dep,150+150,20+dep,"Import from text");
dep+=d*1.5;
var resetani = draw_button_simple(10,10+dep,140,20+dep,"Reset Animation")
var changechar = draw_button_simple(150,10+dep,150+150,20+dep,"Change Character")

if changechar and !global.playing {

	var yes = get_integer("Character number: (THIS WILL RESET THE ANIMATION AND DELETE UNSAVED DATA)", 0);
	
	if yes != undefined {
	
		try{
	
			var sex = setupCharacterData()[yes];
			sprite = sex.sprite
			base = sex.base;
			currentframe = array_create(sprite_get_number(sprite)+2,0);
			pos = [];
			
			global.animation = [[array_create(sprite_get_number(sprite)+2,0),0]];
			global.selected_keyframe = 0;
			global.selected_bone = 0;
			update_frame();
			
		}catch(err){ show_message_async("Invalid character")};
	
	}

}

if importtext and !global.playing {

	var yes = get_string("Paste JSON data:","");
	
	try{
		
		var anim = json_parse(yes);
		//Testing the array
		var keyframe = anim[0];
		var temp = keyframe[1]+1;
		var value1 = keyframe[0][0]+1;
		
		global.animation = anim;
		global.selected_keyframe = 0;
		global.selected_bone = 0;
		update_frame();
		
	}catch(err){
	
		show_message_async("Invalid value!")
	
	}

}

for(var l = 0; l < sprite_get_number(sprite); l++){

	var t = draw_button_simple(390, 10+l*26, 390+24, 34+l*26, "");
	if global.selected_bone == l {
		
		draw_set_color(c_green);
		draw_rectangle(390, 10+l*26, 390+24, 34+l*26, false);
		draw_set_color(c_black)
	
	}
	draw_sprite_ext(sprite, l, 390+12-base[l][0]+midx, 22+l*26-base[l][1]+midy, 0.75, 0.75, 0, c_white, 1);
	if t {
	
		global.selected_bone = l;
	
	}
}


if resetani and !global.playing{

	global.animation = [[array_create(sprite_get_number(sprite)+2,0),0]]
	global.selected_keyframe = 0;
	update_frame();

}

if resetbon and !global.playing{

	global.animation[global.selected_keyframe][0][global.selected_bone] = 0;
	update_frame();

}

if resetpos and !global.playing{

	global.animation[global.selected_keyframe][0][array_length(global.animation[global.selected_keyframe][0])-1] = 0
	global.animation[global.selected_keyframe][0][array_length(global.animation[global.selected_keyframe][0])-2] = 0
	update_frame();

}

if resetx and !global.playing{

	global.animation[global.selected_keyframe][0][array_length(global.animation[global.selected_keyframe][0])-2] = 0
	update_frame();

}

if resety and !global.playing{

	global.animation[global.selected_keyframe][0][array_length(global.animation[global.selected_keyframe][0])-1] = 0
	update_frame();

}

if resetbones and !global.playing{

	global.animation[global.selected_keyframe][0] = array_create(array_length(global.animation[global.selected_keyframe][0]),0);
	update_frame();

}

if sbones show_bones = !show_bones;

if setspd {
	animspd = get_integer("Speed (default at 1) :",animspd)
	animspd ??= 1;
}



if setquad play_quad = !play_quad;

if saveanim and !global.playing {

	//New file system (json)
	var file = get_save_filename("animation file|*.anim","")
	if file!=""{
	
		var str = json_stringify(global.animation);
		var f = file_text_open_write(file);
		file_text_write_string(f, str);
		file_text_close(f);
	
	}

}

if openanim and !global.playing {

	var file = get_open_filename("animation file|*.anim","")
	if file!="" and file_exists(file){
	
		var f = file_text_open_read(file);
		var str = file_text_read_string(f);
		try{
			
			var t = json_parse(str);
			if typeof(t) != "array" throw "nig";
			global.animation = t;
			
		}catch(err){
		
			show_message_async("Corrupted file");
		
		}
	}
	
	update_frame();

}

if playanim or keyboard_check_released(vk_space){
	
	global.playing = !global.playing;
	animfr = 0;
	if !global.playing update_frame();
	
}

if global.playing {

	currentframe = animation_get_frame(global.animation,animfr,play_quad)
	animfr += animspd/60;
	animfr = animfr mod 1;


}


if mouse_wheel_up() global.selected_bone = clamp(global.selected_bone+1,0,sprite_get_number(sprite)-1);
if mouse_wheel_down() global.selected_bone = clamp(global.selected_bone-1,0,sprite_get_number(sprite)-1);

if copycode{
	
	show_message(string(global.animation));
	clipboard_set_text(string(global.animation));

}

if addk and !global.playing{

	if global.selected_keyframe == array_length(global.animation)-1{
		
		var ke = global.animation[global.selected_keyframe];
		var po = ke[1]
		var nframe = animation_get_frame(global.animation,(1+po)/2,false);
		global.animation[array_length(global.animation)] = [nframe,(1+po)/2]	
		global.selected_keyframe++;

		
	} else {

		var mx = array_length(global.animation)
		var ne = global.animation[global.selected_keyframe+1];
		var cu = global.animation[global.selected_keyframe];
		var po = (ne[1] + cu[1])/2;
		var frame = animation_get_frame(global.animation, po, false);
		for(var k = mx; k > global.selected_keyframe+1 ; k--){

			var temp = global.animation[k-1]
			global.animation[k] = [temp[0],temp[1]];
			
		}
		global.animation[global.selected_keyframe+1] = [frame,po];
		global.selected_keyframe++;
	
	}
	
	update_frame();

}

if (delk or keyboard_check_released(vk_delete)) and !global.playing and global.selected_keyframe!=0{

	array_delete(global.animation, global.selected_keyframe--, 1);
	
	update_frame();

}

if dupk and !global.playing{

	if global.selected_keyframe == array_length(global.animation)-1{
		
		var ke = global.animation[global.selected_keyframe];
		var po = ke[1]
		var nframe = []
		array_copy(nframe,0,ke[0],0,array_length(ke[0]))
		global.animation[array_length(global.animation)] = [nframe,(1+po)/2]
		global.selected_keyframe = global.selected_keyframe+1;
		
	} else {
	
		var mx = array_length(global.animation)
		var ne = global.animation[global.selected_keyframe+1];
		var cu = global.animation[global.selected_keyframe];
		var po = (ne[1] + cu[1])/2;
		for(var k = mx; k > global.selected_keyframe+1 ; k--){

			var temp = global.animation[k-1]
			global.animation[k] = [temp[0],temp[1]];
			
		}
		array_copy(cu[0], 0, global.animation[global.selected_keyframe][0], 0, array_length(global.animation[global.selected_keyframe][0]));
		global.animation[global.selected_keyframe+1] = [cu[0],po];
		global.selected_keyframe = global.selected_keyframe+1;
	
	}
	
	update_frame();

}

var stay = global.animation[0]

global.animation[0] = [stay[0],0]


draw_text(10,10,fps);

draw_sprite(animator_keyframes,0,20,300)
for(var s = 5; s<100; s+=5){

	draw_set_color(c_white)
	var add = 0;
	if s = 50 add+=10;
	if s mod 10 == 0 add+=5;
	draw_line(20+s*3.6,300,20+s*3.6,310+add)

}

if global.playing draw_sprite(animator_keyframes,3,20+animfr*360,300);


for(var k=0; k<array_length(global.animation); k++){

	var keyframe = global.animation[k]
	var ind = 0;
	if global.selected_keyframe == k ind = 1;
	
	draw_sprite(animator_keyframes,ind+1,20+360*keyframe[1],300)
	
	if mouse_check_button_pressed(mb_left) and is_between(20+360*keyframe[1],mouse_x,20+360*keyframe[1]+8,true) and is_between(300,mouse_y,348,true){
	
		global.selected_keyframe = k;
		moveTemp = 10;
		clicked_keyframe = k;
		update_frame();
	
	} else if mouse_check_button_released(mb_left) {
	
		clicked_keyframe = -1;
		
	} else if clicked_keyframe != -1 and moveTemp == 0{
	
		var key = global.animation[global.selected_keyframe]
		
		var time = key[1];
		
		time = (mouse_x-20)/360
		time = clamp(time,0.01,0.99)
		
		if global.selected_keyframe>0{
			var keyb = global.animation[global.selected_keyframe-1]
			var timeb = keyb[1]
			time = clamp(time,timeb+0.01,0.99)
		
		}
		
		if global.selected_keyframe<array_length(global.animation)-1{
			var keya = global.animation[global.selected_keyframe+1]
			var timea = keya[1]
			time = clamp(time,0.01,timea-0.01)
		
		}
		
		global.animation[global.selected_keyframe] = [key[0],time]
		
		
	
	}
	

}

moveTemp = max(moveTemp - 1, 0);


if !global.playing and is_between(x-50,mouse_x,x+50,true) and is_between(y-50,mouse_y,y+50,true){
	
	var last = array_length(global.animation[global.selected_keyframe][0])-1;
	
	if mouse_check_button_pressed(mb_right){
		move_coords=[mouse_x,mouse_y]
		init_coords=[global.animation[global.selected_keyframe][0][last-1],global.animation[global.selected_keyframe][0][last]]
	} else if mouse_check_button_released(mb_right){
		move_coords=[mouse_x,mouse_y]
	} else if mouse_check_button(mb_right){
	
		global.animation[global.selected_keyframe][0][last-1] = init_coords[0] + mouse_x - move_coords[0];
		global.animation[global.selected_keyframe][0][last] = init_coords[1] + mouse_y - move_coords[1];
		update_frame();
		
	
	}
	
	
}


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

for(var i = sprite_get_number(sprite)-1; i >= 0;i--){
	
	var bone = base[i];
	
	var dist = point_distance(bone[0], bone[1], midx, midy)
	var ray = point_direction(bone[0], bone[1], midx, midy);
	var addx = lengthdir_x(dist, pos[i][2]+ray);
	var addy = lengthdir_y(dist, pos[i][2]+ray);
	
	pos[i][0] += addx*dir;
	pos[i][1] += addy;
	
	selected+=0.001;
	
	var _last = array_length(currentframe)-1;
	
	draw_sprite_ext(sprite,i,x+pos[i][0], y+pos[i][1],1,1,pos[i][2],c_white,(show_bones and !(global.selected_bone == i)) ? 0.2 : 1 )
	
	gpu_set_blendmode_ext(bm_one, bm_one);
	if global.selected_bone == i draw_sprite_ext(sprite,i,x+pos[i][0], y+pos[i][1],1,1,pos[i][2],c_white,1) 
	gpu_set_blendmode(bm_normal)
	
	if global.selected_bone == i and !global.playing and is_between(x-100,mouse_x,x+100,true) and is_between(y-100,mouse_y,y+100,true){
	
	var fr = global.animation[global.selected_keyframe][0];
	
	pos[i][0] -= addx*dir;
	pos[i][1] -= addy;
	
	if mouse_check_button_pressed(mb_left) {
		
		clicked_coords = [mouse_x,mouse_y];
		starting_angle = fr[global.selected_bone];
		
	} else if mouse_check_button_released(mb_left){
	
		//do nothing
			
	} else if mouse_check_button(mb_left){
	
		var fr = global.animation[global.selected_keyframe][0];
		draw_set_color(c_black)
		draw_line(x+pos[i][0], y+pos[i][1],mouse_x,mouse_y)
		draw_sprite_ext(animator_rotator,0,x+pos[i][0], y+pos[i][1],1,1,fr[global.selected_bone],c_white,0.2)
		
		fr[global.selected_bone] = starting_angle + angle_difference(point_direction(x+pos[i][0], y+pos[i][1],mouse_x,mouse_y),
		point_direction(x+pos[i][0], y+pos[i][1],clicked_coords[0],clicked_coords[1]))
		
		global.animation[global.selected_keyframe][0] = fr;
		update_frame();
		
	
	}
	
	
}
	
}


draw_set_color(c_black)
draw_rectangle(x-100,y-100,x+100,y+100,true)

draw_set_color(c_red)
draw_line(x-100,y+79-48,x+100,y+79-48)
