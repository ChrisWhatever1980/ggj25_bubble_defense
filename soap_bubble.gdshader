shader_type spatial;

uniform sampler2D noise_texture;
uniform sampler2D color_texture;

uniform float smoothness : hint_range(0.0, 1.0, 0.01);
varying vec3 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	float height = texture(noise_texture, VERTEX.xz * smoothness + vec2(TIME * 0.01)).r;
	VERTEX += NORMAL * height * 0.5;
}

float fresnel(vec3 normal, mat4 camera_matrix)
{
	vec3 view_dir_world = (camera_matrix * vec4(0.0, 0.0, 1.0, 0.0)).xyz;
	vec3 normal_world = (camera_matrix * vec4(normal, 0.0)).xyz;

	float fresnel = dot(view_dir_world, normal_world);
	fresnel = clamp(abs(fresnel), 0.0, 1.0);
	return 1.0 - fresnel;
}

void fragment() {
	float fresnel = fresnel(NORMAL, VIEW_MATRIX);
	ALBEDO = texture(color_texture, world_position.xz + vec2(TIME * 0.05)).rgb;
	ROUGHNESS = 0.0f;
	ALPHA = fresnel;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
