#version 330

#define MINECRAFT_LIGHT_POWER   (0.6)
#define MINECRAFT_AMBIENT_LIGHT (0.4)

layout(std140) uniform Lighting {
    vec3 Light0_Direction;
    vec3 Light1_Direction;
};

vec2 minecraft_compute_light(vec3 lightDir0, vec3 lightDir1, vec3 normal) {
    return vec2(dot(lightDir0, normal), dot(lightDir1, normal));
}

vec4 minecraft_mix_light_separate(vec2 light, vec4 color) {
    vec2 lightValue = max(vec2(0.0), light);
    float lightAccum = min(1.0, (lightValue.x + lightValue.y) * MINECRAFT_LIGHT_POWER + MINECRAFT_AMBIENT_LIGHT);
    return vec4(color.rgb * lightAccum, color.a);
}

vec4 minecraft_mix_light(vec3 lightDir0, vec3 lightDir1, vec3 normal, vec4 color) {
    vec2 light = minecraft_compute_light(lightDir0, lightDir1, normal);
    return minecraft_mix_light_separate(light, color);
}

layout(std140) uniform Fog {
    vec4 FogColor;
    float FogEnvironmentalStart;
    float FogEnvironmentalEnd;
    float FogRenderDistanceStart;
    float FogRenderDistanceEnd;
    float FogSkyEnd;
    float FogCloudsEnd;
};

float linear_fog_value(float vertexDistance, float fogStart, float fogEnd) {
    if (vertexDistance <= fogStart) {
        return 0.0;
    } else if (vertexDistance >= fogEnd) {
        return 1.0;
    }
    return (vertexDistance - fogStart) / (fogEnd - fogStart);
}

float total_fog_value(float sphericalVertexDistance, float cylindricalVertexDistance, float environmentalStart, float environmantalEnd, float renderDistanceStart, float renderDistanceEnd) {
    return max(linear_fog_value(sphericalVertexDistance, environmentalStart, environmantalEnd), linear_fog_value(cylindricalVertexDistance, renderDistanceStart, renderDistanceEnd));
}

vec4 apply_fog(vec4 inColor, float sphericalVertexDistance, float cylindricalVertexDistance, float environmentalStart, float environmantalEnd, float renderDistanceStart, float renderDistanceEnd, vec4 fogColor) {
    float fogValue = total_fog_value(sphericalVertexDistance, cylindricalVertexDistance, environmentalStart, environmantalEnd, renderDistanceStart, renderDistanceEnd);
    return vec4(mix(inColor.rgb, fogColor.rgb, fogValue * fogColor.a), inColor.a);
}

float fog_spherical_distance(vec3 pos) {
    return length(pos);
}

float fog_cylindrical_distance(vec3 pos) {
    float distXZ = length(pos.xz);
    float distY = abs(pos.y);
    return max(distXZ, distY);
}
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

