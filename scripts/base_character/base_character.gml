function base_character(i) {
	
	var bones = [];
	
	if i == 1{
		
		//bone[n] = [x,y,parent]
		bones[0] = [37,32,7]
		bones[1] = [35,45,0]
		bones[3] = [42,64,2]
		bones[2] = [42,53,8]
		bones[5] = [52,64,4]
		bones[4] = [49,53,8]
		bones[6] = [45,28,7]
		bones[7] = [46,44,8]
		bones[8] = [45,53,-1]
		bones[9] = [55,45,10]
		bones[10] = [53,32,7]

	} else if i == 2 {

		//bone[n] = [x,y,parent]
		bones[0] = [37,32,8]
		bones[1] = [35,45,0]
		bones[2] = [34,59,1]
		bones[3] = [42,53,9]
		bones[4] = [42,64,3]
		bones[5] = [49,53,9]
		bones[6] = [52,64,5]
		bones[7] = [45,28,8]
		bones[8] = [46,44,9]
		bones[9] = [45,53,-1]
		bones[10] = [55,45,11]
		bones[11] = [53,32,8]
			
	}
	
	return bones;
}
