#version 330
#extension GL_ARB_separate_shader_objects : require

#include <minecraft:globals.glsl>
#include <minecraft:fog.glsl>
#include <minecraft:dynamictransforms.glsl>
#include <minecraft:oit.glsl>

uniform sampler2D Sampler0;

#ifdef GLINT
uniform sampler2D GlintSampler;
#endif

#ifndef OIT_ALPHA_ONLY
layout(location = 0) in float sphericalVertexDistance;
layout(location = 1) in float cylindricalVertexDistance;
#endif
layout(location = 2) in vec4 vertexColor;
#ifndef OIT_ALPHA_ONLY
layout(location = 3) in vec4 lightMapColor;
layout(location = 4) in vec4 overlayColor;
#endif
layout(location = 5) in vec2 texCoord0;
layout(location = 7) in vec3 vPos;      // fragment position, camera relative
layout(location = 8) in vec4 vNearPos;  // same fragment projected on the camera near plane, before the perspective divide
#ifdef GLINT
layout(location = 6) in vec2 texCoordGlint;
#endif

#ifndef OIT_ALPHA_ONLY
layout(location = 0) out vec4 fragColor;
#endif

// Black hole
const vec3  blackHoleAxis   = vec3(0., -.4, -.9);
const float diskRadius      = .4;
const float timeScale       = .5;
const float effectIntensity = 1.;
const vec3  rimColor        = vec3(.64, 0., 0.);
const vec3  coreGlowColor   = vec3(.04, .3, .47);

#define BH_MARCH_STEPS 20.0
#define BH_FBM_OCTAVES 5.0

// Volumetric ray marching of the accretion disk
vec4 computeAccretionDisk(vec3 localPos, float animTime) {
    vec4 accumulatedColor = vec4(0.);
    vec3 normalizedPos = normalize(localPos);
    for (float stepDist = 1e-4, stepSize = 0., iterCount = 0.; iterCount < BH_MARCH_STEPS; iterCount++) {
        vec3 samplePos = stepDist * normalizedPos;

        // Cylindrical coordinates, to spiral around the axis
        samplePos = vec3(
            atan(samplePos.y / .2, samplePos.x) * 2.,
            samplePos.z / 3.,
            length(samplePos.xy) - 5. - stepDist * .2
        );
        for (stepSize = 1.; stepSize < BH_FBM_OCTAVES; stepSize++) {
            samplePos += sin(samplePos.yzx * stepSize + animTime + .3 * iterCount) / stepSize;
        }
        stepDist += stepSize = length(vec4(.4 * cos(samplePos) - .4, samplePos.z));
        accumulatedColor += (cos(samplePos.x + iterCount * .4 + stepDist + vec4(6., 1., 2., 0.)) + 1.) / stepSize;
    }
    return tanh(accumulatedColor * accumulatedColor / 4e2);
}

vec4 computeBlackHole() {
    // View bobbing moves the eye away from the origin, so the ray is rebuilt from the near plane instead of normalize(vPos)
    vec3 nearPos = vNearPos.xyz / vNearPos.w;
    vec3 viewDir = normalize(vPos - nearPos);
    viewDir = vec3(-viewDir.x, viewDir.y, -viewDir.z);  // items render with a half turn of yaw

    // The scene is a skybox anchored on the eye, only the animated offset moves the ray origin
    vec3 diskCenter = blackHoleAxis * (fract(GameTime) * timeScale);

    // Ray against the infinite cylinder of the accretion disk
    float axisDotView  = dot(blackHoleAxis, viewDir);
    float axisDotRef   = dot(blackHoleAxis, diskCenter);
    float cylA         = 1. - axisDotView * axisDotView;
    float cylB         = 2. * (dot(viewDir, diskCenter) - axisDotView * axisDotRef);
    float cylC         = dot(diskCenter, diskCenter) - axisDotRef * axisDotRef - diskRadius * diskRadius;
    float discriminant = cylB * cylB - 4. * cylA * cylC;
    if (discriminant < 0.) discard;

    float sqrtDisc = sqrt(discriminant);
    float t0       = (-cylB - sqrtDisc) / (2. * cylA);
    float t1       = (-cylB + sqrtDisc) / (2. * cylA);
    float hitDist  = t0 > 0. ? t0 : t1;
    if (hitDist < 0.) discard;

    // Hit point in the local basis of the disk
    vec3 hitPoint      = diskCenter + viewDir * hitDist;
    vec3 tangentHelper = abs(blackHoleAxis.y) < .9 ? vec3(0., 1., 0.) : vec3(1., 0., 0.);
    vec3 tangentU      = normalize(cross(blackHoleAxis, tangentHelper));
    vec3 tangentV      = cross(blackHoleAxis, tangentU);
    vec3 localHitPos   = vec3(dot(hitPoint, tangentU), dot(hitPoint, tangentV), dot(hitPoint, blackHoleAxis));
    vec4 diskColor     = computeAccretionDisk(localHitPos, fract(GameTime) * 320.);

    // Bright rim, strongest where the view grazes the cylinder
    vec3 surfaceNormal = normalize(hitPoint - blackHoleAxis * dot(hitPoint, blackHoleAxis));
    float fresnel      = 1. - max(0., dot(surfaceNormal, -viewDir));
    fresnel           *= fresnel;
    vec3 rimGlow       = coreGlowColor * fresnel * fresnel * effectIntensity;

    // Glow along the axis
    float axialDist = dot(hitPoint, blackHoleAxis);
    vec3 axialColor = rimColor * exp(-axialDist * axialDist * .1) * effectIntensity;

    // Screen blend of the three layers, then faded out along the axis over a black background
    diskColor.rgb  = vec3(1.) - (vec3(1.) - diskColor.rgb) * (vec3(1.) - rimGlow) * (vec3(1.) - axialColor);
    diskColor.a   *= smoothstep(-1., 1., axialDist);
    return vec4(mix(vec3(0.), diskColor.rgb, diskColor.a), 1.);
}

// Effect textures are solid markers: the RGB is the "SVL" signature and the alpha is the effect id.
// Requiring all four channels keeps stray pixels of regular textures from triggering an effect.
const vec3 EFFECT_SIGNATURE_RGB = vec3(83., 86., 76.);

bool isEffect(float effectId) {
    vec4 texel = texture(Sampler0, texCoord0) * 255.;
    return all(lessThan(abs(texel - vec4(EFFECT_SIGNATURE_RGB, effectId)), vec4(.5)));
}

#ifndef OIT_ALPHA_ONLY
vec4 calculateFinalColor(vec4 color) {
    color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
    color *= lightMapColor;

    #ifdef GLINT
    vec4 glintColor = GlintAlpha * texture(GlintSampler, texCoordGlint);// Glint color modulator?
    // Matches BlendFuntion.GLINT
    color.rgb += glintColor.rgb * glintColor.rgb;
    #endif

    color = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);

    #ifdef OIT_ACCUMULATE
    color = sampleColorForAccumulation(color);
    #endif

    return color;
}
#endif

void main() {
    if (isEffect(254.)) {
        vec4 hole = computeBlackHole();
#ifdef OIT_ALPHA_ONLY
        executeAlphaOnlyPhase(gl_FragCoord.z, hole.a);
#else
        fragColor = hole;
#endif
        return;
    }

    vec4 color = texture(Sampler0, texCoord0);
    #ifdef ALPHA_CUTOUT
    if (color.a < ALPHA_CUTOUT) {
        discard;
    }
    #endif

    color *= vertexColor * ColorModulator;

    #ifdef GLINT
    color.a = max(color.a, GlintAlpha);
    #endif

    #ifdef OIT_ALPHA_ONLY
    executeAlphaOnlyPhase(gl_FragCoord.z, color.a);
    #else
    fragColor = calculateFinalColor(color);
    #endif
}
