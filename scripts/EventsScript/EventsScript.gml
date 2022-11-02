// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.events = [];


/**
 * @param {real} time 
 * @param {function} eventfunc
 */
function Event(time, eventfunc) constructor{
	
	self.time = time;
	self.eventfunc = eventfunc;

	static update = function(){
	
		self.time -= dtime/60;
		if self.time <=0 {
			
			var t = method_get_self(eventfunc);
			array_delete(global.events,array_find_by_value(global.events, self),1);
			if (t and !instance_exists(t)) return;
			eventfunc();
		
		}
	
	}

}

function createEvent(time, execfunction){

	var t = new Event(time, execfunction);
	
	array_push(global.events, t);

}

function processEvents(){

	for(var j = 0; j < array_length(global.events); j++){
	
		global.events[j].update();
	
	}

}