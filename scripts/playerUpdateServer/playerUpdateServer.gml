function playerUpdateServer(){

	if global.connected and isFpsFrame {

		if (!buffer_exists(updateDataBuffer)) updateDataBuffer = buffer_create(global.dataSize, buffer_fixed, 1);

		buffer_seek(updateDataBuffer, buffer_seek_start, 0);
		buffer_write(updateDataBuffer, buffer_u8, SERVER_REQUEST.POSITION_UPDATE)
		buffer_write(updateDataBuffer, buffer_s32, round(x*100))
		buffer_write(updateDataBuffer, buffer_s32, round(y*100))
		buffer_write(updateDataBuffer, buffer_s32, round(movvec.x*100))
		buffer_write(updateDataBuffer, buffer_s32, round(movvec.y*100))
		buffer_write(updateDataBuffer, buffer_u8, state);
		buffer_write(updateDataBuffer, buffer_u8, on_ground)
		buffer_write(updateDataBuffer, buffer_s8, cdir)
		buffer_write(updateDataBuffer, buffer_u8, slide)
		buffer_write(updateDataBuffer, buffer_s32, round(mousex*100));
		buffer_write(updateDataBuffer, buffer_s32, round(mousey*100));
		network_send_raw(obj_network.server, updateDataBuffer, buffer_get_size(updateDataBuffer));

	}

}