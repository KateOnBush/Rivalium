// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#macro ANIMATIONS_PATH "anim/"

function animations(i){

	switch(i){
		
		case 1: //Kenn
			return {
				animation_idle: require_animation_file(ANIMATIONS_PATH + "b1/i.anim"),
				animation_run: require_animation_file(ANIMATIONS_PATH + "b1/r.anim"),
				animation_jump: require_animation_file(ANIMATIONS_PATH + "b1/j.anim"),
				animation_jump_fast: require_animation_file(ANIMATIONS_PATH + "b1/jfast.anim"),
				animation_flip: require_animation_file(ANIMATIONS_PATH + "b1/f.anim"),
				animation_dash: require_animation_file(ANIMATIONS_PATH + "b1/d.anim"),
				animation_wall: require_animation_file(ANIMATIONS_PATH + "b1/swall.anim"),
				animation_slide: require_animation_file(ANIMATIONS_PATH + "b1/s.anim"),
				animation_grapple: require_animation_file(ANIMATIONS_PATH + "b1/g.anim"),
				animation_grounded: require_animation_file(ANIMATIONS_PATH + "b1/gr.anim"),
				animation_grapple_throw: require_animation_file(ANIMATIONS_PATH + "b1/gthrow.anim"),
				animation_pushed: require_animation_file(ANIMATIONS_PATH + "b1/p.anim"),
				
				kenn_basic_attack: require_animation_file(ANIMATIONS_PATH + "b1/k_battack.anim"),
				kenn_ultimate: require_animation_file(ANIMATIONS_PATH + "b1/k_ult.anim")
			}

		case 2:
			return {
				animation_idle: require_animation_file(ANIMATIONS_PATH + "b2/i.anim"),
				animation_run: require_animation_file(ANIMATIONS_PATH + "b2/r.anim"),
				animation_jump: require_animation_file(ANIMATIONS_PATH + "b2/j.anim"),
				animation_jump_fast: require_animation_file(ANIMATIONS_PATH + "b2/jfast.anim"),
				animation_flip: require_animation_file(ANIMATIONS_PATH + "b2/f.anim"),
				animation_dash: require_animation_file(ANIMATIONS_PATH + "b2/d.anim"),
				animation_wall: require_animation_file(ANIMATIONS_PATH + "b2/swall.anim"),
				animation_slide: require_animation_file(ANIMATIONS_PATH + "b2/s.anim"),
				animation_grapple: require_animation_file(ANIMATIONS_PATH + "b2/g.anim"),
				animation_grounded: require_animation_file(ANIMATIONS_PATH + "b2/gr.anim"),
				animation_grapple_throw: require_animation_file(ANIMATIONS_PATH + "b2/gthrow.anim"),
				animation_pushed: require_animation_file(ANIMATIONS_PATH + "b2/p.anim"),
				
				gramin_shoot_dir: require_animation_file(ANIMATIONS_PATH + "b2/g_battack.anim"),
				gramin_shoot_dir_recoil: require_animation_file(ANIMATIONS_PATH + "b2/g_battack_rec.anim"),
				gramin_ability1: require_animation_file(ANIMATIONS_PATH + "b2/g_ab1.anim"),
				gramin_ultimate: require_animation_file(ANIMATIONS_PATH + "b2/g_ult.anim"),
				
			}
			
		case 3:
		
			return {
				animation_idle: require_animation_file(ANIMATIONS_PATH + "b1/i.anim"),
				animation_run: require_animation_file(ANIMATIONS_PATH + "b1/r.anim"),
				animation_jump: require_animation_file(ANIMATIONS_PATH + "b1/j.anim"),
				animation_jump_fast: require_animation_file(ANIMATIONS_PATH + "b3/jfast.anim"),
				animation_flip: require_animation_file(ANIMATIONS_PATH + "b1/f.anim"),
				animation_dash: require_animation_file(ANIMATIONS_PATH + "b3/d.anim"),
				animation_wall: require_animation_file(ANIMATIONS_PATH + "b1/swall.anim"),
				animation_slide: require_animation_file(ANIMATIONS_PATH + "b1/s.anim"),
				animation_grapple: require_animation_file(ANIMATIONS_PATH + "b1/g.anim"),
				animation_grounded: require_animation_file(ANIMATIONS_PATH + "b1/gr.anim"),
				animation_grapple_throw: require_animation_file(ANIMATIONS_PATH + "b1/gthrow.anim"),
				animation_pushed: require_animation_file(ANIMATIONS_PATH + "b1/p.anim"),
				
				
				shoot_blue_hand: require_animation_file(ANIMATIONS_PATH + "b3/l_battack_b.anim"),
				shoot_red_hand: require_animation_file(ANIMATIONS_PATH + "b3/l_battack_r.anim"),
				ability1: require_animation_file(ANIMATIONS_PATH + "b3/l_ab1.anim"),
				ability2: require_animation_file(ANIMATIONS_PATH + "b3/l_ab2.anim"),
				
				ultimate: require_animation_file(ANIMATIONS_PATH + "b3/l_ult.anim")
			}
			
		case 4:
		
			return {
			
				animation_idle: require_animation_file(ANIMATIONS_PATH + "b4/i.anim"),
				animation_run: require_animation_file(ANIMATIONS_PATH + "b4/r.anim"),
				animation_jump: require_animation_file(ANIMATIONS_PATH + "b4/j.anim"),
				animation_jump_fast: require_animation_file(ANIMATIONS_PATH + "b4/jfast.anim"),
				animation_flip: require_animation_file(ANIMATIONS_PATH + "b4/f.anim"),
				animation_dash: require_animation_file(ANIMATIONS_PATH + "b4/d.anim"),
				animation_wall: require_animation_file(ANIMATIONS_PATH + "b4/swall.anim"),
				animation_slide: require_animation_file(ANIMATIONS_PATH + "b4/s.anim"),
				animation_grapple: require_animation_file(ANIMATIONS_PATH + "b4/g.anim"),
				animation_grounded: require_animation_file(ANIMATIONS_PATH + "b4/gr.anim"),
				animation_grapple_throw: require_animation_file(ANIMATIONS_PATH + "b4/gthrow.anim"),
				animation_pushed: require_animation_file(ANIMATIONS_PATH + "b4/p.anim"),
				
				swing: require_animation_file(ANIMATIONS_PATH + "b4/m_battack.anim"),
				swing_midair: require_animation_file(ANIMATIONS_PATH + "b4/m_battack_air.anim"),
				
				swing_alt: require_animation_file(ANIMATIONS_PATH + "b4/m_battack_altern.anim"),
				swing_alt_midair: require_animation_file(ANIMATIONS_PATH + "b4/m_battack_altern_air.anim"),
				
				ability1_swing: require_animation_file(ANIMATIONS_PATH + "b4/m_ability1.anim"),
				
				ultimate: require_animation_file(ANIMATIONS_PATH + "b4/m_ult.anim")
				
			}
		
	}
	

}