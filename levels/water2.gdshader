shader_type spatial;
render_mode cull_disabled;

uniform float speed = 0.0;

uniform sampler2D noise1;
uniform sampler2D noise2;
uniform sampler2D normalmap;

uniform sampler2D depth_texture : hint_depth_texture;
uniform sampler2D screen_texture : hint_screen_texture;

uniform vec4 color;
uniform vec4 deep_water;

uniform float beer_law_factor = 2.0;
uniform float _distance = 1.0;

uniform vec4 edge_color;
uniform float edge_scale = 0.25;
uniform float near = 0.1;
uniform float far = 100.0;

uniform vec2 wave_strength = vec2(0.5, 0.25);
uniform vec2 wave_frequ = vec2(12.0, 12.0);
uniform vec2 time_factor = vec2(1.0, 2.0);

float waves(vec2 pos, float time) {
	return wave_strength.y * sin(pos.y * wave_frequ.y + time * time_factor.y)
	     + wave_strength.x * sin(pos.x * wave_frequ.x + time * time_factor.x);
}

void vertex() {
	VERTEX.y += waves(VERTEX.xz, TIME);
}

float rim(float depth) {
	depth = 2.0 * depth - 1.0;
	return near * far / (far + depth * (near - far));
}

float calc_depth_fade(float depth, mat4 projection_matrix, vec4 fragcoord, float beer_factor, float __distance, vec3 vertex) {
	float scene_depth = depth;
	scene_depth = scene_depth * 2.0 - 1.0;
	scene_depth = projection_matrix[3][2] / (scene_depth + projection_matrix[2][2]);
	scene_depth += vertex.z;
	float transmittance = exp(-scene_depth * beer_factor);
	float screen_depth = fragcoord.z;
	float depth_fade = (transmittance - screen_depth) / __distance;
	depth_fade = clamp(depth_fade, 0.0, 1.0);
	return depth_fade;
}

void fragment() {
	float time = TIME * speed;

	vec3 n1 = texture(noise1, UV + vec2(time, time)).rgb;
	vec3 n2 = texture(noise2, UV - vec2(time * 0.2, time * 0.2)).rgb;

	vec2 uv_movement = UV * 4.0 + TIME * speed * 4.0;

	float sum = (n1.r + n2.r) - 1.0;

	float z_depth = rim(texture(depth_texture, SCREEN_UV).r);
	float z_pos = rim(FRAGCOORD.z);
	float diff = z_depth - z_pos;

	float z_depth_fade = calc_depth_fade(texture(depth_texture, SCREEN_UV).r, PROJECTION_MATRIX, FRAGCOORD, beer_law_factor, _distance, VERTEX);
	float z_fade = rim(FRAGCOORD.z);
	float fade_diff = z_depth_fade - z_fade;

	vec4 gradient_color = mix(color, deep_water, z_depth_fade);

	vec2 displacement = vec2(sum * 0.1);
	diff += displacement.x * 70.0;

	vec4 col = mix(edge_color, gradient_color, step(edge_scale, diff));

	vec4 screen_sample = texture(screen_texture, SCREEN_UV + displacement);

	float fin = 0.0;
	if (sum > 0.0 && sum < 0.4) fin = 0.1;
	else if (sum > 0.8) fin = 1.0;

	ALBEDO = vec3(fin) + mix(screen_sample.rgb, col.rgb, gradient_color.a);

	NORMAL_MAP = texture(normalmap, uv_movement).rgb;
	ROUGHNESS = 0.1;
}
