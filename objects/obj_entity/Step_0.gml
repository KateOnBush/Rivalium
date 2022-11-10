/// @description Insert description here
// You can write your code in this editor


if physicsComponent != undefined {

	//Physics
	
	physicsComponent.movvec.y += grav*dtime;
	x += physicsComponent.movvec.x*dtime;
	y += physicsComponent.movvec.y*dtime;
	

}