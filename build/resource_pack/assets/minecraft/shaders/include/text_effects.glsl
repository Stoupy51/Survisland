#version 150
#if defined(RENDERTYPE_TEXT) || defined(RENDERTYPE_TEXT_INTENSITY)

struct TextData {
    vec4 color;
    vec4 topColor;
    vec4 backColor;
    vec2 position;
    vec2 characterPosition;
    vec2 localPosition;
    vec2 uv;
    vec2 uvMin;
    vec2 uvMax;
    vec2 uvCenter;
    bool isShadow;
    bool doTextureLookup;
    bool shouldScale;
    vec2 atlasSize;
};

TextData textData;

bool uvBoundsCheck(vec2 uv, vec2 uvMin, vec2 uvMax) {
    if(isnan(uv.x) || isnan(uv.y))
        return true;
    const float error = 0.0001;
    return uv.x < textData.uvMin.x + error || uv.y < textData.uvMin.y + error || uv.x > textData.uvMax.x - error || uv.y > textData.uvMax.y - error;
}

vec3 textSdf() {
    vec3 value = vec3(0.0, 0.0, 1.0);

    vec2 texelSize = 1.0 / textData.atlasSize;
    for(int x = -1; x <= 1; x++) {
        for(int y = -1; y <= 1; y++) {
            vec2 uv = textData.uv + vec2(x, y) * texelSize;
            if(uvBoundsCheck(uv, textData.uvMin, textData.uvMax))
                continue;

            vec4 s = texture(Sampler0, uv);
            if(s.a >= 0.1) {
                vec3 v = vec3(fract(uv * textData.atlasSize), 0.0);

                if(x == 0)
                    v.x = 0.0;
                if(y == 0)
                    v.y = 0.0;
                if(x > 0)
                    v.x = 1.0 - v.x;
                if(y > 0)
                    v.y = 1.0 - v.y;

                v.z = length(v.xy);

                if(v.z < value.z)
                    value = v;
            }
        }
    }
    return value;
}

void override_text_color(vec4 color) {
    textData.color = color;
    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

void override_text_color(vec3 color) {
    textData.color.rgb = color;
    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

void override_shadow_color(vec4 color) {
    if(textData.isShadow) {
        textData.color = color;
        textData.topColor.rgb = color.rgb;
        textData.topColor.a *= color.a;
        textData.backColor.rgb = color.rgb;
        textData.backColor.a *= color.a;
    }
}

void override_shadow_color(vec3 color) {
    override_shadow_color(vec4(color, 1.0));
}

void remove_text_shadow() {
    if(textData.isShadow)
        textData.color.a = 0.0;
}

void apply_vertical_shadow() {
    if(textData.isShadow) {
        textData.uv.x += 1.0 / textData.atlasSize.x;
        textData.shouldScale = true;
    }
}

#define MAX_GRADIENT_COLORS 10
/**
 * Applies a cycling gradient that smoothly transitions through a user-defined set of colors.
 * The effect is animated over time and space, creating a dynamic, flowing gradient.
 *
 * @param colors An array of vec3 colors to cycle through.
 * @param numColors The actual number of colors passed in the array.
 * @param speed A multiplier to control the speed of the animation.
 */
void apply_cycling_gradient(vec3 colors[MAX_GRADIENT_COLORS], int numColors, float speed) {
    // Avoid processing if no colors are provided.
    if(numColors <= 0) {
        return;
    }

    // If there's only one color, just apply it directly.
    if(numColors == 1) {
        textData.color.rgb = colors[0];
    } else {
        // Calculate a progress value based on time and the character's position.
        // `fract()` keeps the value in the 0.0 to 1.0 range, creating a seamless loop.
        float progress = fract(0.015 * (textData.position.x + textData.position.y) - GameTime * 300.0 * speed);

        // Scale progress to span across all the colors in the array.
        float scaledProgress = progress * float(numColors);

        // Determine the indices of the two colors to blend between.
        int index1 = int(scaledProgress);
        int index2 = (index1 + 1) % numColors; // Use modulo to wrap around for a continuous cycle.

        // Calculate the blend factor (how much to mix the two colors).
        float blendFactor = fract(scaledProgress);

        // Retrieve the two colors for interpolation.
        vec3 color1 = colors[index1];
        vec3 color2 = colors[index2];

        // Linearly interpolate (mix) the colors to get the final color.
        textData.color.rgb = mix(color1, color2, blendFactor);
    }

    // Darken the color if it's for a shadow, consistent with other effects.
    if(textData.isShadow) {
        textData.color.rgb *= 0.25;
    }
}

/**
 * Overloaded version of the function with a default speed of 1.0.
 */
void apply_cycling_gradient(vec3 colors[MAX_GRADIENT_COLORS], int numColors) {
    apply_cycling_gradient(colors, numColors, 1.0);
}

void apply_waving_movement(float speed, float frequency) {
    textData.uv.y += sin(textData.characterPosition.x * 0.1 * frequency - GameTime * 7500.0 * speed) / textData.atlasSize.y;
    textData.shouldScale = true;
}

void apply_waving_movement(float speed) {
    apply_waving_movement(speed, 1.0);
}

void apply_waving_movement() {
    apply_waving_movement(1.0, 1.0);
}

void apply_shaking_movement() {
    float noiseX = noise(textData.characterPosition.x + textData.characterPosition.y + GameTime * 32000.0) - 0.5;
    float noiseY = noise(textData.characterPosition.x - textData.characterPosition.y + GameTime * 32000.0) - 0.5;
    textData.shouldScale = true;

    textData.uv += vec2(noiseX, noiseY) / textData.atlasSize;
}

void apply_iterating_movement(float speed, float space) {
    float x = mod(textData.characterPosition.x * 0.4 - GameTime * 18000.0 * speed, (5.0 * space) * TAU);
    if(x > TAU)
        x = TAU;
    textData.uv.y += (-cos(x) * 0.5 + 0.5) / textData.atlasSize.y;
    textData.shouldScale = true;
}

void apply_iterating_movement() {
    apply_iterating_movement(1.0, 1.0);
}

void apply_flipping_movement(float speed, float space) {
    float t = mod((textData.characterPosition.x * 0.4 - GameTime * 18000.0 * speed) / TAU, 5.0 * space);
    textData.uv.x = textData.uvCenter.x + (textData.uv.x - textData.uvCenter.x) / (cos(TAU * min(t, 1.0)));
    textData.uv.y = textData.uvCenter.y + (textData.uv.y - textData.uvCenter.y) / (1.0 + 0.1 * sin(TAU * min(t, 1.0)));
    textData.shouldScale = true;
}

void apply_flipping_movement() {
    apply_flipping_movement(1.0, 1.0);
}

void apply_skewing_movement(float speed) {
    float t = GameTime * 1600.0 * speed;

    textData.uv.x = mix(textData.uv.x, textData.uv.x + sin(TAU * t * 0.5) / textData.atlasSize.x, 1.0 - textData.localPosition.y);
    textData.uv.y = mix(textData.uv.y, textData.uvMax.y, -(0.3 + 0.5 * cos(TAU * t)));
    textData.shouldScale = true;
}

void apply_skewing_movement() {
    apply_skewing_movement(1.0);
}

void apply_growing_movement(float speed) {
    vec2 offset = vec2(0.0, 5.0 / textData.atlasSize.y);
    textData.uv = (textData.uv - textData.uvCenter - offset) * (sin(GameTime * 12800.0 * speed) * 0.15 + 0.85) + textData.uvCenter + offset;
    textData.shouldScale = true;
}

void apply_growing_movement() {
    apply_growing_movement(1.0);
}

void apply_outline(vec3 color) {
    textData.shouldScale = true;

    if(textData.isShadow) {
        color *= 0.25;
        textData.color.rgb = color;
    }

    vec2 texelSize = 1.0 / textData.atlasSize;
    bool outline = false;

    for(int x = -1; x <= 1; x++) {
        for(int y = -1; y <= 1; y++) {
            if(x == 0 && y == 0)
                continue;

            vec2 uv = textData.uv + vec2(x, y) * texelSize;
            if(uvBoundsCheck(uv, textData.uvMin, textData.uvMax))
                continue;

            vec4 s = texture(Sampler0, uv);
            if(s.a >= 0.1) {
                textData.backColor = vec4(color, 1.0);
                return;
            }
        }
    }
}

void apply_thin_outline(vec3 color) {
    textData.shouldScale = true;

    if(textData.isShadow) {
        color *= 0.25;
        textData.color.rgb = color;
    }

    vec2 texelSize = 0.5 / textData.atlasSize;
    bool outline = false;

    for(int x = -1; x <= 1; x++) {
        for(int y = -1; y <= 1; y++) {
            if(x == 0 && y == 0)
                continue;

            vec2 uv = textData.uv + vec2(x, y) * texelSize;
            if(uvBoundsCheck(uv, textData.uvMin, textData.uvMax))
                continue;

            vec4 s = texture(Sampler0, uv);
            if(s.a >= 0.1) {
                textData.backColor = vec4(color, 1.0);
                return;
            }
        }
    }
}

void apply_gradient(vec3 color1, vec3 color2) {
    textData.color.rgb = mix(color1, color2, textData.localPosition.y);
    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

void apply_rainbow() {
    textData.color.rgb = hsvToRgb(vec3(0.005 * (textData.position.x + textData.position.y) - GameTime * 300.0, 0.7, 1.0));
    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

/**
 * Applies a continuous shimmer wave across the text.
 * @param speed The speed of the wave.
 * @param intensity The brightness (alpha) of the shimmer.
 * @param width The thickness of the shimmer wave.
 */
void apply_shimmer(float speed, float intensity, float width) {
    if(textData.isShadow) {
        return;
    }

    // Use `textData.position` to create a wave across the entire text.
    float wave = (textData.position.x + textData.position.y) * 0.1 - GameTime * 6500.0 * speed;

    // The modulo operator creates repeating bands.
    // The `width` parameter now controls the thickness of the shimmer band.
    if(mod(wave, 25.0) < width) {
        textData.topColor = vec4(1.0, 1.0, 1.0, intensity);
    }
}

/**
 * Overloaded version with a default width.
 */
void apply_shimmer(float speed, float intensity) {
    // Calls the base function with a default width of 4.0.
    apply_shimmer(speed, intensity, 2.0);
}

/**
 * Overloaded version with all default values.
 */
void apply_shimmer() {
    // Calls the function above with default speed and intensity.
    apply_shimmer(1.0, 0.5);
}

void apply_chromatic_abberation() {
    textData.shouldScale = true;
    float noiseX = noise(GameTime * 12000.0) - 0.5;
    float noiseY = noise(GameTime * 12000.0 + 19732.134) - 0.5;
    vec2 offset = vec2(0.5 / textData.atlasSize.x, 0.0) + vec2(0.5, 1.0) * vec2(noiseX, noiseY) / textData.atlasSize;

    vec2 uv = textData.uv + offset;
    vec4 s1 = texture(Sampler0, uv);
    s1.rgb *= s1.a;
    if(uvBoundsCheck(uv, textData.uvMin, textData.uvMax))
        s1 = vec4(0.0);

    uv = textData.uv - offset;
    vec4 s2 = texture(Sampler0, uv);
    s2.rgb *= s2.a;
    if(uvBoundsCheck(uv, textData.uvMin, textData.uvMax))
        s2 = vec4(0.0);

    textData.backColor = (s1 * vec4(1.0, 0.25, 0.0, 1.0)) + (s2 * vec4(0.0, 0.75, 1.0, 1.0));
    textData.backColor.rgb *= textData.color.rgb;
}

void apply_metalic(vec3 lightColor, vec3 darkColor) {
    int y = int(floor(textData.localPosition.y * round((textData.uvMax.y - textData.uvMin.y) * textData.atlasSize.y)));

    if(y > 3)
        textData.color.rgb = darkColor;
    if(y == 3)
        textData.color.rgb = lightColor + 0.25;
    if(y < 3)
        textData.color.rgb = lightColor;

    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

void apply_metalic(vec3 color) {
    int y = int(floor(textData.localPosition.y * round((textData.uvMax.y - textData.uvMin.y) * textData.atlasSize.y)));

    if(y > 3)
        textData.color.rgb = color * 0.7;
    if(y == 3)
        textData.color.rgb = color + 0.25;
    if(y < 3)
        textData.color.rgb = color;

    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

void apply_fire() {
    textData.shouldScale = true;
    if(textData.isShadow)
        return;

    float h = fract(textData.uv.y * textData.atlasSize.y);
    vec2 uv = textData.uv + vec2(0.0, 1.0 / textData.atlasSize.y);
    if(uvBoundsCheck(uv, textData.uvMin, textData.uvMax))
        return;
    vec4 s = texture(Sampler0, uv);
    if(s.a > 0.1) {
        float f = noise(textData.localPosition * 32.0 + vec2(0.0, GameTime * 6400.0)) * 0.5 + 0.5;
        f -= (1.0 - sqrt(h)) * 0.8;

        if(f > 0.5)
            textData.backColor = vec4(mix(vec3(1.0, 0.2, 0.2), vec3(1.0, 0.7, 0.3), (f - 0.5) / 0.5), 1.0);
    }
}

void apply_fade(float speed) {
    textData.color.a = mix(textData.color.a, 0.0, sin(GameTime * 1200 * speed * PI) * 0.5 + 0.5);
}

void apply_fade() {
    apply_fade(1.0);
}

void apply_fade(vec3 color, float speed) {
    if(textData.isShadow)
        color *= 0.25;

    textData.color.rgb = mix(textData.color.rgb, color, sin(GameTime * 1200 * speed * PI) * 0.5 + 0.5);
}

void apply_fade(vec3 color) {
    apply_fade(color, 1.0);
}

void apply_blinking(float speed) {
    if(sin(GameTime * 3200 * speed * PI) < 0.0) {
        textData.color.a = 0.0;
        textData.backColor.a = 0.0;
        textData.topColor.a = 0.0;
    }
}

void apply_blinking() {
    apply_blinking(1.0);
}

void apply_glowing() {
    if(textData.isShadow)
        textData.color = vec4(0.0);
    vec3 d = textSdf();
    textData.backColor = vec4(1.0, 1.0, 1.0, (1.0 - d.z) * (1.0 - d.z));
}

void apply_lesbian_pride() {
    int y = int(floor(textData.localPosition.y * round((textData.uvMax.y - textData.uvMin.y) * textData.atlasSize.y)));

    if(y < 3)
        textData.color.rgb = vec3(0.839, 0.161, 0.000);
    if(y == 3)
        textData.color.rgb = vec3(1.000, 0.608, 0.333);
    if(y == 4)
        textData.color.rgb = vec3(1.000, 1.000, 1.000);
    if(y == 5)
        textData.color.rgb = vec3(0.831, 0.384, 0.647);
    if(y > 5)
        textData.color.rgb = vec3(0.647, 0.000, 0.384);

    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

void apply_mlm_pride() {
    int y = int(floor(textData.localPosition.y * round((textData.uvMax.y - textData.uvMin.y) * textData.atlasSize.y)));

    if(y < 3)
        textData.color.rgb = vec3(0.000, 0.584, 0.525);
    if(y == 3)
        textData.color.rgb = vec3(0.412, 0.941, 0.686);
    if(y == 4)
        textData.color.rgb = vec3(1.000, 1.000, 1.000);
    if(y == 5)
        textData.color.rgb = vec3(0.510, 0.698, 1.000);
    if(y > 5)
        textData.color.rgb = vec3(0.271, 0.153, 0.627);

    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

void apply_bisexual_pride() {
    int y = int(floor(textData.localPosition.y * round((textData.uvMax.y - textData.uvMin.y) * textData.atlasSize.y)));

    if(y < 4)
        textData.color.rgb = vec3(0.843, 0.000, 0.443);
    if(y == 4)
        textData.color.rgb = vec3(0.612, 0.306, 0.592);
    if(y > 4)
        textData.color.rgb = vec3(0.000, 0.208, 0.663);

    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

void apply_transgender_pride() {
    int y = int(floor(textData.localPosition.y * round((textData.uvMax.y - textData.uvMin.y) * textData.atlasSize.y)));

    if(y < 3)
        textData.color.rgb = vec3(0.357, 0.812, 0.980);
    if(y == 3)
        textData.color.rgb = vec3(0.961, 0.671, 0.725);
    if(y == 4)
        textData.color.rgb = vec3(1.000, 1.000, 1.000);
    if(y == 5)
        textData.color.rgb = vec3(0.961, 0.671, 0.725);
    if(y > 5)
        textData.color.rgb = vec3(0.357, 0.812, 0.980);

    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

void apply_pride() {
    int y = int(floor(textData.localPosition.y * round((textData.uvMax.y - textData.uvMin.y) * textData.atlasSize.y)));

    if(y < 2)
        textData.color.rgb = vec3(1.000, 0.012, 0.012);
    if(y == 2)
        textData.color.rgb = vec3(1.000, 0.549, 0.000);
    if(y == 3)
        textData.color.rgb = vec3(1.000, 0.929, 0.000);
    if(y == 4)
        textData.color.rgb = vec3(0.000, 0.502, 0.149);
    if(y == 5)
        textData.color.rgb = vec3(0.000, 0.302, 1.000);
    if(y > 5)
        textData.color.rgb = vec3(0.459, 0.027, 0.529);

    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

void apply_pansexual_pride() {
    int y = int(floor(textData.localPosition.y * round((textData.uvMax.y - textData.uvMin.y) * textData.atlasSize.y)));

    if(y < 3)
        textData.color.rgb = vec3(1.000, 0.129, 0.549);
    if(y == 3)
        textData.color.rgb = vec3(1.000, 0.847, 0.000);
    if(y == 4)
        textData.color.rgb = vec3(1.000, 0.847, 0.000);
    if(y > 4)
        textData.color.rgb = vec3(0.129, 0.694, 1.000);

    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

void apply_asexual_pride() {
    int y = int(floor(textData.localPosition.y * round((textData.uvMax.y - textData.uvMin.y) * textData.atlasSize.y)));

    if(y < 3)
        textData.color.rgb = vec3(0.100, 0.100, 0.100);
    if(y == 3)
        textData.color.rgb = vec3(0.639, 0.639, 0.639);
    if(y == 4)
        textData.color.rgb = vec3(1.000, 1.000, 1.000);
    if(y > 4)
        textData.color.rgb = vec3(0.502, 0.000, 0.502);

    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

void apply_aromantic_pride() {
    int y = int(floor(textData.localPosition.y * round((textData.uvMax.y - textData.uvMin.y) * textData.atlasSize.y)));

    if(y < 3)
        textData.color.rgb = vec3(0.047, 0.655, 0.294);
    if(y == 3)
        textData.color.rgb = vec3(0.584, 0.796, 0.451);
    if(y == 4)
        textData.color.rgb = vec3(1.000, 1.000, 1.000);
    if(y == 5)
        textData.color.rgb = vec3(0.639, 0.639, 0.639);
    if(y > 5)
        textData.color.rgb = vec3(0.100, 0.100, 0.100);

    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

void apply_non_binary_pride() {
    int y = int(floor(textData.localPosition.y * round((textData.uvMax.y - textData.uvMin.y) * textData.atlasSize.y)));

    if(y < 3)
        textData.color.rgb = vec3(1.000, 0.957, 0.173);
    if(y == 3)
        textData.color.rgb = vec3(1.000, 1.000, 1.000);
    if(y == 4)
        textData.color.rgb = vec3(0.616, 0.349, 0.824);
    if(y > 4)
        textData.color.rgb = vec3(0.100, 0.100, 0.100);

    if(textData.isShadow)
        textData.color.rgb *= 0.25;
}

#define SPHEYA_PACK_9

#ifdef FSH

in vec4 vctfx_screenPos;
flat in float vctfx_applyTextEffect;
flat in float vctfx_isShadow;
flat in float vctfx_changedScale;

in vec3 vctfx_ipos1;
in vec3 vctfx_ipos2;
in vec3 vctfx_ipos3;
in vec3 vctfx_ipos4;

in vec3 vctfx_uvpos1;
in vec3 vctfx_uvpos2;
in vec3 vctfx_uvpos3;
in vec3 vctfx_uvpos4;
#endif
/*
// blackhole
#ifdef FSH
#moj_import <blackhole.glsl>
#else
void apply_blackhole_effect() {
}
#endif*/

#define TEXT_EFFECT(r, g, b) return true; case ((uint(r/4) << 16) | (uint(g/4) << 8) | (uint(b/4))):

bool applyTextEffects() {
    uint vertexColorId = colorId(floor(round(textData.color.rgb * 255.0) / 4.0) / 255.0);
    if(textData.isShadow) {
        vertexColorId = colorId(textData.color.rgb);
    }
    switch(vertexColorId >> 8) {
        case 0xFFFFFFFFu:

    #moj_import<text_effects_config.glsl>

            return true;
    }
    return false;
}

#ifdef FSH
bool applySpheyaPack9() {
    if(vctfx_applyTextEffect < 0.5)
        return false;

    textData.atlasSize = vec2(textureSize(Sampler0, 0));
    textData.isShadow = vctfx_isShadow > 0.5;
    textData.backColor = vec4(0.0);
    textData.topColor = vec4(0.0);
    textData.doTextureLookup = true;
    textData.color = baseColor;

    vec2 fragNDC = vctfx_screenPos.xy / vctfx_screenPos.w;

    const float epsilon = 0.0001;

    vec2 posMin = vec2(1e38), posMax = vec2(-1e38);
    if(vctfx_ipos1.z > epsilon) {
        vec2 p = vctfx_ipos1.xy / vctfx_ipos1.z;
        posMin = min(posMin, p);
        posMax = max(posMax, p);
    }
    if(vctfx_ipos2.z > epsilon) {
        vec2 p = vctfx_ipos2.xy / vctfx_ipos2.z;
        posMin = min(posMin, p);
        posMax = max(posMax, p);
    }
    if(vctfx_ipos3.z > epsilon) {
        vec2 p = vctfx_ipos3.xy / vctfx_ipos3.z;
        posMin = min(posMin, p);
        posMax = max(posMax, p);
    }
    if(vctfx_ipos4.z > epsilon) {
        vec2 p = vctfx_ipos4.xy / vctfx_ipos4.z;
        posMin = min(posMin, p);
        posMax = max(posMax, p);
    }

    vec2 uvMin_b = vec2(1e38), uvMax_b = vec2(-1e38);
    if(vctfx_uvpos1.z > epsilon) {
        vec2 p = vctfx_uvpos1.xy / vctfx_uvpos1.z;
        uvMin_b = min(uvMin_b, p);
        uvMax_b = max(uvMax_b, p);
    }
    if(vctfx_uvpos2.z > epsilon) {
        vec2 p = vctfx_uvpos2.xy / vctfx_uvpos2.z;
        uvMin_b = min(uvMin_b, p);
        uvMax_b = max(uvMax_b, p);
    }
    if(vctfx_uvpos3.z > epsilon) {
        vec2 p = vctfx_uvpos3.xy / vctfx_uvpos3.z;
        uvMin_b = min(uvMin_b, p);
        uvMax_b = max(uvMax_b, p);
    }
    if(vctfx_uvpos4.z > epsilon) {
        vec2 p = vctfx_uvpos4.xy / vctfx_uvpos4.z;
        uvMin_b = min(uvMin_b, p);
        uvMax_b = max(uvMax_b, p);
    }

    vec2 innerSize = posMax - posMin;
    if(innerSize.x < 1e-9 || innerSize.y < 1e-9)
        discard;

    textData.uvMin = uvMin_b;
    textData.uvMax = uvMax_b;

    // Expand the UV box to prevent gaps between characters.
    vec2 halfTexel = (1.0 / textData.atlasSize) * 0.24; // 0.24 seems to be the magic value
    textData.uvMin -= halfTexel;
    textData.uvMax += halfTexel;

    vec2 uvp1 = vctfx_uvpos1.xy / vctfx_uvpos1.z;
    vec2 uvp2 = vctfx_uvpos2.xy / vctfx_uvpos2.z;
    vec2 uvp3 = vctfx_uvpos3.xy / vctfx_uvpos3.z;
    vec2 uvp4 = vctfx_uvpos4.xy / vctfx_uvpos4.z;
    vec2 uvMin = min(uvp1.xy, min(uvp2.xy, min(uvp3.xy, uvp4.xy)));
    vec2 uvMax = max(uvp1.xy, max(uvp2.xy, max(uvp3.xy, uvp4.xy)));
    vec2 uvSize = uvMax - uvMin;

    textData.position = fragNDC * 75.0;
    textData.characterPosition = (posMin + posMax) * 0.5 * (uvSize / innerSize) * textData.atlasSize;
    textData.localPosition = (fragNDC - posMin) / innerSize;
    textData.localPosition.y = 1.0 - textData.localPosition.y;
    textData.uv = textData.localPosition * uvSize + textData.uvMin;

    if(textData.isShadow) {
        textData.characterPosition += vec2(-1.0, 1.0);
        textData.position += vec2(-1.0, 1.0);
    }

    applyTextEffects();

    if(vctfx_changedScale < 0.5) {
        textData.uv = texCoord0;
    }

    if(uvBoundsCheck(textData.uv, textData.uvMin, textData.uvMax))
        textData.doTextureLookup = false;

    vec4 textureSample = textureLod(Sampler0, textData.uv, 0.0);

#ifdef RENDERTYPE_TEXT_INTENSITY
    textureSample = textureSample.rrrr;
    textureSample = vec4(0.0);
#endif

    if(!textData.doTextureLookup)
        textureSample = vec4(0.0);
    textData.topColor.a *= textureSample.a;

    fragColor = mix(vec4(textData.backColor.rgb, textData.backColor.a * textData.color.a), textureSample * textData.color, textureSample.a);
    fragColor.rgb = mix(fragColor.rgb, textData.topColor.rgb, textData.topColor.a);
    fragColor *= lightColor * ColorModulator;

    if(fragColor.a < 0.1) {
        discard;
    }

    fragColor = apply_fog(fragColor, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
    return true;
}
#endif

#ifdef VSH
out vec4 vctfx_screenPos;
flat out float vctfx_applyTextEffect;
flat out float vctfx_isShadow;
flat out float vctfx_changedScale;

out vec3 vctfx_ipos1;
out vec3 vctfx_ipos2;
out vec3 vctfx_ipos3;
out vec3 vctfx_ipos4;

out vec3 vctfx_uvpos1;
out vec3 vctfx_uvpos2;
out vec3 vctfx_uvpos3;
out vec3 vctfx_uvpos4;

bool roughlyEquals(float a, float b) {
    return abs(a - b) < 0.01;
}

bool isTextLayer() {
    return roughlyEquals(Position.z, 0.0);
}

bool isScoreboardLayer() {
    return (Position.z <= 2000.0);
}

bool applySpheyaPack9() {
    //gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    // Get texture size at the beginning and set it in textData.
    ivec2 texSize = textureSize(Sampler0, 0);
    if(texSize != vec2(256) && texSize != vec2(2048)) { // ImmediatelyFast is (2048, 2048)
        vctfx_applyTextEffect = 0.0;
        return false;
    }
    textData.atlasSize = vec2(texSize);

    vctfx_isShadow = fract(Position.z) < 0.01 ? 1.0 : 0.0;
    vctfx_applyTextEffect = 1.0;
    vctfx_changedScale = 0.0;

    textData.isShadow = vctfx_isShadow > 0.5;
    textData.color = Color;
    textData.shouldScale = false;

    if(!applyTextEffects()) {
        vctfx_isShadow = 0.0;
        if(isScoreboardLayer() || (isTextLayer() && textData.isShadow)) {
            textData.isShadow = false;
            if(applyTextEffects()) {
                vctfx_isShadow = 0.0;
            } else {
                vctfx_applyTextEffect = 0.0;
                return false;
            }
        } else {
            vctfx_applyTextEffect = 0.0;
            return false;
        }
    }

    vec2 corner = vec2[](vec2(-1.0, +1.0), vec2(-1.0, -1.0), vec2(+1.0, -1.0), vec2(+1.0, +1.0))[gl_VertexID % 4];

    vctfx_uvpos1 = vctfx_uvpos2 = vctfx_uvpos3 = vctfx_uvpos4 = vctfx_ipos1 = vctfx_ipos2 = vctfx_ipos3 = vctfx_ipos4 = vec3(0.0);
    switch(gl_VertexID % 4) {
        case 0:
            vctfx_ipos1 = vec3(gl_Position.xy, 1.0);
            vctfx_uvpos1 = vec3(UV0.xy, 1.0);
            break;
        case 1:
            vctfx_ipos2 = vec3(gl_Position.xy, 1.0);
            vctfx_uvpos2 = vec3(UV0.xy, 1.0);
            break;
        case 2:
            vctfx_ipos3 = vec3(gl_Position.xy, 1.0);
            vctfx_uvpos3 = vec3(UV0.xy, 1.0);
            break;
        case 3:
            vctfx_ipos4 = vec3(gl_Position.xy, 1.0);
            vctfx_uvpos4 = vec3(UV0.xy, 1.0);
            break;
    }
    if(textData.shouldScale) {
        gl_Position.xy += corner * 0.2;
        vctfx_changedScale = 1.0;
    }

    vctfx_screenPos = gl_Position;
    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
    vertexColor = baseColor * lightColor;
    texCoord0 = UV0;
    return true;
}
#endif

#endif

