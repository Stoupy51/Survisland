#version 330
#extension GL_ARB_separate_shader_objects : require

#if defined(PER_FACE_LIGHTING) || !defined(NO_CARDINAL_LIGHTING)
#include <minecraft:light.glsl>
#endif
#include <minecraft:fog.glsl>
#include <minecraft:dynamictransforms.glsl>
#include <minecraft:projection.glsl>
#include <minecraft:globals.glsl>
#include <minecraft:sample_lightmap.glsl>

layout(location = 0) in vec3 Position;
layout(location = 1) in vec4 Color;
layout(location = 2) in vec2 UV0;
layout(location = 3) in ivec2 UV1;
layout(location = 4) in ivec2 UV2;
layout(location = 5) in vec3 Normal;

uniform sampler2D Sampler0;

#if !defined(NO_OVERLAY) && !defined(OIT_ALPHA_ONLY)
uniform sampler2D Sampler1;
#endif

#if !defined(EMISSIVE) && !defined(OIT_ALPHA_ONLY)
uniform sampler2D Sampler2;
#endif

layout(location = 0) out float sphericalVertexDistance;
layout(location = 1) out float cylindricalVertexDistance;

#ifdef PER_FACE_LIGHTING
layout(location = 2) out vec4 vertexPerFaceColorBack;
layout(location = 3) out vec4 vertexPerFaceColorFront;
#else
layout(location = 2) out vec4 vertexColor;
#endif

#ifndef EMISSIVE
layout(location = 4) out vec4 lightMapColor;
#endif

#ifndef NO_OVERLAY
layout(location = 5) out vec4 overlayColor;
#endif

layout(location = 6) out vec2 texCoord0;
layout(location = 8) flat out int isMarker;
#ifdef GLINT
layout(location = 7) out vec2 texCoordGlint;
#endif

void main() {
    vec4 _v0 = textureLod(Sampler0, vec2(0.001, 0.001), 0.0);
    if (abs(_v0.r - 0.0) < 0.01 && abs(_v0.g - 1.0) < 0.01 && abs(_v0.b - 0.9843) < 0.01) {
        bool _b0 = UV2.x == 240 && UV2.y == 240;
        if (!_b0) {
            isMarker = 1;
            vec2 _m0[4];
            _m0[0] = vec2(-1.0, 1.0);
            _m0[1] = vec2(-1.0, -1.0);
            _m0[2] = vec2(1.0, -1.0);
            _m0[3] = vec2(1.0, 1.0);
            vec2 _v1 = _m0[gl_VertexIndex % 4];
            gl_Position = vec4(_v1, 0.0, 1.0);
            float _f0 = 14.0;
            float _f1 = 2.0;
            float _f2 = _f0 - 1.0;
            float _f3 = floor(mod(fract(GameTime) * 24000.0 / _f1, _f2));
            float _f4 = _f3 + 1.0;
            float _f5 = 1.0 / _f0;
            float _f6 = _f4 * _f5;
            float _f7 = _f6 + _f5;
            vec2 _m1[4];
            _m1[0] = vec2(0.0, _f6);
            _m1[1] = vec2(0.0, _f7);
            _m1[2] = vec2(1.0, _f7);
            _m1[3] = vec2(1.0, _f6);
            texCoord0 = _m1[gl_VertexIndex % 4];
#ifdef RENDERPEARL_DEPTH_IS_ZERO_TO_ONE
            gl_Position.z = 0.0;
#else
            gl_Position.z = -1.0;
#endif
        } else {
            isMarker = 0;
            gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
            texCoord0 = UV0 * vec2(1.0, 1.0 / 14.0);
        }
    } else {
        // A skin whose unused top left texel carries the "SVL" signature is drawn as a hologram
        isMarker = all(lessThan(abs(_v0.rgb * 255.0 - vec3(83.0, 86.0, 76.0)), vec3(0.5))) ? 2 : 0;
        gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
        texCoord0 = UV0;
    }

    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);

#ifdef PER_FACE_LIGHTING
    vec2 light = minecraft_compute_light(Light0_Direction, Light1_Direction, Normal);
    vertexPerFaceColorBack = minecraft_mix_light_separate(-light, Color);
    vertexPerFaceColorFront = minecraft_mix_light_separate(light, Color);
#elif defined(NO_CARDINAL_LIGHTING)
    vertexColor = Color;
#else
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color);
#endif

#if !defined(EMISSIVE) && !defined(OIT_ALPHA_ONLY)
    lightMapColor = sample_lightmap(Sampler2, UV2);
#endif

#if !defined(NO_OVERLAY) && !defined(OIT_ALPHA_ONLY)
    overlayColor = texelFetch(Sampler1, UV1, 0);
#endif

#ifdef APPLY_TEXTURE_MATRIX
    texCoord0 = (TextureMat * vec4(texCoord0, 0.0, 1.0)).xy;
#endif

#ifdef GLINT
    texCoordGlint = (TextureMat * vec4(UV0, 0.0, 1.0)).xy;
#endif
}
