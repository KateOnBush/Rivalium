// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_depth(0)
gpu_set_alphatestref(2);
gpu_set_alphatestenable(true);
gpu_set_texrepeat(true);
gpu_set_cullmode(cull_noculling)

vertex_format_begin();

vertex_format_add_position_3d();
vertex_format_add_texcoord();
vertex_format_add_color();

global.v_format = vertex_format_end();

vertex_format_begin();

vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();

global.v_format_models = vertex_format_end();

global.obj_format_vertices = [];
global.obj_format_faces = [];
function vertex_rotate_and_move(Vertex) {
	var returned = new Vector2(Vertex.x, Vertex.y);
	returned.polar(Vertex.dir() + image_angle, returned.length());
	returned.x += x; returned.y += y;
	returned.z = Vertex.z;
	return returned;
}
function obj_format_add_point(Point) {
	array_push(global.obj_format_vertices, [Point.x, Point.y, Point.z]);
}
function obj_format_save() {
	var openFile = get_save_filename("", "");
	if (openFile != "") {
		var file = file_text_open_write(openFile);
		for(var i = 0; i < array_length(global.obj_format_vertices); i++) {
			var vertex = global.obj_format_vertices[i];
			file_text_write_string(file, string("v {0} {1} {2}", vertex[0], vertex[1], vertex[2]));
			file_text_writeln(file);
		}
		for(var i = 0; i < array_length(global.obj_format_faces); i++) {
			var face = global.obj_format_faces[i];
			file_text_write_string(file, string("f {0} {1} {2} {3}", face[0], face[1], face[2], face[3]));
			file_text_writeln(file);
		}
		file_text_close(file);
		show_message_async("OBJ File Generated");
	}
}

function Vector3(_x, _y, _z) constructor{
	
    x = _x;
    y = _y;
	z = _z;
	
	static dir = function(){
	
		return point_direction(0, 0, x, y);
	
	}
	
	static polar = function(direction, length){
	
		self.x = lengthdir_x(length, direction);
		self.y = lengthdir_y(length, direction);
		
		return self;
	
	}

    static add = function(v)
    {
		
		if is_struct(v){
			return new Vector3(x + v.x, y + v.y, z + v.z);
		} else {
			return new Vector3(x + v, y + v, z + v);
		}
        
    }
	
	static subtract = function(v)
    {
		
		if is_struct(v){
			return new Vector3(x - v.x, y - v.y, z - v.z);
		} else {
			return new Vector3(x - v, y - v, z - v);
		}
        
    }
	
	static length = function(){
	
		return sqrt(x*x+y*y+z*z);
	
	}
	
	static multiply = function(v){
	
		if is_struct(v){
			return new Vector3(x * v.x, y * v.y, z * v.z);
		} else {
			return new Vector3(x * v, y * v, z * v);
		}
	
	}
	
	static inverse = function(){
	
		return new Vector3(x!=0 ? 1/x : x, y != 0 ? 1/y : y, z!= 0 ? 1/z : 0);
	
	}
	
	static normalize = function(){
	
		var mag = self.length();
	
		return new Vector3(x/mag, y/mag, z/mag);
	
	}
	
	static divide = function(v){
	
		if is_struct(v){
			return new Vector3(x / v.x, y / v.y, z / v.z);
		} else {
			return new Vector3(x / v, y / v, z / v);
		}
	
	}
	
	static dot = function(vec){
	
		return x*vec.x + y*vec.y + z*vec.z;
	
	}
	
	static cross = function(vec){
	
		var i = y * vec.z - z * vec.y;
		var j = z * vec.x - x * vec.z;
		var k = x * vec.y - y * vec.x;
		
		return new Vector3(i, j, k);
	
	}
	
}

function Vector2(x , y): Vector3(x, y, 0) constructor{

	static dir = function(){
	
		return point_direction(0, 0, x, y);
	
	}
	
	static polar = function(direction, length){
	
		self.x = lengthdir_x(length, direction);
		self.y = lengthdir_y(length, direction);
		
		return self;
	
	}

}

function vector_generate_cube_coordinates(Pos1Vector3, Pos2Vector3){

	var i = 0, j = 0, k = 0;
	
	var vectors = [Pos1Vector3, Pos2Vector3];
	var result = [];	

	repeat(2){
		
		j = 0;
		
		repeat(2){
		
			i = 0;
		
			repeat(2){
			
					array_push(result, new Vector3(vectors[i].x, vectors[j].y, vectors[k].z));
				
				i++;
				
			}
			j++;
			
		}
		k++;
	}

	return result;

}

function vertex_add_point(VertexBuffer, PositionVector3, TexCoordVector2, Color){

	var pos = PositionVector3;
	var uv = TexCoordVector2;
	var col = Color;
	var buffer = VertexBuffer;
	
	vertex_position_3d(buffer, pos.x, pos.y, pos.z);
	vertex_texcoord(buffer, uv.x, uv.y);
	vertex_color(buffer, col, 1);

}

function vertex_add_triangle(VertexBuffer, Pos1Vector3, Pos2Vector3, Pos3Vector3, Tex1Vector2, Tex2Vector2, Tex3Vector2, Color){
	
	vertex_add_point(VertexBuffer, Pos1Vector3, Tex1Vector2, Color);
	vertex_add_point(VertexBuffer, Pos2Vector3, Tex2Vector2, Color);
	vertex_add_point(VertexBuffer, Pos3Vector3, Tex3Vector2, Color);

}
	
function vertex_add_square(VertexBuffer, Pos1, Pos2, Pos3, Pos4, Tex1, Tex2, Tex3, Tex4, Color){

	vertex_add_triangle(VertexBuffer, Pos1, Pos2, Pos3, Tex1, Tex2, Tex3, Color);
	vertex_add_triangle(VertexBuffer, Pos2, Pos3, Pos4, Tex2, Tex3, Tex4, Color);

}

function vertex_add_square_repeated_tex(VertexBuffer, Pos1, Pos2, Pos3, Pos4, xamount, yamount, Color){

	var b = VertexBuffer;
	
	var xsize = Pos1.subtract(Pos3).length()/xamount;
	var ysize = Pos1.subtract(Pos2).length()/yamount;
	
	var size_vec = new Vector2(xsize, ysize);
	
	var texc = [
	new Vector2(0, 0),
	new Vector2(0, 1).multiply(size_vec),
	new Vector2(1, 0).multiply(size_vec),
	new Vector2(1, 1).multiply(size_vec)
	]
	
	vertex_add_square(b, Pos1, Pos2, Pos3, Pos4, texc[0], texc[1], texc[2], texc[3], Color);

}

function vertex_add_cube_repeated_tex(VertexBuffer, Pos1, Pos2, Color, xamount, yamount){

	var b = VertexBuffer;
	
	var c = vector_generate_cube_coordinates(Pos1, Pos2);
	
	var i = array_length(global.obj_format_vertices);
	
	obj_format_add_point(vertex_rotate_and_move(c[0]));
	obj_format_add_point(vertex_rotate_and_move(c[1]));
	obj_format_add_point(vertex_rotate_and_move(c[2]));
	obj_format_add_point(vertex_rotate_and_move(c[3]));
	obj_format_add_point(vertex_rotate_and_move(c[4]));
	obj_format_add_point(vertex_rotate_and_move(c[5]));
	obj_format_add_point(vertex_rotate_and_move(c[6]));
	obj_format_add_point(vertex_rotate_and_move(c[7]));

	array_push(global.obj_format_faces, [i + 1, i + 2, i + 4, i + 3]);
	array_push(global.obj_format_faces, [i + 1, i + 2, i + 6, i + 5]);
	array_push(global.obj_format_faces, [i + 3, i + 4, i + 8, i + 7]);
	array_push(global.obj_format_faces, [i + 1, i + 3, i + 7, i + 5]);
	array_push(global.obj_format_faces, [i + 2, i + 4, i + 8, i + 6]);
	array_push(global.obj_format_faces, [i + 5, i + 6, i + 8, i + 7]);
	
	vertex_add_square_repeated_tex(b, c[0], c[1], c[2], c[3], xamount, yamount, Color);
	
	vertex_add_square_repeated_tex(b, c[0], c[1], c[4], c[5], xamount, yamount, Color);
	
	vertex_add_square_repeated_tex(b, c[2], c[3], c[6], c[7], xamount, yamount, Color);
	
	vertex_add_square_repeated_tex(b, c[0], c[2], c[4], c[6], xamount, yamount, Color);
	
	vertex_add_square_repeated_tex(b, c[1], c[3], c[5], c[7], xamount, yamount, Color);
	
	vertex_add_square_repeated_tex(b, c[4], c[5], c[6], c[7], xamount, yamount, Color);

}

function vertex_add_cube_full(VertexBuffer, Pos1, Pos2, Color){

	vertex_add_cube_repeated_tex(VertexBuffer, Pos1, Pos2, Color, 1, 1);

}

function raycast_line_to_plane(RayOriginVector3, RayDirectionVector3, PlaneOriginVector3, PlaneNormalVector3){

	var rayo = RayOriginVector3;
	var rayd = RayDirectionVector3;
	var planeo = PlaneOriginVector3;
	var planen = PlaneNormalVector3;
	
	var a = planen.x;
	var b = planen.y;
	var c = planen.z;
	
	var delta = - (a*planeo.x + b*planeo.y + c*planeo.z);
	
	var eqx = [rayd.x, rayo.x];
	var eqy = [rayd.y, rayo.y];
	var eqz = [rayd.z, rayo.z];
	
	var dot = planen.dot(rayd);
	
	if dot == 0 return new Vector3(0, 0, 0);
	
	var t = - (a * eqx[1] + b * eqy[1] + c * eqz[1] + delta)/(dot);
	
	return new Vector3(eqx[0] * t + eqx[1], eqy[0] * t + eqy[1], eqz[0] * t + eqz[1]);


}

function camera_2dpoint_to_vector(camera, x, y){

	var V = camera_get_view_mat(camera);
	var P = camera_get_proj_mat(camera);

	var mx = 2 * (x / window_get_width() - .5) / P[0];
	var my = 2 * (y / window_get_height() - .5) / P[5];
	var camX = - (V[12] * V[0] + V[13] * V[1] + V[14] * V[2]);
	var camY = - (V[12] * V[4] + V[13] * V[5] + V[14] * V[6]);
	var camZ = - (V[12] * V[8] + V[13] * V[9] + V[14] * V[10]);

	if (P[15] == 0)
	{    //This is a perspective projection
	    return [new Vector3(V[2]  + mx * V[0] + my * V[1],
	            V[6]  + mx * V[4] + my * V[5],
	            V[10] + mx * V[8] + my * V[9]),
				new Vector3(
	            camX,
	            camY,
	            camZ)];
	}
	else
	{    //This is an ortho projection
	    return [new Vector3(V[2], V[6], V[10]),
				new Vector3(
	            camX + mx * V[0] + my * V[1],
	            camY + mx * V[4] + my * V[5],
	            camZ + mx * V[8] + my * V[9])];
	}
	
}

/// @func convert_3d_to_2d(viewMat, projMat, x, y, z)
function convert_3d_to_2d(V, P, _x, _y, _z)
{
    /*
        Transforms a 3D coordinate to a 2D coordinate. Returns an array of the following format:
        [x, y]
        where x and y are between (0, 0) (top left) and (1, 1) (bottom right) of the screen
        Returns [-1, -1] if the 3D point is behind the camera

        Works for both orthographic and perspective projections.

        Script created by TheSnidr
        www.thesnidr.com
    */
    var w = V[2] * _x + V[6] * _y + V[10] * _z + V[14];
    if (w <= 0)
    {
        return [-1, -1];
    }
    var cx, cy;
    if (P[15] == 0)
    {    //This is a perspective projection
        cx = P[8] + P[0] * (V[0] * _x + V[4] * _y + V[8] * _z + V[12]) / w;
        cy = P[9] + P[5] * (V[1] * _x + V[5] * _y + V[9] * _z + V[13]) / w;
    }
    else
    {    //This is an ortho projection
        cx = P[12] + P[0] * (V[0] * _x + V[4] * _y + V[8]  * _z + V[12]);
        cy = P[13] + P[5] * (V[1] * _x + V[5] * _y + V[9]  * _z + V[13]);
    }
    return new Vector2(.5 + .5 * cx, .5 - .5 * cy);
}
