//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_start;
uniform vec2 u_end;
uniform vec2 u_resolution;

void main()
{
	
	vec2 pos = gl_FragCoord.xy/u_resolution;
	
	float insideRect = step(pos.x, u_end.x) * step(pos.y, u_end.y) * (1.0 - step(pos.x, u_start.x)) * (1.0 - step(pos.y, u_start.y));
	
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord ) * insideRect;
    
}
