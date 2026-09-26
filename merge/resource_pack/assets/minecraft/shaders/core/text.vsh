#version 330

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:sample_lightmap.glsl>
#endif

#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:globals.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
in ivec2 UV2;
#endif

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
uniform sampler2D Sampler2;
out float sphericalVertexDistance;
out float cylindricalVertexDistance;
#endif

out vec4 vertexColor;
out vec2 texCoord0;
flat out int isCrt;

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

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
    vertexColor = Color * sample_lightmap(Sampler2, UV2);
#else
    vertexColor = Color;
#endif
    texCoord0 = UV0;
}
