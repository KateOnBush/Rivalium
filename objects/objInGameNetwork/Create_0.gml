/// @description Insert description here
// You can write your code in this editor

depth = -100;

server_ip = "127.0.0.1";

port = 2003;

server = network_create_socket(network_socket_ws);

con = network_connect_raw(server, server_ip, port);

global.dataSize = 64;

global.ping = 0;

global.connected = 0;

global.playerid = -1;

if con < 0 {

	
	show_debug_message("Couldn't connect to server");
	

} else{
	
	show_debug_message("NICE! Connected!!!")
	global.connected = 1;

}


global.players = ds_map_create();

global.size = 0;