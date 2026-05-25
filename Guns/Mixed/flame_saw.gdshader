shader_type canvas_item;

uniform vec4 glow_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform float glow_size = 3.0;
uniform float glow_strength = 1.5;
uniform float bottom_boost = 2.0;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);

    float center = tex.a;
    vec2 ps = TEXTURE_PIXEL_SIZE * glow_size;

    float outline = 0.0;

    outline += texture(TEXTURE, UV + vec2(ps.x, 0.0)).a;
    outline += texture(TEXTURE, UV + vec2(-ps.x, 0.0)).a;
    outline += texture(TEXTURE, UV + vec2(0.0, ps.y)).a;

    outline += texture(TEXTURE, UV + vec2(0.0, -ps.y * bottom_boost)).a * 2.0;

    outline += texture(TEXTURE, UV + vec2(ps.x, ps.y)).a;
    outline += texture(TEXTURE, UV + vec2(-ps.x, ps.y)).a;
    outline += texture(TEXTURE, UV + vec2(ps.x, -ps.y)).a;
    outline += texture(TEXTURE, UV + vec2(-ps.x, -ps.y)).a;
    outline = clamp(outline - center * 8.0, 0.0, 1.0);

    vec3 final_rgb = tex.rgb + glow_color.rgb * outline * glow_strength;

    COLOR = vec4(final_rgb, tex.a + outline * glow_color.a);
}
