/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var reqs = struct_get_key_failsafe(userdata_get_self(), "friendManager.receivedFriendRequests") ?? [];
count = array_length(reqs);
