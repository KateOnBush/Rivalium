/// @description Insert description here
// You can write your code in this editor

angle -= 8*dtime;

if inTransition {

	transitionProgress = dtlerp(transitionProgress, 1, .06);
	
	if transitionProgress > .999 && !isLoading {
		
		if targetRoom != -1 room_goto(targetRoom);
		inTransition = false;
		
	}
	
	if transitionProgress > .999 && isLoading {
		
		if (displayLoadingText != loadingText) {
			loadingBlend = dtlerp(loadingBlend, 0, 0.3);
			if (loadingBlend < .01) {
				displayLoadingText = loadingText;	
			}
		} else {
			loadingBlend = dtlerp(loadingBlend, 1, 0.3);
			loadingProgress = dtlerp(loadingProgress, 1, 0.005);
			gameLoadingBlend = dtlerp(gameLoadingBlend, loadingGame, 0.05);
		}
	
	}

} else {

	transitionProgress = dtlerp(transitionProgress, 0, .1);
	loadingProgress = dtlerp(loadingProgress, 0, 0.1);
	gameLoadingBlend = dtlerp(gameLoadingBlend, 0, 0.05);
	
}