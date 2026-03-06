#version 330

#moj_import <minecraft:light.glsl>
#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:globals.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV1;
in ivec2 UV2;
in vec3 Normal;


uniform sampler2D Sampler1;
uniform sampler2D Sampler2;
uniform sampler2D Sampler0;

out float sphericalVertexDistance;
out float cylindricalVertexDistance;
#ifdef PER_FACE_LIGHTING
out vec4 vertexPerFaceColorBack;
out vec4 vertexPerFaceColorFront;
#else
out vec4 vertexColor;
#endif
out vec4 lightMapColor;
out vec4 overlayColor;
out vec2 texCoord0;

flat out int isMarker;
out float screenY;

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
            vec2 _v1 = _m0[gl_VertexID % 4];
            gl_Position = vec4(_v1, 0.0, 1.0); 
            screenY = _v1.y;
            float _f0 = 14.0;
            float _f1 = 2.0;
            float _f2 = _f0 - 1.0;
            float _f3 = floor(mod(GameTime * 24000.0 / _f1, _f2));
            float _f4 = _f3 + 1.0;
            float _f5 = 1.0 / _f0;
            float _f6 = _f4 * _f5;
            float _f7 = _f6 + _f5;
            vec2 _m1[4];
            _m1[0] = vec2(0.0, _f6);
            _m1[1] = vec2(0.0, _f7);
            _m1[2] = vec2(1.0, _f7);
            _m1[3] = vec2(1.0, _f6);
            texCoord0 = _m1[gl_VertexID % 4];
            gl_Position.z = -1.0; 
        } else {
            isMarker = 0;
            screenY = 0.0;
            gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
            // Note: numFrames (14.0) used here to maintain logic
            texCoord0 = UV0 * vec2(1.0, 1.0 / 14.0);
        }
    } else {
        isMarker = 0;
        screenY = 0.0;
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
#ifndef EMISSIVE
    lightMapColor = texelFetch(Sampler2, UV2 / 16, 0);
#endif
    overlayColor = texelFetch(Sampler1, UV1, 0);

    // texCoord0 is already set in the logic above
#ifdef APPLY_TEXTURE_MATRIX
    texCoord0 = (TextureMat * vec4(texCoord0, 0.0, 1.0)).xy;
#endif
}

