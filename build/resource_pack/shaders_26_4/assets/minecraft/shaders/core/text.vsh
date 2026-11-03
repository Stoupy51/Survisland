#version 330
#extension GL_ARB_separate_shader_objects : require

#ifdef AFFECTED_BY_FOG_AND_LIGHT
#include <minecraft:fog.glsl>
#include <minecraft:sample_lightmap.glsl>
#endif

#include <minecraft:dynamictransforms.glsl>
#include <minecraft:projection.glsl>
#include <minecraft:globals.glsl>

layout(location = 0) in vec3 Position;
layout(location = 1) in vec4 Color;
layout(location = 2) in vec2 UV0;
#ifdef AFFECTED_BY_FOG_AND_LIGHT
layout(location = 3) in ivec2 UV2;
#endif

#ifdef AFFECTED_BY_FOG_AND_LIGHT
uniform sampler2D Sampler2;
layout(location = 0) out float sphericalVertexDistance;
layout(location = 1) out float cylindricalVertexDistance;
#endif

layout(location = 2) out vec4 vertexColor;
layout(location = 3) out vec2 texCoord0;
layout(location = 4) flat out int isCrt;

// Text colored exactly #01FE41 is drawn as an old CRT screen
const vec3 CRT_MARKER = vec3(1.0, 254.0, 65.0);

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    isCrt = all(lessThan(abs(Color.rgb * 255.0 - CRT_MARKER), vec3(0.5))) ? 1 : 0;

    // A short horizontal tear, a few ticks every few seconds, on a band of the text only
    if (isCrt == 1) {
        float ticks = fract(GameTime) * 24000.0;
        float tear = step(0.93, fract(ticks / 47.0)) * sin(ticks * 3.1 + Position.y * 40.0);
        gl_Position.x += tear * 0.004 * gl_Position.w;
    }

#ifdef AFFECTED_BY_FOG_AND_LIGHT
    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
    vertexColor = Color * sample_lightmap(Sampler2, UV2);
#else
    vertexColor = Color;
#endif
    texCoord0 = UV0;
}
