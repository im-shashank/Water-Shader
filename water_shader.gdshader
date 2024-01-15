shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform sampler2D noise2 : repeat_enable;
uniform vec2 scrollSpeed = vec2(0.1,0.099);
uniform vec2 scrollSpeed2 = vec2(-0.1,0.1);
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float distortion_strenght : hint_range(-1.0, 1.0) = 0.2;
uniform vec4 toneColor : source_color;
uniform vec4 topColor : source_color;
uniform float light_start : hint_range(0.0, 1.0) = 0.275;
uniform float light_end : hint_range(0.0, 1.0) = 0.4;

void fragment() {
	vec4 noise_color = texture(noise, UV + TIME*scrollSpeed) * texture(noise2, UV + TIME*scrollSpeed2);
	vec4 screen_color = texture(screen_texture, SCREEN_UV + distortion_strenght*noise_color.rr);
	vec4 topLigtColor = smoothstep(light_start, light_end, noise_color) * topColor;
	COLOR = screen_color * toneColor * topColor;
	COLOR.a = 1.0;
}

