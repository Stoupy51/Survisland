#version 150

#if defined(RENDERTYPE_TEXT) || defined(RENDERTYPE_TEXT_INTENSITY)
#ifdef VSH
#define SPHEYA_PACK_8

bool applySpheyaPack8() {
    if(Position.z != 0.0 || colorId(baseColor.rgb) != COLOR_ID_RGB(255, 85, 85) || gl_Position.x < 0.9 || gl_VertexID > 8) return false;
    gl_Position = vec4(10.0, 10.0, 0.0, 0.0);
    return true;
}

#endif
#endif

