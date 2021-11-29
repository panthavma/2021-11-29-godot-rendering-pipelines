// Full Screen Pass
shader_type canvas_item;

uniform sampler2D pgBuffer : hint_black;

void fragment() {
	// Get the values from the PG-Buffer
	vec3 pgBufferSample = texture(pgBuffer, SCREEN_UV).rgb;
	
	// Setting up the colors I'm going to use
	vec3 litColor = mix(vec3(0.7), vec3(1., 0.2, 0.2), pgBufferSample.r);
	vec3 shadowColor = mix(vec3(0.1), vec3(0.8, 0., 0.), pgBufferSample.r);
	
	// Thresholding the light coefficient to make hard shadows
	float lightCoef = step(0.3, pgBufferSample.g);
	
	// Applying the results
	vec3 finalColor = mix(shadowColor, litColor, lightCoef);
	COLOR = vec4(finalColor, 1.);
}