/// @description Insert description here
// You can write your code in this editor

alreadyConnected = false;
timerReconnect = 0;
reconnectionAttempts = 0;

accountServer = network_create_socket(network_socket_ws);
network_set_timeout(accountServer, EventTimeoutTime * 1000, EventTimeoutTime * 1000);
account_server_attempt_connection();

timeSinceLastHeartbeat = 0;
lastHeartbeatConfirmed = true;

lostConnectionMessage = -1;