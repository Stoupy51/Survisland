#version 330

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
#moj_import <minecraft:fog.glsl>
#endif

#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:globals.glsl>

uniform sampler2D Sampler0;

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
in float sphericalVertexDistance;
in float cylindricalVertexDistance;
#endif

in vec4 vertexColor;
in vec2 texCoord0;
flat in int isCrt;

out vec4 fragColor;

#ifdef IS_GRAYSCALE
#define GLYPH(uv) texture(Sampler0, uv).r
#else
#define GLYPH(uv) texture(Sampler0, uv).a
#endif

vec4 crtColor(vec4 texColor) {
    // Red and blue sampled a third of a texel apart, for the fringes of a badly converged tube
    vec2 texel = 1.0 / vec2(textureSize(Sampler0, 0));
    float red = GLYPH(texCoord0 + vec2(texel.x / 3.0, 0.0));
    float blue = GLYPH(texCoord0 - vec2(texel.x / 3.0, 0.0));
    vec3 phosphor = vec3(0.35 * red, texColor.a, 0.55 * blue) * vec3(0.55, 1.0, 0.7);

    float ticks = fract(GameTime) * 24000.0;
    float scanline = 0.75 + 0.25 * sin(gl_FragCoord.y * 3.14159 - ticks * 0.8);
    float flicker = 0.92 + 0.08 * sin(ticks * 2.3);
    return vec4(phosphor * scanline * flicker * 1.4, max(texColor.a, max(red, blue)) * vertexColor.a);
}

void main() {
#ifdef IS_GRAYSCALE
    vec4 texColor = texture(Sampler0, texCoord0).rrrr;
#else
    vec4 texColor = texture(Sampler0, texCoord0);
#endif

#ifdef IS_SEE_THROUGH
    vec4 color = texColor * vertexColor;
#else
    vec4 color = texColor * vertexColor * ColorModulator;
#endif
    if (isCrt == 1) {
        color = crtColor(texColor) * ColorModulator;
    }
    if (color.a < 0.1) {
        discard;
    }

#ifdef IS_SEE_THROUGH
    fragColor = color * ColorModulator;
#elif defined(IS_GUI)
    fragColor = color;
#else
    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
#endif
}
