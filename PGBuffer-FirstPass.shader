// PG-Buffer Shader
shader_type spatial;

uniform float whateverElseYouWantToPass = 0.0;

void fragment() {
	ALBEDO = vec3(0.);
}

void light() {
	// Lighting computation. Here are the parts :
	// 1. In case of several lights, we add the previous result of DIFFUSE_LIGHT.g
	float l = DIFFUSE_LIGHT.g +
	// 2. The classic n dot l from Kajiya's rendering equation. Usually sufficient, but adjustable as needed.
		(clamp(dot(NORMAL, LIGHT), 0.0, 1.0) *
	// 3. ATTENUATION allows us to access the shadow map basically, allowing us to include shadows.
		vec3(0.,ATTENUATION.g, 0.)).g;
	
	// And now store it with whatever else you want to store.
	DIFFUSE_LIGHT = vec3(whateverElseYouWantToPass, l, 0.0);
}
