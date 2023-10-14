function perform_flip(_forward, _start){

	flipping = true;
	flipping_forward = _forward;
	flip = _start;
	
	if global.connected && object_index == obj_player {
	
		var buff = buffer_create(global.dataSize, buffer_fixed, 1);
		buffer_seek(buff, buffer_seek_start, 0);
		buffer_write(buff, buffer_u8, ServerRequest.FLIP);
		buffer_write(buff, buffer_u8, _forward);
		buffer_write(buff, buffer_u8, round(_start*100))
		network_send_raw(obj_network.server, buff, buffer_get_size(buff));
	
	}

}

function play_animation(animation, speed, type, bones = [], priority = false, blendspeed = 0.2){

	animation_playing = 1;
	animation_played_speed = speed;
	animation_played_prog = 0;
	animation_played_type = type;
	animation_played = animation;
	animation_played_bones = bones;
	animation_played_priority = priority;
	animation_blend_speed = blendspeed;

}

function step_animation(){
	
	if animation_played_prog >= 0.99 {
	
		animation_playing = 0;
		animation_played_prog = 0.99;
	
	}

	if animation_played_type = animation_type_full {
	
		currentframe = animation_blend(currentframe, animation_get_frame(animation_played, animation_played_prog), animation_playing_blend);
		
	} else if animation_played_type = animation_type_partial{
	
		currentframe = animation_blend_partial(currentframe, animation_get_frame(animation_played, animation_played_prog), animation_playing_blend, animation_played_bones);
	
	}

}

function setup_character(n){
	
	character_id = n;
	char = Characters[character_id]();
	spd = char.speed;
	sprite = char.sprite
	offset = [sprite_get_xoffset(sprite),sprite_get_yoffset(sprite)]
	currentframe = animation_get_frame(char.anims.animation_idle, 0);
	base = char.base;
	
}

function bone_depth_sorting(bone1, bone2){

	return currentframe[bone2][4] - currentframe[bone1][4];

}

function cast_ability(a, n){

	with(self){

		switch(a){
			
			case 0:
					
				char.abilities.basic_attack.cast(n);
				break;
					
			case 1:
					
				char.abilities.ability1.cast(n);
				break;
					
			case 2:
					
				char.abilities.ability2.cast(n);
				break;
					
			case 3:
					
				char.abilities.ultimate.cast(n);
				break;
				
					
			
	}
	
	}

}