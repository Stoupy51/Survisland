#version 150

#ifndef SPHEYA_UTILS_INCLUDED
#define SPHEYA_UTILS_INCLUDED

/////////////////
// Basic Maths //
/////////////////

#ifndef PI
#define PI 3.14159265359
#endif

#ifndef TAU
#define TAU 6.28318530718
#endif

#ifndef PHI
#define PHI 1.61803398875
#endif

#ifndef E
#define E 2.71828182846
#endif

#ifndef SQRT_TWO
#define SQRT_TWO 1.41421356237
#endif

#ifndef SQRT_THREE
#define SQRT_THREE 1.73205080757
#endif

float sigmoid(float x) {
    return 1.0 / (1.0 + exp(-x));
}

float bellCurve(float x) {
    return exp(-x * x);
}

float fresnel(vec3 normal, vec3 viewDir, float r0) {
    float f = 1.0 - max(dot(normal, viewDir), 0.0);
    return r0 + (1.0 - r0) * f * f * f * f * f;
}

vec2 rotateUv(vec2 uv, float theta) {
    float a = cos(theta);
    float b = sin(theta);
    return uv * mat2(a, -b, b, a);
}

#define CALC_R0(refractionIndex) (((1.0 - refractionIndex) / (1.0 + refractionIndex)) * ((1.0 - refractionIndex) / (1.0 + refractionIndex)))

/////////////////////
// Color Utilities //
/////////////////////

#define COLOR_ID_RGB(r, g, b) ((uint(r) << 24) | (uint(g) << 16) | (uint(b) << 8) | 255u)
#define COLOR_ID_RGBA(r, g, b, a) ((uint(r) << 24) | (uint(g) << 16) | (uint(b) << 8) | uint(a))

vec3 hsvToRgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec3 rgbToHsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec4 rgba(int r, int g, int b, int a) {
    return vec4(r / 255.0, g / 255.0, b / 255.0, a / 255.0);
}

vec3 rgb(int r, int g, int b) {
    return vec3(r / 255.0, g / 255.0, b / 255.0);
}

vec3 hsv(int h, int s, int v) {
    vec3 c = vec3(h / 360.0, s / 100.0, v / 100.0);
    return hsvToRgb(c);
}

uint colorId(vec3 col) {
    uint r = uint(round(col.r * 255.0));
    uint g = uint(round(col.g * 255.0));
    uint b = uint(round(col.b * 255.0));
    return ((uint(r) << 24) | (uint(g) << 16) | (uint(b) << 8) | 255u);
}

uint colorId(vec4 col) {
    uint r = uint(round(col.r * 255.0));
    uint g = uint(round(col.g * 255.0));
    uint b = uint(round(col.b * 255.0));
    uint a = uint(round(col.a * 255.0));
    return ((uint(r) << 24) | (uint(g) << 16) | (uint(b) << 8) | uint(a));
}

float linear(float col) {
    return pow(col, 2.2);
}

vec3 linear(vec3 col) {
    return pow(col, vec3(2.2));
}

vec4 linear(vec4 col) {
    return vec4(linear(col.rgb), col.a);
}

float gamma(float col) { 
    return pow(col, 1.0 / 2.2);
}

vec3 gamma(vec3 col) {
    return pow(col, vec3(1.0 / 2.2));
}

vec4 gamma(vec4 col) {
    return vec4(gamma(col.rgb), col.a);
}

float luminance(vec3 col) {
    return dot(col, vec3(0.2, 0.7, 0.1));
}

float luminance(vec4 col) {
    return luminance(col.rgb);
}

vec3 linearToLogC(vec3 color) {
    return 0.386036 + 0.244161 * log(5.555556 * color + 0.047996) / log(10.0);
}

vec4 linearToLogC(vec4 color) {
    return vec4(linearToLogC(color.rgb), color.a);
}

vec3 logCToLinear(vec3 color) {
    return (pow(vec3(10.0), (color - 0.386036) / 0.244161) - 0.047996) / 5.555556;
}

vec4 logCToLinear(vec4 color) {
    return vec4(logCToLinear(color.rgb), color.a);
}

vec3 acesToneMapping(vec3 color) {
    color = (color * (2.51 * color + 0.03)) / (color * (2.43 * color  + 0.59) + 0.14);
    return clamp(color, 0.0, 1.0);
}

vec3 reverseAces(vec3 color) {
    color = clamp(color, 0.01, 0.99);
    return (-sqrt(-0.0428 * color * color + 0.0555 * color) - 0.1214 * color + 0.006) / (color - 1.0);
}

////////////////////
// Random & Noise //
////////////////////

float random(vec3 seed) {
    return fract(sin(dot(seed, vec3(12.9898,78.233,85.1472))) * 43758.5453);
}

float random(vec2 seed) {
    return fract(sin(dot(seed, vec2(12.9898,78.233))) * 43758.5453);
}

float random(float seed) {
    return fract(sin(seed) * 43758.5453);
}

float noise(float n) {
    float i = floor(n);
    float f = fract(n);
    return mix(random(i), random(i + 1.0), smoothstep(0.0, 1.0, f));
}

float noise(vec2 p){
	vec2 ip = floor(p);
	vec2 u = fract(p);
	u = u*u*(3.0-2.0*u);
	
	float res = mix(
		mix(random(ip),random(ip+vec2(1.0,0.0)),u.x),
		mix(random(ip+vec2(0.0,1.0)),random(ip+vec2(1.0,1.0)),u.x),u.y);
	return res*res;
}

float noise(vec3 p){
    vec3 ip = floor(p);
	vec3 u = fract(p);
	u = u*u*(3.0-2.0*u);
	
	float res = mix(mix(
		mix(random(ip+vec3(0.0,0.0,0.0)),random(ip+vec3(1.0,0.0,0.0)),u.x),
		mix(random(ip+vec3(0.0,1.0,0.0)),random(ip+vec3(1.0,1.0,0.0)),u.x),u.y),
        mix(
		mix(random(ip+vec3(0.0,0.0,1.0)),random(ip+vec3(1.0,0.0,1.0)),u.x),
		mix(random(ip+vec3(0.0,1.0,1.0)),random(ip+vec3(1.0,1.0,1.0)),u.x),u.y),u.z);
	return res*res;
}

vec3 spherePoint(vec2 seed) {
    float theta = TAU * random(seed);
    float phi = acos(1.0 - 2.0 * random(seed + 0.2434));
    float f = sin(phi);
    return vec3(f * cos(theta), f * sin(theta), cos(phi));
}

// Cosine distribution picking by iq
vec3 hemiSpherePointCos(vec2 seed, vec3 normal)
{
    float u = random(seed);
    float v = random(seed + 5.236234);
    float a = 6.2831853 * v;
    u = 2.0*u - 1.0;
    return normalize( normal + vec3(sqrt(1.0-u*u) * vec2(cos(a), sin(a)), u) );
}

//////////////////////
// Easing Functions //
//////////////////////

float easeIn(float t) {
    t = clamp(t, 0.0, 1.0);
    return t * t;
}

float easeIn(float edge0, float edge1, float t) {
    return easeIn((t - edge0) / (edge1 - edge0));
}

float easeOut(float t) {
    t = clamp(t, 0.0, 1.0);
    return 1.0 - (1.0 - t) * (1.0 - t);
}

float easeOut(float edge0, float edge1, float t) {
    return easeOut((t - edge0) / (edge1 - edge0));
}

float easeInOut(float t) {
    t = clamp(t, 0.0, 1.0);
    return 3.0 * t * t - 2.0 * t * t * t;
}

float easeInOut(float edge0, float edge1, float t) {
    return easeInOut((t - edge0) / (edge1 - edge0));
}

float easeInCirc(float t) {
    t = clamp(t, 0.0, 1.0);
    return 1.0 - sqrt(1.0 - t * t);
}

float easeInCirc(float edge0, float edge1, float t) {
    return easeInCirc((t - edge0) / (edge1 - edge0));
}

float easeOutCirc(float t) {
    t = clamp(t, 0.0, 1.0);
    return sqrt(1.0 - (1.0 - t) * (1.0 - t));
}

float easeOutCirc(float edge0, float edge1, float t) {
    return easeOutCirc((t - edge0) / (edge1 - edge0));
}

float easeInOutCirc(float t) {
    if(t < 0.5)
        return 0.5 - sqrt(0.25 - t * t);
    return 0.5 + sqrt(0.25 - (1.0 - t) * (1.0 - t));
}

float easeInOutCirc(float edge0, float edge1, float t) {
    return easeInOutCirc((t - edge0) / (edge1 - edge0));
}

float easeInSine(float t) {
    t = clamp(t, 0.0, 1.0);
    return 1.0 - cos(t * PI * 0.5);
}

float easeInSine(float edge0, float edge1, float t) {
    return easeInSine((t - edge0) / (edge1 - edge0));
}

float easeOutSine(float t) {
    t = clamp(t, 0.0, 1.0);
    return sin(t * PI * 0.5);
}

float easeOutSine(float edge0, float edge1, float t) {
    return easeOutSine((t - edge0) / (edge1 - edge0));
}

float easeInOutSine(float t) {
    t = clamp(t, 0.0, 1.0);
    return -cos(t * PI) * 0.5 + 0.5;
}

float easeInOutSine(float edge0, float edge1, float t) {
    return easeInOutSine((t - edge0) / (edge1 - edge0));
}

float easeElastic(float t, float falloff, float frequency) {
    t = max(t, 0.0);
    return 1.0 - exp(-falloff * t) * cos(TAU * frequency * t);
}

float easeElastic(float edge0, float edge1, float t, float falloff, float frequency) {
    return easeElastic((t - edge0) / (edge1 - edge0), falloff, frequency);
}

float springShake(float t, float falloff, float frequency) { 
    return exp(-falloff * t) * sin(TAU * frequency * t);
}

//////////////////////////////////
// Deferred Rendering Utilities //
//////////////////////////////////

float depthSampleToWorldDepth(float depthSample) {
    const float nearPlane = 0.05;
    const float farPlane = 1000.0;
    return 2.0 * nearPlane * farPlane / (farPlane + nearPlane - (depthSample * 2.0 - 1.0) * (farPlane - nearPlane));
}

vec3 viewPosFromDepthSample(float depth, vec2 uv, mat4 iProjMat) {
    vec4 positionCS = vec4(uv, depth, 0.0) * 2.0 - 1.0;
    vec4 positionVS = iProjMat * positionCS;
    return positionVS.xyz / positionVS.w;
}

vec3 viewDirFromUv(vec2 uv, mat4 iViewProj) {
    return normalize((iViewProj * vec4(uv * 2.0 - 1.0, 1.0, 1.0)).xyz);
}

///////////////////////
// General Utilities //
///////////////////////

bool withinBounds(vec2 uv, vec2 minUv, vec2 maxUv) {
    return uv.x > minUv.x && uv.x < maxUv.x && uv.y > minUv.y && uv.y < maxUv.y;
}

float getDither(ivec2 pixel) {
    const float[] ditherMap = float[](
        0.0625, 0.5625, 0.25, 0.75,
        0.8125, 0.3125, 1.0, 0.5,
        0.1875, 0.6875, 0.125, 0.625,
        0.9375, 0.4375, 0.875, 0.375
    );

    return ditherMap[(pixel.x & 3) | ((pixel.y & 3) << 2)];
}

#endif

