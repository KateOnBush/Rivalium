function playerUpdateServer(){

	if global.connected and isFpsFrame {

		UpdateMessage.counter = sending_counter;
		sending_counter++;
		UpdateMessage.x = x;
		UpdateMessage.y = y;
		UpdateMessage.movX = movvec.x;
		UpdateMessage.movY = movvec.y;
		UpdateMessage.state = state;
		UpdateMessage.onGround = on_ground;
		UpdateMessage.orientation = cdir == 1 ? 1 : 0;
		UpdateMessage.slide = slide;
		UpdateMessage.mouseX = mousex;
		UpdateMessage.mouseY = mousey;
		
		gameserver_send(UpdateMessage, false);

	}

}