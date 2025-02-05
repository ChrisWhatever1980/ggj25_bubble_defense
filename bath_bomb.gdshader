shader_type spatial;

uniform sampler2D noise_texture;
uniform sampler2D color_texture;

uniform float bubble_size = 0.5;
uniform float smoothness : hint_range(0.0, 1.0, 0.01);
uniform float dissolve : hint_range(0.0, 2.0, 0.01);

varying vec3 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	float height = texture(noise_texture, VERTEX.xz * smoothness).r;
	VERTEX += NORMAL * height * bubble_size;
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
	float dissolve_noise = texture(noise_texture, world_position.xz).r;

	if (fresnel < dissolve_noise * dissolve)
		discard;

	ALBEDO = texture(color_texture, world_position.xz).rgb;
	ROUGHNESS = 0.0f;
	ALPHA = 1.0;
}