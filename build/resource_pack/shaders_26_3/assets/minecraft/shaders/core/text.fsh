#version 330
#extension GL_ARB_separate_shader_objects : require

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
#include <minecraft:fog.glsl>
#endif

#include <minecraft:dynamictransforms.glsl>
#include <minecraft:globals.glsl>
#include <minecraft:oit.glsl>

uniform sampler2D Sampler0;

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
layout(location = 0) in float sphericalVertexDistance;
layout(location = 1) in float cylindricalVertexDistance;
#endif

layout(location = 2) in vec4 vertexColor;
layout(location = 3) in vec2 texCoord0;
layout(location = 4) flat in int isCrt;

#ifndef OIT_ALPHA_ONLY
layout(location = 0) out vec4 fragColor;
#endif

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

vec4 calculateFinalColor(vec4 color) {
    #ifdef OIT_ACCUMULATE
    color = sampleColorForAccumulation(color);
    #endif

    #if !defined(IS_SEE_THROUGH) && !defined(IS_GUI)

    #ifdef OIT_ACCUMULATE
    vec4 fogColor = vec4(FogColor.rgb * color.a, FogColor.a);
    #else
    vec4 fogColor = FogColor;
    #endif

    color = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, fogColor);
    #endif

    return color;
}

void main() {
    #ifdef IS_GRAYSCALE
    vec4 texColor = texture(Sampler0, texCoord0).rrrr;
    #else
    vec4 texColor = texture(Sampler0, texCoord0);
    #endif

    vec4 color = texColor * vertexColor * ColorModulator;
    if (isCrt == 1) {
        color = crtColor(texColor) * ColorModulator;
    }

    if (color.a < 0.1) {
        discard;
    }

    #ifdef OIT_ALPHA_ONLY
    executeAlphaOnlyPhase(gl_FragCoord.z, color.a);
    #else
    fragColor = calculateFinalColor(color);
    #endif
}
