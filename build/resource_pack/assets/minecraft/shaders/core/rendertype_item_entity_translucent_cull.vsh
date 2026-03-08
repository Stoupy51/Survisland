#version 150

layout(std140) uniform Globals {
    ivec3 _;

    vec3 c;
    vec2 ScreenSize;
    float GlintAlpha;
    float GameTime;
    int d;
    int e;
};

layout(std140) uniform Lighting {
    vec3 Light0_Direction;
    vec3 Light1_Direction;
};

vec2 f(vec3 h, vec3 i, vec3 normal) {
    return vec2(dot(h, normal), dot(i, normal));
}

vec4 j(vec2 k, vec4 l) {
    vec2 m = max(vec2(0.), k);
    float n = min(1., (m.x + m.y) * (0.6) + (0.4));
    return vec4(l.rgb * n, l.a);
}

vec4 o(vec3 h, vec3 i, vec3 normal, vec4 l) {
    vec2 k = f(h, i, normal);
    return j(k, l);
}

layout(std140) uniform Fog {
    vec4 FogColor;
    float u;
    float v;
    float A;
    float B;
    float C;
    float D;
};

float E(float vertexDistance, float F, float G) {
    if (vertexDistance <= F) {
        return 0.;
    } else if (vertexDistance >= G) {
        return 1.;
    }
    return (vertexDistance - F) / (G - F);
}

float H(float I, float J, float K, float L, float M, float N) {
    return max(E(I, K, L), E(J, M, N));
}

vec4 O(vec4 P, float I, float J, float K, float L, float M, float N, vec4 Q) {
    float R = H(I, J, K, L, M, N);
    return vec4(mix(P.rgb, Q.rgb, R * Q.a), P.a);
}

float S(vec3 T) {
    return length(T);
}

float U(vec3 T) {
    float V = length(T.xz);
    float W = abs(T.y);
    return max(V, W);
}

layout(std140) uniform DynamicTransforms {
    mat4 ModelViewMat;
    vec4 ColorModulator;
    vec3 ModelOffset;
    mat4 TextureMat;
};

layout(std140) uniform Projection {
    mat4 ProjMat;
};

vec4 X(vec4 Y) {
    vec4 Z = Y * .5;
    Z.xy = vec2(Z.x + Z.w, Z.y + Z.w);
    Z.zw = Y.zw;
    return Z;
}

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in vec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler2;

out float I;
out float J;
out vec4 vertexColor;
out vec2 texCoord0;
out vec2 texCoord1;
out vec2 texCoord2;
out vec3 a_;
out vec4 b_;
out vec3 c_;

void d_() {
    mat4 e_ = ModelViewMat;
    e_[3][0] = 0.;
    e_[3][1] = 0.;
    e_[3][2] = 0.;
    gl_Position = ProjMat * e_ * vec4(Position, 1.);
    gl_Position = gl_Position.xyww;
    c_ = Position;
}

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.);
    I = S(Position);
    J = U(Position);
    a_ = Position;
    b_ = Color;
    vertexColor = o(Light0_Direction, Light1_Direction, Normal, Color) * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
    texCoord1 = UV1;
    texCoord2 = UV2;
    c_ = Position;
}

