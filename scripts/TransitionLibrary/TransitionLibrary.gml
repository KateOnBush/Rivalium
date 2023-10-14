#macro isLoading global.__loading
#macro inTransition global.__transition
#macro targetRoom global.target_room
#macro loadingText global.__loading_text
#macro loadingGame global.__loading_game

loadingGame = false;
isLoading = false;
inTransition = false;
targetRoom = -1;
loadingText = "LOADING";

function start_loading(target_room = -1, text = "LOADING") {
	
	targetRoom = target_room;
	inTransition = true;
	isLoading = true;
	loadingText = text;
	
}

function finish_loading() {

	isLoading = false;

}

function transition_to_room(target_room) {

	start_loading(target_room);
	finish_loading();

}

function loading_set_game(game) {
	loadingGame = game;
}