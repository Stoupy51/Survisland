/* ------------------------------------------------------------------- */
//   Sliding Titles v1.1 by @trplnr - Standardized Positioning
/*
    CONFIGURATION:
      TITLE_OFFSET - Determines how close it is to the top.
                     0.0 = at the very top
                     0.5 = centered vertically
                     1.0 = at the bottom

      TITLE_SCALE  - Size of the title.
                     0.5 = half size
                     1.0 = normal size
                     1.5 = 1.5x size

      FADE         - Determines if it does the fade animation or not.
                     false = No fade animation,
                     true = Fade animation enabled.
*/
float TITLE_OFFSET = 0.225;
float TITLE_SCALE = 0.75;
bool FADE = false;

// Standardized GUI scale calculation
float baseGuiScale = max(1.0, round(ScreenSize.x / 320.0)); // Base scale on common resolution
float aspectRatio = ScreenSize.x / ScreenSize.y;
float normalizedScale = baseGuiScale * clamp(aspectRatio / 1.777, 0.8, 1.2); // Normalize for 16:9
/* ------------------------------------------------------------------- */

// Select title text
if (Position.z == 2400.12 || Position.z == 2400.06 || Position.z == 2400.0) {
float animationProgress = vertexColor.a;

// Smooth easing function (ease in-out)
float easedProgress = animationProgress * animationProgress * (3.0 - 2.0 * animationProgress);

// Map TITLE_OFFSET from [0,1] to a safe screen range
float safeTopMargin = 0.25;   // 10% from top
float safeBottomMargin = 0.9; // 90% from top (10% from bottom)

// Interpolate between safe margins based on TITLE_OFFSET
float targetY = mix(safeTopMargin, safeBottomMargin, TITLE_OFFSET);

// Apply animation with clamping to prevent off-screen positioning
float animatedOffset = easedProgress * 0.3; // Maximum 30% screen movement
float finalY = clamp(targetY + animatedOffset, safeTopMargin, safeBottomMargin);

// Convert to shader coordinate system (accounting for different GUI scales)
float shaderY = mix(1.8, 0.2, finalY); // Map [0,1] screen space to shader space

// Apply scaling transformation
TransformMat = mat4(mat3(TITLE_SCALE));
TransformMat[3].y = shaderY;

/* Matrix breakdown:
        TITLE_SCALE, 0.0, 0.0, 0.0,
        0.0, TITLE_SCALE, 0.0, 0.0,
        0.0, 0.0, TITLE_SCALE, 0.0,
        0.0, shaderY, 0.0, 1.0
    */

// Handle fade animation
if (!FADE) {
vertexColor.a = 1.0;
}
}

