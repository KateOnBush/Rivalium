/// @description Insert description here
// You can write your code in this editor
//350,200

function update_frame(){

	currentframe = global.animation[global.selected_keyframe];

}

var midx = sprite_get_width(sprite)/2;
var midy = sprite_get_height(sprite)/2;

var he = ["Linear", "Quadratic", "Back Ease", "Exponential"];

var bon = ["Start boning", "Bone parent", "Finish Boning"];

draw_set_font(font0)
var dep = 5;
var d = 20;
var addk = draw_button_simple(10,10+dep,40,20+dep,"+")
var delk = draw_button_simple(60,10+dep,90,20+dep,"-")
var dupk = draw_button_simple(110,10+dep,140,20+dep,"++")
dep+=d;
//[ [ -10,-16,7 ],[ -10,-3,0 ],[ -6,8,8 ],[ -6,17,2 ],[ 2,8,8 ],[ 3,18,4 ],[ 2,-22,7 ],[ 1,-4,8 ],[ 0,5,-1 ],[ 8,-4,10 ],[ 7,-16,7 ] ]
var saveanim = draw_button_simple(10,10+dep,70,20+dep,"Save .anim")
var openanim = draw_button_simple(80,10+dep,140,20+dep,"Open .anim")
dep+=d;
var playanim = draw_button_simple(10,10+dep,140,20+dep,global.playing ? "Stop" : "Play")
dep+=d;
var setquad = draw_button_simple(10,10+dep,140,20+dep,"Type: " + he[global.animation[global.selected_keyframe][array_length(global.animation[global.selected_keyframe])-2]]);
dep+=d;
var setspd = draw_button_simple(10,10+dep,140,20+dep,"Set speed")
dep+=d;
var sbones = draw_button_simple(10,10+dep,70,20+dep,show_bones ? "Hide Bon." : "Show Bon.") || keyboard_check_released(ord("B"));
var sorigin = draw_button_simple(80,10+dep,140,20+dep,show_org ? "Hide Or." : "Show Or.") || keyboard_check_released(ord("O"));
dep+=d;
var boning = draw_button_simple(10,10+dep,70,20+dep,bon[global.boneSetup]);
var bonejson = draw_button_simple(80,10+dep,140,20+dep, "JSON Bone");
dep+=d;
var resetpos = draw_button_simple(10,10+dep,140,20+dep,"Reset position")
dep+=d;
var resetx = draw_button_simple(10,10+dep,70,20+dep,"Reset X")
var resety = draw_button_simple(80,10+dep,140,20+dep,"Reset Y")
dep+=d;
var resetbones = draw_button_simple(10,10+dep,140,20+dep,"Reset keyframe")
dep+=d;
var resetbon = draw_button_simple(10,10+dep,70,20+dep,"Reset bone")
var resetbonepos = draw_button_simple(80,10+dep,105,20+dep,"Pos")
var resetbonescale = draw_button_simple(115,10+dep,140,20+dep,"Scale")
dep+=d;
var importtext = draw_button_simple(10,10+dep,70,20+dep, "Paste JSON");
var copycode = draw_button_simple(80,10+dep,140,20+dep, "Copy JSON");
dep+=d;
var resetani = draw_button_simple(10,10+dep,140,20+dep,"Reset Animation")
dep+=d;
var changechar = draw_button_simple(10,10+dep,140,20+dep,"Change Character")
var bonebase = draw_button_simple(150,10+dep,150+130,20+dep,"Pre-defined Bone Base")

var setdepth = keyboard_check_released(ord("D"));

var copy = keyboard_check(vk_control) and keyboard_check_pressed(ord("C"));
var paste = keyboard_check(vk_control) and keyboard_check_pressed(ord("V"));

var copybone = keyboard_check(vk_shift) and copy;
var pastebone = keyboard_check(vk_shift) and paste;
var copykeyframe = !keyboard_check(vk_shift) and copy;
var pastekeyframe = !keyboard_check(vk_shift) and paste;

if setdepth {

	var yes = get_integer("Input your depth: ", 0);
	
	global.animation[global.selected_keyframe][global.selected_bone][4] = yes ?? 0;

}

if copybone {

	clipboard_set_text(string(global.animation[global.selected_keyframe][global.selected_bone]));
	pop_message("Copied bone!")

} else if copykeyframe {

	clipboard_set_text(string(global.animation[global.selected_keyframe]));
	pop_message("Copied keyframe!")

}

if pastebone {
	
	try {

		var yes = json_parse(clipboard_get_text());
		
		var test = yes[0];
		var test2 = yes[4]+1;
		
		global.animation[global.selected_keyframe][global.selected_bone] = yes;
		
		pop_message("Pasted bone!")
		
		update_frame();
	
	} catch(err){
		
		pop_message("Invalid!")
		
	}

}

if pastekeyframe {
	
	try {

		var yes = json_parse(clipboard_get_text());
		
		var test = yes[0][4]+1;
		var test2 = yes[sprite_get_number(sprite)-1][0]+1;
		
		var keyframe_t = global.animation[global.selected_keyframe][array_length(global.animation[global.selected_keyframe])-1];
		
		global.animation[global.selected_keyframe] = yes;
		
		global.animation[global.selected_keyframe][array_length(global.animation[global.selected_keyframe])-1] = keyframe_t;
		
		pop_message("Pasted keyframe!")
		
		update_frame();
	
	} catch(err){
		
		pop_message("Invalid!")
		
	}

}



if resetbonescale and !global.playing {

	global.animation[global.selected_keyframe][global.selected_bone][1] = 1;

}

if resetbonepos and !global.playing {

	global.animation[global.selected_keyframe][global.selected_bone][2] = 0;
	global.animation[global.selected_keyframe][global.selected_bone][3] = 0;

}

if bonebase and !global.playing {

	var yes = get_integer("Bone base number:", 1);
	
	try {
		
		var _base = base_character(yes);
		
		var t = _base[0];
		
		if array_length(_base) != sprite_get_number(sprite) throw "";
		
		base = _base;
		temporary_base = base;
		
		
		
	} catch(err) {
	
		show_message_async("Invalid number");
	
	}

}

if bonejson {

	var yes = get_string("Paste JSON data:","");
	
	try {
		
		var _base = json_parse(yes);
		
		var t = _base[0];
		
		if array_length(_base) != sprite_get_number(sprite) throw "";
		
		var s = _base[0][0]+1;
		
		base = _base;
		
		temporary_base = base;
		
		
	} catch(err){
	
		show_message_async("Invalid data");
	
	}

}

if sorigin show_org = !show_org;

if changechar and !global.playing {

	var yes = get_integer("Character number: (THIS WILL RESET THE ANIMATION AND DELETE UNSAVED DATA)", 0);
	
	if yes != undefined {
	
		try{
	
			var sex = setupCharacterData()[yes];
			sprite = sex.sprite
			base = empty_bone_base(sprite);
			temporary_base = empty_bone_base(sprite);
			currentframe = empty_frame(sprite);
			pos = [];
			
			global.animation = empty_animation(sprite);
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
		var temp = keyframe[array_length(keyframe)-1]+1;
		var value1 = keyframe[0][0]+1;
		
		global.animation = anim;
		global.selected_keyframe = 0;
		global.selected_bone = 0;
		update_frame();
		
	}catch(err){
	
		show_message_async("Invalid value!")
	
	}

}


if keyboard_check_released(vk_enter) and global.boneSetup = 2 {

	var json = string(temporary_base);
	clipboard_set_text(json);
	show_message_async(json);
	base = temporary_base;
	temporary_base = empty_bone_base(sprite_get_number(sprite));
			
	global.selected_bone = 0;
			
	global.boneSetup = 0;
	show_bones = false;
			
	global.message = "";
	

} else if keyboard_check_released(vk_enter) and global.boneSetup = 1 {
	
	global.message = "Choose bone parent for bone 0 (space for base bone)";

	global.boneSetup = 2;
	
	global.selected_bone = 0;
	
	view_set_visible(1, false);
	view_set_visible(0, true);
	
	show_bones = false;

} else if boning and !global.playing and global.boneSetup = 0 {

	global.message = "Start placing bones";
	global.selected_bone = 0;
	resetpos = true;
	resetani = true;
	global.boneSetup = 1;
	
	view_set_visible(1, true);
	view_set_visible(0, false);
	
	show_bones = true;

}

if keyboard_check_released(vk_escape) and global.boneSetup>0{

	view_set_visible(1, false);
	view_set_visible(0, true);
	global.message = "";
	global.selected_bone = 0;
	global.boneSetup = 0;
	
	show_bones = false;

}

for(var l = 0; l < sprite_get_number(sprite); l++){

	var t = draw_button_simple(390, 10+l*26, 390+24, 34+l*26, "");
	
	if global.selected_bone == l {
		
		draw_set_color(c_green);
		draw_rectangle(390, 10+l*26, 390+24, 34+l*26, false);
		draw_set_color(c_black)
	
	}
	draw_sprite_ext(sprite, l, 390+12, 22+l*26, 0.75, 0.75, 0, c_white, 1);
	
	draw_set_color(c_red)
	draw_set_valign(fa_bottom)
	draw_set_halign(fa_left);
	var _dep = global.animation[global.selected_keyframe][l][4];
	draw_text_transformed(390+2, 34+l*26-2, _dep > 0 ? string(_dep) : "", 0.6, 0.6, 0);
	draw_set_color(c_black);
	
	if t and global.boneSetup == 0{
	
		global.selected_bone = l;
	
	} else if t and global.boneSetup = 2 {
	
		temporary_base[global.selected_bone++][2] = l;
		if (global.selected_bone == sprite_get_number(sprite)){
			
			var json = string(temporary_base);
			clipboard_set_text(json);
			show_message_async(json);
			base = temporary_base;
			temporary_base = empty_bone_base(global.selected_bone);
			
			global.selected_bone = 0;
			
			global.boneSetup = 0;
			show_bones = false;
			
			global.message = "";
		
		}
	
	}
}

if keyboard_check_released(vk_space) and global.boneSetup = 2 {
	
	temporary_base[global.selected_bone++][2] = -1;
	
	if (global.selected_bone == sprite_get_number(sprite)){
			
		var json = string(temporary_base);
		clipboard_set_text(json);
		show_message_async(json);
		base = temporary_base;
		temporary_base = empty_bone_base(global.selected_bone);
			
		global.selected_bone = 0;
			
		global.boneSetup = 0;
		show_bones = false;
		
		global.message = "";
		
	}

}


if resetani and !global.playing and global.boneSetup = 0{

	global.animation = empty_animation(sprite);
	global.selected_keyframe = 0;
	update_frame();

}

if resetbon and !global.playing and global.boneSetup = 0{

	global.animation[global.selected_keyframe][global.selected_bone] = empty_bone();
	update_frame();

}

if resetpos and !global.playing and global.boneSetup = 0{

	global.animation[global.selected_keyframe][array_length(global.animation[global.selected_keyframe])-3] = 0;
	global.animation[global.selected_keyframe][array_length(global.animation[global.selected_keyframe])-4] = 0;
	update_frame();

}

if resetx and !global.playing and global.boneSetup = 0{

	global.animation[global.selected_keyframe][array_length(global.animation[global.selected_keyframe])-4] = 0
	update_frame();

}

if resety and !global.playing and global.boneSetup = 0{

	global.animation[global.selected_keyframe][array_length(global.animation[global.selected_keyframe])-3] = 0
	update_frame();

}

if resetbones and !global.playing and global.boneSetup = 0{
	
	var tem = global.animation[global.selected_keyframe][array_length(global.animation[global.selected_keyframe])-1];

	global.animation[global.selected_keyframe] = empty_frame(sprite);
	global.animation[global.selected_keyframe][array_length(global.animation[global.selected_keyframe])-1] = tem;
	update_frame();

}

if sbones show_bones = !show_bones;

if setspd  and global.boneSetup = 0{
	
	animspd = get_integer("Speed (default at 1) :",animspd)
	animspd ??= 1;
	
}



if setquad and global.boneSetup = 0{

	var t = global.animation[global.selected_keyframe][array_length(global.animation[global.selected_keyframe])-2];
	if (++t > 3) t = 0;
	global.animation[global.selected_keyframe][array_length(global.animation[global.selected_keyframe])-2] = t;

}

if saveanim and !global.playing and global.boneSetup = 0 {

	//New file system (json)
	var file = get_save_filename("animation file|*.anim","")
	if file!=""{
	
		var str = json_stringify(global.animation);
		var f = file_text_open_write(file);
		file_text_write_string(f, str);
		file_text_close(f);
	
	}

}

if openanim and !global.playing and global.boneSetup = 0 {

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

if playanim or keyboard_check_released(vk_space) and global.boneSetup = 0{
	
	global.playing = !global.playing;
	animfr = 0;
	if !global.playing update_frame();
	
}

if global.playing and global.boneSetup = 0{

	currentframe = animation_get_frame(global.animation, animfr)
	animfr += animspd/60;
	animfr = animfr mod 1;


}


if mouse_wheel_down() and global.boneSetup < 2 global.selected_bone = clamp(global.selected_bone+1,0,sprite_get_number(sprite)-1);
if mouse_wheel_up() and global.boneSetup < 2 global.selected_bone = clamp(global.selected_bone-1,0,sprite_get_number(sprite)-1);

if copycode and global.boneSetup = 0{
	
	show_message(string(global.animation));
	clipboard_set_text(string(global.animation));

}

if addk and !global.playing{

	var kf = global.animation[global.selected_keyframe];
	var kf_t = kf[array_length(kf)-1];
	
	var nx_t;
	
	if global.selected_keyframe == array_length(global.animation)-1 nx_t = 1; else {
		var nx = global.animation[global.selected_keyframe+1];
		nx_t = nx[array_length(nx)-1];
	}
	
	var nframe = animation_get_frame(global.animation, (kf_t+nx_t)/2);
	
	array_insert(global.animation, ++global.selected_keyframe, nframe);
	
	update_frame();

}

if (delk or keyboard_check_released(vk_delete)) and !global.playing and global.selected_keyframe!=0{

	array_delete(global.animation, global.selected_keyframe--, 1);
	
	update_frame();

}

if dupk and !global.playing and global.boneSetup = 0{

	var kf = global.animation[global.selected_keyframe];
	var kf_t = kf[array_length(kf)-1];
	
	var nx_t;
	
	if global.selected_keyframe == array_length(global.animation)-1 nx_t = 1; else {
		var nx = global.animation[global.selected_keyframe+1];
		nx_t = nx[array_length(nx)-1];
	}
	
	var nframe = [];
	
	array_copy(nframe, 0, kf, 0, array_length(kf));

	nframe[array_length(nframe)-1] = (kf_t+nx_t)/2;

	array_insert(global.animation, ++global.selected_keyframe, nframe);
	
	update_frame();

}

draw_text(10,10,fps);

draw_sprite(animator_keyframes,0,20,300)
for(var s = 5; s<100; s+=5){

	draw_set_color(c_white)
	var add = 0;
	if s = 50 add+=10;
	if s mod 10 == 0 add+=5;
	draw_line(20+s*3.6,300,20+s*3.6,310+add)

}


for(var k=0; k<array_length(global.animation); k++){

	var keyframe = global.animation[k]
	var keyframe_t = keyframe[array_length(keyframe)-1];
	var ind = global.animation[k][array_length(global.animation[k])-2]*2;
	if global.selected_keyframe == k ind++;
	
	draw_sprite(animator_keyframes,ind+1,20+360*keyframe_t,300)
	
	if mouse_check_button_pressed(mb_left) and is_between(20+360*keyframe_t,mouse_x,20+360*keyframe_t+8,true) and is_between(300,mouse_y,348,true){
	
		global.selected_keyframe = k;
		moveTemp = 10;
		clicked_keyframe = k;
		update_frame();
	
	} else if mouse_check_button_released(mb_left) {
	
		clicked_keyframe = -1;
		
	} else if clicked_keyframe != -1 and moveTemp == 0{
	
		var key = global.animation[global.selected_keyframe]
		
		var time = key[array_length(key)-1];
		
		time = (mouse_x-20)/360
		time = clamp(time,0.01,0.99)
		
		if global.selected_keyframe>0{
			var keyb = global.animation[global.selected_keyframe-1]
			var timeb = keyb[array_length(keyb)-1];
			time = clamp(time,timeb+0.01,0.99)
		
		}
		
		if global.selected_keyframe<array_length(global.animation)-1{
			var keya = global.animation[global.selected_keyframe+1]
			var timea = keya[array_length(keya)-1];
			time = clamp(time,0.01,timea-0.01)
		
		}
		
		global.animation[global.selected_keyframe][array_length(global.animation[global.selected_keyframe])-1] = time;
		
	
	}
	

}

if global.playing draw_sprite(animator_keyframes,9,20+animfr*360,300);

moveTemp = max(moveTemp - 1, 0);


if !global.playing and is_between(x-50,mouse_x,x+50,true) and is_between(y-50,mouse_y,y+50,true) and global.boneSetup == 0{
	
	var last = array_length(global.animation[global.selected_keyframe])-1;
	
	if mouse_check_button_pressed(mb_right){
		move_coords=[mouse_x,mouse_y]
		init_coords=[global.animation[global.selected_keyframe][last-3],global.animation[global.selected_keyframe][last-2]];
	} else if mouse_check_button_released(mb_right){
		move_coords=[mouse_x,mouse_y]
	} else if mouse_check_button(mb_right){
	
		global.animation[global.selected_keyframe][last-3] = init_coords[0] + mouse_x - move_coords[0];
		global.animation[global.selected_keyframe][last-2] = init_coords[1] + mouse_y - move_coords[1];
		
		draw_sprite_ext(animator_rotator, 3, mouse_x, mouse_y, 0.5, 0.5, 0, c_white, 0.8);
		
		update_frame();
		
	
	}

} else if global.boneSetup == 1 and is_between(x-50,mouse_x,x+50,true) and is_between(y-50,mouse_y,y+50,true) {

	if mouse_check_button_pressed(mb_left){
		move_coords=[mouse_x,mouse_y]
		init_coords=[temporary_base[global.selected_bone][0], temporary_base[global.selected_bone][1]];
	} else if mouse_check_button_released(mb_left){
		
		move_coords=[mouse_x,mouse_y]
		
	} else if mouse_check_button(mb_left){
	
	
		temporary_base[global.selected_bone][0] = init_coords[0] + mouse_x - move_coords[0];
		temporary_base[global.selected_bone][1] = init_coords[1] + mouse_y - move_coords[1];
		
		draw_sprite_ext(animator_rotator, 4, mouse_x, mouse_y, 0.5, 0.5, 0, c_white, 0.8);
		
		base = temporary_base;
		update_frame();
		
	
	}
	
	if mouse_check_button_pressed(mb_right){
		move_coords=[mouse_x,mouse_y]
		for(var i = 0; i < array_length(temporary_base); i++){
			init_coord_list[i] = [temporary_base[i][0], temporary_base[i][1]];
		}
	} else if mouse_check_button_released(mb_right){
		
		move_coords=[mouse_x,mouse_y]
		
	} else if mouse_check_button(mb_right){
	
		for(var i = 0; i < array_length(temporary_base); i++){
		
			temporary_base[i][0] = init_coord_list[i][0] + mouse_x - move_coords[0];
			temporary_base[i][1] = init_coord_list[i][1] + mouse_y - move_coords[1];
		
		}
		
		draw_sprite_ext(animator_rotator, 4, mouse_x, mouse_y, 0.5, 0.5, 0, c_white, 0.8);
		
		base = temporary_base;
		update_frame();
		
	
	}


}

if show_org draw_sprite_ext(player_collision_mask, 0, x, y, 1, 1, 0, c_white, 0.8);

var _sortedframe = [];
for(var i = 0; i < sprite_get_number(sprite); i++){
	_sortedframe[i] = i;
}

function bone_depth_sorting(bone1, bone2){

	return currentframe[bone2][4] - currentframe[bone1][4];

}

array_sort(_sortedframe, bone_depth_sorting)

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

	selected+=0.001;
	
	var scale = currentframe[i][1];
	
	draw_sprite_ext(sprite,i,x+pos[i][0], y+pos[i][1], 1, scale, pos[i][2],c_white,(show_bones and !(global.selected_bone == i)) ? 0.2 : 1 )
	
	gpu_set_blendmode_ext(bm_one, bm_one);
	if global.selected_bone == i draw_sprite_ext(sprite,i,x+pos[i][0], y+pos[i][1],1, scale,pos[i][2],c_white,1) 
	gpu_set_blendmode(bm_normal)

	
}

var e = global.selected_bone;
var fr = global.animation[global.selected_keyframe];

if !global.playing and global.boneSetup = 0 and is_between(x-100,mouse_x,x+100,true) and is_between(y-100,mouse_y,y+100,true) {

	if mouse_check_button_pressed(mb_left) {
	
		controlled = 1;
		if keyboard_check(vk_control) controlled = 2;
		
		if keyboard_check(vk_shift) controlled = 3;
		
		clicked_coords = [mouse_x,mouse_y];
		starting_angle = fr[global.selected_bone][0];
		clicked_scale = fr[global.selected_bone][1];
		starting_offset = [fr[e][2], fr[e][3]];
	
	} else if mouse_check_button(mb_left) {
	
		if controlled == 1 {
		
			draw_set_color(c_black)
			draw_line(x+pos[e][0], y+pos[e][1],mouse_x,mouse_y)
			draw_sprite_ext(animator_rotator,0,x+pos[e][0], y+pos[e][1],1,1,fr[global.selected_bone][0],c_white,0.2)
		
			global.animation[global.selected_keyframe][global.selected_bone][0] = 
			starting_angle + angle_difference(point_direction(x+pos[e][0], y+pos[e][1],mouse_x,mouse_y),
			point_direction(x+pos[e][0], y+pos[e][1],clicked_coords[0],clicked_coords[1]));
		
			update_frame();
		
		} else if controlled == 2 {
		
			var vecs = new Vector2(0, 0);
			
			vecs.polar(pos[e][2]-90, 1);
			
			var vec2 = new Vector2(mouse_x - x - pos[e][0], mouse_y - y - pos[e][1]);
			
			var vec_orig = new Vector2(clicked_coords[0] - x - pos[e][0], clicked_coords[1] - y - pos[e][1]);
			
			var dot = vec2.dot(vecs);
			
			var dot2 = vecs.dot(vec_orig);
			
			if dot2 == 0 controlled = 0;
			
			vecs = vecs.multiply(dot);
			
			global.animation[global.selected_keyframe][global.selected_bone][1] = clicked_scale * dot/dot2;
			
			draw_line(x+pos[e][0], y+pos[e][1], x+pos[e][0] + vecs.x, y+pos[e][1] + vecs.y);
			
			draw_sprite_ext(animator_rotator, 1, x+pos[e][0] + vecs.x, y+pos[e][1] + vecs.y, 0.5, 0.5, vecs.dir() + 90, c_white, 0.8);
			
			update_frame();
			
		
		} else if controlled == 3 {
		
			global.animation[global.selected_keyframe][global.selected_bone][2] = mouse_x - clicked_coords[0] + starting_offset[0];
			global.animation[global.selected_keyframe][global.selected_bone][3] = mouse_y - clicked_coords[1] + starting_offset[1];
			
			draw_sprite_ext(animator_rotator, 4, mouse_x, mouse_y, 0.5, 0.5, 0, c_white, 0.8);
			
			update_frame();
		
		}
	
	} else controlled = 0;
	
}

if show_org draw_sprite_ext(animator_rotator, 2, x, y, 0.6, 0.6, 0, c_white, 0.8);

global.animation[0][array_length(global.animation[0])-1] = 0;

draw_set_color(c_black)
draw_rectangle(x-100,y-100,x+100,y+100,true)

draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_text_ext_transformed(x, y - 70, global.message, 20, 300, 0.7, 0.7, 0);

draw_set_color(c_red)
draw_line(x-100,y+79-48,x+100,y+79-48)
