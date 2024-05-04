function draw_circle_width(argument0, argument1, argument2, argument3, argument4) {
	var xx = argument0, yy = argument1,
	    r = argument2, lod = argument4, 
	    i;
    
	//use foor loop to draw the circle with draw_line_width
	for (i=0; i<360; i+=360/lod)
	{
	    draw_line_width(xx+lengthdir_x(r,i),yy+lengthdir_y(r,i),xx+lengthdir_x(r,i+360/lod),yy+lengthdir_y(r,i+360/lod),argument3)
	};

}

function draw_arc(x1,y1,x2,y2,x3,y3,x4,y4,precision){
    if is_undefined(precision) precision = 24;
    var res,xm,ym,xr,yr,r,a1,a2,sx,sy,a;
    res = 360 / min(max(4,4*(precision div 4)),64);
    xm = (x1+x2)/2;
    ym = (y1+y2)/2;
    xr = abs(x2-x1)/2;
    yr = abs(y2-y1)/2;
    if (xr > 0) r = yr/xr;
    else r = 0;
    a1 = point_direction(0,0,(x3-xm)*r,y3-ym);
    a2 = point_direction(0,0,(x4-xm)*r,y4-ym);
    if (a2<a1) a2 += 360;
    draw_primitive_begin(pr_trianglefan);
	draw_vertex(xm, ym)
    sx = xm+lengthdir_x(xr,a1);
    sy = ym+lengthdir_y(yr,a1);
    draw_vertex(sx,sy);
    for (a=res*(a1 div res + 1); a<a2; a+=res) {
        sx = xm+lengthdir_x(xr,a);
        sy = ym+lengthdir_y(yr,a);
        draw_vertex(sx,sy);
    }
    sx = xm+lengthdir_x(xr,a2);
    sy = ym+lengthdir_y(yr,a2);
    draw_vertex(sx,sy);
    draw_primitive_end();
    return 0;
}

function string_format_time(timer) {
	return string(timer div 60) + ":" + (timer mod 60 < 10 ? "0" : "") + string(timer mod 60); 
}

function draw_text_transformed_shadowed(x, y, str, xscale, yscale, angle) {

	var col = draw_get_color();
	var alpha = draw_get_alpha();
	draw_set_color(c_black);
	draw_set_alpha(0.1 * alpha);
	draw_text_transformed(x + xscale, y, str, xscale, yscale, angle);
	draw_text_transformed(x + xscale, y + yscale, str, xscale, yscale, angle);
	draw_text_transformed(x - xscale, y, str, xscale, yscale, angle);
	draw_text_transformed(x - xscale, y + yscale, str, xscale, yscale, angle);
	draw_text_transformed(x, y + yscale, str, xscale, yscale, angle);
	draw_set_color(col);
	draw_set_alpha(alpha);
	draw_text_transformed(x, y, str, xscale, yscale, angle);

}