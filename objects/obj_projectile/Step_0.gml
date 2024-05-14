/// @description Insert description here
// You can write your code in this editor

mask_index = projectile_collision_mask;

life -= global.dt/60;

if life<0 instance_destroy();

if col and spd > 0 {
	
	var pl = checkPlayer();
	var plSelf = checkPlayerSelf();
	
	if plSelf {
	
		visible = false;
		createEvent(0.5, visibleTimeout, self);
	
	}
	
	if check() or pl {
	
		if pl {
		
			var projectileHit = new TReqPlayerHit();
			projectileHit.projectileId = ID;
			projectileHit.objectId = id;
			projectileHit.hitId = pl.ID;
			projectileHit.x = px;
			projectileHit.y = py;
			
			gameserver_send(projectileHit);
			
			on_hit(pl);
			with (pl) { 
				playerHit();
			}
		
		}
	
		var n = 0;
		if !pl while(!place_meeting(px+lengthdir_x(n,dir), py+lengthdir_y(n,dir), obj_impenetrable) and n<spd){
			n++;
		}
		
		var collidedBlock = instance_place(px+lengthdir_x(n+1,dir), py+lengthdir_y(n+1,dir), obj_impenetrable);
		var collidedWithEntity = noone;
		
		if collidedBlock != noone {
			
			var e = collidedBlock.object_index;
			if (e == obj_obstacle_entity || e == obj_obstacle_entity_imp) {
				collidedBlock.componentTo.damage(ID);
				collidedWithEntity = collidedBlock.componentTo;
			}
			
		}
		
		if !bounce and !pl {
		
			px += lengthdir_x(n,dir);
			py += lengthdir_y(n,dir);
			spd = 0;
			
			if dieoncol {
				on_destroy();
				destroy();
			}
			
		
		} else if !pl {
	
			if !instance_exists(collidedBlock) exit;
			var orientation = collidedBlock.image_angle;
			orientation = angle_difference(orientation, floor(orientation/90)*90);
			
			var s = 0;
			while(place_meeting(px+lengthdir_x(s,dir + 180), py+lengthdir_y(s,dir + 180), obj_impenetrable)){
				s+=dtime;
			}
			px += lengthdir_x(s, dir + 180);
			py += lengthdir_y(s, dir + 180);
			
			var ar = [orientation, orientation + 90, orientation + 180, orientation + 270];
			var o = dir + 180;
			for(var i = 0; i < array_length(ar); i++){
				var cDir = ar[i];
				if place_meeting(px+lengthdir_x(2, cDir), py+lengthdir_y(2, cDir), obj_impenetrable){
					o = cDir;
					break;
				}
			}
			
			dir = o - angle_difference(dir + 180, o);
			
			bounce_count++;
			spd *= bounceFriction;
		
		}
		
		if (ownerID == global.playerid) && !pl {
		
			var projectileUpdate = new UReqProjectileUpdate();
			
			projectileUpdate.projId = ID;
			projectileUpdate.x = px;
			projectileUpdate.y = py;
			projectileUpdate.movX = lengthdir_x(spd, dir);
			projectileUpdate.movY = lengthdir_y(spd, dir);
			
			gameserver_send(projectileUpdate);
			
		}
		
		collided = true;
		on_collision();
		if dieoncol or pl instance_destroy();
	
	} else {
	
		px += lengthdir_x(spd, dir)*global.dt;
		py += lengthdir_y(spd, dir)*global.dt;
		distance_traveled += spd * dtime;
	
	} 

} else if !col and spd > 0 {
	
	px += lengthdir_x(spd, dir)*global.dt;
	py += lengthdir_y(spd, dir)*global.dt;
	distance_traveled += spd * dtime;

}

if !collided or bounce {

	var _x = lengthdir_x(spd, dir);
	var _y = lengthdir_y(spd, dir);

	var _add = hasGrav ? dtime * grav : 0;
	dir = point_direction(0, 0, _x, _y + _add);
	spd = point_distance(0, 0, _x, _y + _add);
	
}

can_leave_trail = (spd>0 and distance_traveled>256);

image_angle = dir;

x = dtlerp(x, px, 0.9);
y = dtlerp(y, py, 0.9);