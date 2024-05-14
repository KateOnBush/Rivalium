//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


void main() {
    // Define the border width
    float borderWidth = 0.001; // You can adjust this as needed

    // Get the texture coordinates of the current pixel
    vec2 uv = v_vTexcoord;
	
    // Sample the alpha value of the current pixel
    float alpha = texture2D(gm_BaseTexture, uv).a;

    // Initialize the border color
    vec4 borderColor = vec4(1.0, 0.0, 0.0, 1);
	vec4 currentColor = texture2D(gm_BaseTexture, uv);

    // Perform edge detection to identify border pixels
    float totalAlphas = texture2D(gm_BaseTexture, uv + vec2(borderWidth, 0.0)).a +
                      texture2D(gm_BaseTexture, uv - vec2(borderWidth, 0.0)).a +
                      texture2D(gm_BaseTexture, uv + vec2(0.0, borderWidth)).a +
                      texture2D(gm_BaseTexture, uv - vec2(0.0, borderWidth)).a;
					  
	float averageAlpha = alpha - totalAlphas / 4.0;

    // Compute the border color directly based on the edge detection result
    vec4 finalColor = mix(currentColor, borderColor, averageAlpha);

    // Mix the border color with the original color based on whether it's a border pixel or not
    gl_FragColor = v_vColour * finalColor;
	
}
