/// @description Insert description here
// You can write your code in this editor
//350,200

for(var i = 0; i < array_length(global.animation); i++){

	var key = global.animation[i];
	if array_length(key) < array_length(empty_frame(sprite)) {
		key = empty_frame(sprite);	
	} else {
		for(var j = 0; j < array_length(key) - 4; j++){
			var bon = key[j];
			if array_length(bon) < array_length(empty_bone()) {
				bon = empty_bone();	
			}
		}
	
	}

}

window_set_cursor(cr_default)

var ww = room_width, hh = room_height;

var dep = 16, d = 46, xs = 16, w = 320, h = 42;

var tx = room_width / 2 + (room_width - 1280)/4, ty = room_height - 48 - 32,
	tw = 1280, th = 96;
	
var SCALE = 5, EDx = w + xs + 32, EDy = 32, EDx2 = room_width - 52, EDy2 = room_height - th - 64 - 32;

var isInEditor = is_between(EDx, mouse_x, EDx2, true) && is_between(EDy, mouse_y, EDy2, true);

draw_set_color(c_gray)
draw_set_alpha(0.4)
draw_rectangle(0, hh - 64 - 96, ww, hh, false);
draw_set_alpha(1)


function update_frame(){

	currentframe = global.animation[global.selected_keyframe];

}

var midx = sprite_get_width(sprite)/2;
var midy = sprite_get_height(sprite)/2;

var he = ["Lin.", "Quad.", "Back.", "Expo."];

draw_set_font(font_game)

//[ [ -10,-16,7 ],[ -10,-3,0 ],[ -6,8,8 ],[ -6,17,2 ],[ 2,8,8 ],[ 3,18,4 ],[ 2,-22,7 ],[ 1,-4,8 ],[ 0,5,-1 ],[ 8,-4,10 ],[ 7,-16,7 ] ]

var boning = draw_button_simple(xs, dep, xs + w, dep + h, global.boneSetup == 0 ? "Animation mode" : "Rig mode", 0, true);
dep+=d;
var bonejson = draw_button_simple(xs, dep, xs + w * .48, dep + h, "Import rig")
var exportrig = draw_button_simple(xs + w * .52, dep, xs + w, dep + h, "Export rig")
dep+=1.5*d;
var saveanim = draw_button_simple(xs, dep, xs + w * .48, dep + h, "Save")
var openanim = draw_button_simple(xs + w * .52, dep, xs + w, dep + h, "Open")
dep+=d;
var importtext = draw_button_simple(xs, dep, xs + w * .48, dep + h, "Paste JSON");
var copycode = draw_button_simple(xs + w * .52, dep, xs + w, dep + h, "Copy JSON");
dep+=d;

var t = 0, dis = (w - 4)/3;
var sbones = draw_button_simple(xs + t, dep, xs + t + dis, dep + h, animator_rig, 0, !show_bones) || keyboard_check_released(ord("B"));
t+=dis + 2;
var showrig = draw_button_simple(xs + t, dep, xs + t + dis, dep + h, animator_rig, 1, show_rig) || keyboard_check_released(ord("R"));
t+=dis + 2;
var sorigin = draw_button_simple(xs + t, dep, xs + t + dis, dep + h, animator_rig, 2, show_org) || keyboard_check_released(ord("O"));

dep += d;
var changechar = draw_button_simple(xs, dep, xs + w, dep + h, "Load character preset");
dep+=1.5*d;
var resetbon = draw_button_simple(xs, dep, xs + w, dep + h, "Reset bone")
dep += d;
var resetbonepos = draw_button_simple(xs, dep, xs + w * .48, dep + h, "Reset pos.")
var resetbonescale = draw_button_simple(xs + w * .52, dep, xs + w, dep + h, "Reset scale")
dep+=d;
var resetpos = draw_button_simple(xs, dep, xs + w, dep + h, "Reset position")
dep+=d;
var resetx = draw_button_simple(xs, dep, xs + w * .48, dep + h, "Reset X")
var resety = draw_button_simple(xs + w * .52, dep, xs + w, dep + h, "Reset Y")
dep+=d;
var resetbones = draw_button_simple(xs, dep, xs + w, dep + h, "Reset keyframe")
dep+=d;
var resetani = draw_button_simple(xs, dep, xs + w, dep + h, "Reset animation")
dep+=1.2*d;

var t = 0, dis = (w - 6)/4;
var addk = draw_button_simple(xs + t, dep, xs + t + dis, dep + h * 1.2, animator_add, 0)
t+=dis + 2;
var delk = draw_button_simple(xs + t, dep, xs + t + dis, dep + h * 1.2, animator_add, 1)
t+=dis + 2;
var dupk = draw_button_simple(xs + t, dep, xs + t + dis, dep + h * 1.2, animator_add, 2)
t+=dis + 2;
var setquad = draw_button_simple(xs + t, dep, xs + t + dis, dep + h * 1.2, animator_add, 3);

var playanim = draw_button_simple(xs, ty - th/2, xs + 120, ty - th/2 + 48, animator_play, global.playing)
var setspd = draw_button_simple(xs, ty + th/2 - 48, xs + 120, ty + th/2, "x" + string(animspd));

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

	dropdown_create(array_map(presets, function(e){ return e[2] }), function(n){
	
		try{
			
			var yes = n;
	
			var charid = presets[yes][0], baseid = presets[yes][1];
	
			var sex = Characters[yes]();
			sprite = sex.sprite;
			base = base_character(baseid) ?? empty_bone_base(sprite);
			temporary_base = base_character(baseid) ?? empty_bone_base(sprite);
			currentframe = empty_frame(sprite);
			pos = [];
			
			global.animation = empty_animation(sprite);
			global.selected_keyframe = 0;
			global.selected_bone = 0;
			update_frame();
			
		}catch(err){ show_message_async("Invalid character")};
	
	})
	
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

	var t = draw_button_simple(ww - 50, EDy + 50 * l, ww - 2, 48 + EDy + l * 50, "", 0, global.selected_bone == l);
	
	draw_sprite_ext(sprite, l, ww - 50 + 24, EDy + 50 * l + 24, 1, 1, 0, c_white, 1);
	
	draw_set_color(c_red)
	draw_set_valign(fa_bottom)
	draw_set_halign(fa_left);
	if array_length(global.animation[global.selected_keyframe]) < 4 {
		show_debug_message(global.animation);
	}
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
	
		var str = base64_encode(json_stringify(global.animation));
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
			for(var i = 0; i < array_length(t); i++){
				var frame = t[i];
				for(var j = 0; j < array_length(frame)-4; j++){
					var bone = frame[j];
					if (array_length(bone) < 6) {
						for(var s = array_length(bone); s < 6; s++){
							bone[s] = empty_bone()[s];
						}
					}
				}
			}
			global.animation = t;
			global.selected_keyframe = 0;
			global.selected_bone = 0;
			
		}catch(err){
		
			try {
				var t = json_parse(base64_decode(str));
				global.animation = t;
				global.selected_keyframe = 0;
				global.selected_bone = 0;
				
			} catch(err){
			
				show_message_async("Corrupted file");
			
			}
			
		
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
draw_sprite(keyframe_timeline,0,room_width / 2 + (room_width - 1280)/4, room_height - 48 - 32)


for(var s = 0; s<50; s+=1){

	draw_set_color(c_white)
	draw_set_alpha(0.2)
	var add = 0.2;
	if s mod 2 == 0 add += 0.2;
	if s mod 10 == 0 add += 0.2;
	if s mod 50 == 0 add += 0.1;
	draw_line(tx + tw * s/100, ty - add * th/2, tx + tw * s/100, ty + add * th/2);
	draw_line(tx - tw * s/100, ty - add * th/2, tx - tw * s/100, ty + add * th/2);
	draw_set_alpha(1);

}


for(var k=0; k<array_length(global.animation); k++){

	var keyframe = global.animation[k]
	var keyframe_t = keyframe[array_length(keyframe)-1];
	var key = global.selected_keyframe == k;
	var kind = global.animation[k][array_length(global.animation[k])-2];
	
	var kfx = tx - tw/2 + tw * keyframe_t, kfy = ty;
	
	draw_sprite(animator_keyframes,key, kfx, kfy);
	draw_sprite(animator_keyframes_styles,kind, kfx, kfy);
	
	if mouse_check_button_pressed(mb_left) and is_between(kfx - 12, mouse_x, kfx + 12, true) and is_between(kfy - 48, mouse_y, kfy + 48,true){
	
		global.selected_keyframe = k;
		moveTemp = 10;
		clicked_keyframe = k;
		update_frame();
	
	} else if mouse_check_button_released(mb_left) {
	
		clicked_keyframe = -1;
		
	} else if clicked_keyframe != -1 and moveTemp == 0{
	
		var key = global.animation[global.selected_keyframe]
		
		var time = key[array_length(key)-1];
		
		time = (mouse_x - (tx - tw/2))/tw;
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


var _sortedframe = [];
for(var i = 0; i < sprite_get_number(sprite); i++){
	_sortedframe[i] = i;
}


function bone_depth_sorting(bone1, bone2){

	return currentframe[bone2][4] - currentframe[bone1][4];	

}

_sortedframe = array_bubble_sort(_sortedframe, bone_depth_sorting)

for(var e = array_length(_sortedframe)-1; e >= 0;e--){

	var i = _sortedframe[e];

	var bone = base[i];
	
	var rotation = currentframe[i][0];
	var coords = [bone[0],bone[1]];
	
	var _bone = base[i]
	
	var _parent = [], _parent_b = base[i][2];
	
	coords = calculate_bone_position(base, currentframe, i);
	
	var _last = array_length(currentframe)-1;
	
	pos[i] = [coords[0]*dir+currentframe[_last-3],coords[1]+currentframe[_last-2],rotation + coords[2]];

	selected+=0.001;
	
	var _t = 1;
	if (global.hovered == i) {
		_t = 1.2;
		window_set_cursor(cr_handpoint);	
	}
	
	var yscale = currentframe[i][1] * SCALE * _t;
	var xscale = currentframe[i][5] * SCALE * _t;
	
	draw_sprite_ext(sprite,i,x+pos[i][0] * SCALE, y+pos[i][1] * SCALE, xscale, yscale, pos[i][2],c_white,(show_bones and !(global.selected_bone == i)) ? 0.2 : 1 )
	
	gpu_set_blendmode_ext(bm_one, bm_one);
	if global.selected_bone == i or global.hovered == i draw_sprite_ext(sprite,i,x+pos[i][0] * SCALE, y+pos[i][1] * SCALE, xscale, yscale,pos[i][2],c_white,1) 
	gpu_set_blendmode(bm_normal)

	
}

if global.playing draw_sprite(animator_keyframes,2, tx - tw/2 + tw * animfr, ty);

moveTemp = max(moveTemp - 1, 0);

for(var j = 0; j < instance_number(clickable_bone); j++){

	var c = instance_find(clickable_bone, j);
	var bon = c.bonid;
	
	with(c) {
		sprite_collision_mask(other.sprite, true, bboxmode_automatic, 0, 0, 96, 96, bboxkind_precise, 0)
	}
	
	c.x = x + pos[bon][0] * SCALE;
	c.y = y + pos[bon][1] * SCALE;
	
	c.image_angle = pos[bon][2];
	c.sprite_index = sprite;
	c.image_index = bon;
	
	
	c.image_yscale = currentframe[bon][1] * SCALE;
	c.image_xscale = currentframe[bon][5] * SCALE;
	
	if (collision_point(mouse_x, mouse_y, c, true, true)) {
		global.hovered = bon;	
	}

}

if global.hovered != -1 && mouse_check_button_pressed(mb_left){

	global.selected_bone = global.hovered;
	
}


if !global.playing and isInEditor and global.boneSetup == 0{
	
	var last = array_length(global.animation[global.selected_keyframe])-1;
	
	if mouse_check_button_pressed(mb_right){
		move_coords=[mouse_x,mouse_y]
		init_coords=[global.animation[global.selected_keyframe][last-3],global.animation[global.selected_keyframe][last-2]];
	} else if mouse_check_button_released(mb_right){
		move_coords=[mouse_x,mouse_y]
	} else if mouse_check_button(mb_right){
	
		global.animation[global.selected_keyframe][last-3] = init_coords[0] + (mouse_x - move_coords[0])/SCALE;
		global.animation[global.selected_keyframe][last-2] = init_coords[1] + (mouse_y - move_coords[1])/SCALE;
		
		draw_sprite_ext(animator_rotator, 3, mouse_x, mouse_y, 0.5, 0.5, 0, c_white, 0.8);
		
		update_frame();
		
	
	}

} else if global.boneSetup == 1 and isInEditor {

	if mouse_check_button_pressed(mb_left){
		move_coords=[mouse_x,mouse_y]
		init_coords=[temporary_base[global.selected_bone][0], temporary_base[global.selected_bone][1]];
	} else if mouse_check_button_released(mb_left){
		
		move_coords=[mouse_x,mouse_y]
		
	} else if mouse_check_button(mb_left){
	
	
		temporary_base[global.selected_bone][0] = init_coords[0] + (mouse_x - move_coords[0])/SCALE;
		temporary_base[global.selected_bone][1] = init_coords[1] + (mouse_y - move_coords[1])/SCALE;
		
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
		
			temporary_base[i][0] = init_coord_list[i][0] + (mouse_x - move_coords[0])/SCALE;
			temporary_base[i][1] = init_coord_list[i][1] + (mouse_y - move_coords[1])/SCALE;
		
		}
		
		draw_sprite_ext(animator_rotator, 4, mouse_x, mouse_y, 0.5, 0.5, 0, c_white, 0.8);
		
		base = temporary_base;
		update_frame();
		
	
	}


}

if show_org draw_sprite_ext(player_collision_mask, 0, x, y, 1, 1, 0, c_white, 0.8);

draw_set_color(c_dkgrey)
draw_set_alpha(0.4)
draw_rectangle(EDx, EDy, EDx2, EDy2, false)

draw_set_alpha(.9)
draw_set_color(c_red)
draw_line(EDx,y + (79-48) * SCALE, EDx2,y + (79-48) * SCALE)
draw_set_alpha(1)

if showrig show_rig = !show_rig;

if show_rig {
	
	for(var i = 0; i < array_length(base); i++){

		var _bone_i = i;
		var _parent_i = base[i][2];
	
		if (_parent_i != -1){
	
			var bx = pos[_bone_i][0], by = pos[_bone_i][1],
				px = pos[_parent_i][0], py = pos[_parent_i][1];
			
			var _dir = point_direction(px, py, bx, by);
			var _dist = point_distance(px, py, bx, by) * SCALE;
		
			draw_sprite_ext(rig_bone, 0, x + px * SCALE, y + py * SCALE, 2.5, _dist/28, _dir - 90, c_white, 0.8);
		
		}

	}
}

var e = global.selected_bone;
var fr = global.animation[global.selected_keyframe];

if !global.playing and global.boneSetup = 0 and isInEditor {

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
			draw_line(x+pos[e][0] * SCALE, y+pos[e][1] * SCALE,mouse_x,mouse_y)
			draw_sprite_ext(animator_rotator,0,x+pos[e][0] * SCALE, y+pos[e][1] * SCALE,1,1,fr[global.selected_bone][0],c_white,0.4)
		
			global.animation[global.selected_keyframe][global.selected_bone][0] = 
			starting_angle + angle_difference(point_direction(x+pos[e][0] * SCALE, y+pos[e][1] * SCALE, mouse_x, mouse_y),
			point_direction(x+pos[e][0] * SCALE, y+pos[e][1] * SCALE,clicked_coords[0],clicked_coords[1]));
		
			update_frame();
		
		} else if controlled == 2 {
		
			var vecs = new Vector2(0, 0);
			
			var vec2 = new Vector2(mouse_x - x - pos[e][0], mouse_y - y - pos[e][1]);
			
			var vec_orig = new Vector2(clicked_coords[0] - x - pos[e][0], clicked_coords[1] - y - pos[e][1]);
			
			var hscale = true;
			
			if (abs(angle_difference(vec_orig.dir(), pos[e][2])) < 45) hscale = false;
			
			vecs.polar(pos[e][2] - (hscale ? 90 : 0), 1);
			
			var dot = vec2.dot(vecs);
			
			var dot2 = vecs.dot(vec_orig);
			
			if dot2 == 0 controlled = 0;
			
			vecs = vecs.multiply(dot);
			
			global.animation[global.selected_keyframe][global.selected_bone][hscale ? 1 : 5] = clicked_scale * dot/dot2;
			
			draw_line(x+pos[e][0], y+pos[e][1], x+pos[e][0] + vecs.x, y+pos[e][1] + vecs.y);
			
			draw_sprite_ext(animator_rotator, 1, x+pos[e][0] + vecs.x, y+pos[e][1] + vecs.y, 0.5, 0.5, vecs.dir() + 90, c_white, 0.8);
			
			update_frame();
			
		
		} else if controlled == 3 {
		
			global.animation[global.selected_keyframe][global.selected_bone][2] = (mouse_x - clicked_coords[0])/SCALE + starting_offset[0];
			global.animation[global.selected_keyframe][global.selected_bone][3] = (mouse_y - clicked_coords[1])/SCALE + starting_offset[1];
			
			draw_sprite_ext(animator_rotator, 4, mouse_x, mouse_y, 0.5, 0.5, 0, c_white, 0.8);
			
			update_frame();
		
		}
	
	} else controlled = 0;
	
}

if show_org draw_sprite_ext(animator_rotator, 2, x, y, 0.6, 0.6, 0, c_white, 0.8);

global.animation[0][array_length(global.animation[0])-1] = 0;


draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_white)
draw_set_alpha(1)
draw_set_font(font_animator)
draw_text_ext_transformed(x, y - 150, global.message, 20, 300, 1.4, 1.4, 0);

if instance_number(clickable_bone) != array_length(base) {

	with (clickable_bone) {
		instance_destroy();
	}
	
	for(var i = 0; i < array_length(base); i++){
		var o = instance_create_depth(x, y, -10, clickable_bone);
		o.bonid = i;
	}

}
global.hovered = -1;