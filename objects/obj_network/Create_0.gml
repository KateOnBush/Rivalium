/// @description Insert description here
// You can write your code in this editor

depth = -100;

server_ip = "127.0.0.1";

port = 2003;

TCPsocket = network_create_socket(network_socket_ws);
network_connect_raw_async(TCPsocket, server_ip, port);
UDPsocket = network_create_socket(network_socket_udp);


global.dataSize = 64;

global.ping = 0;

global.connected = false;
global.identified = false;
global.loading = true;
global.starting = false;
loadingAlpha = 0;
s = 0;

global.playerid = -1;

global.players = ds_map_create();

global.size = 0;

start_loading(, "CONNECTING");