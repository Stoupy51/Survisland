#version 150

#moj_import <spheya_utils.glsl>
#moj_import <spheya_packs.glsl>

bool applySpheyaPacks() {
    #ifdef SPHEYA_PACK_0
    if(applySpheyaPack0()) return true;
    #endif
    #ifdef SPHEYA_PACK_1
    if(applySpheyaPack1()) return true;
    #endif
    #ifdef SPHEYA_PACK_2
    if(applySpheyaPack2()) return true;
    #endif
    #ifdef SPHEYA_PACK_3
    if(applySpheyaPack3()) return true;
    #endif
    #ifdef SPHEYA_PACK_4
    if(applySpheyaPack4()) return true;
    #endif
    #ifdef SPHEYA_PACK_5
    if(applySpheyaPack5()) return true;
    #endif
    #ifdef SPHEYA_PACK_6
    if(applySpheyaPack6()) return true;
    #endif
    #ifdef SPHEYA_PACK_7
    if(applySpheyaPack7()) return true;
    #endif
    #ifdef SPHEYA_PACK_8
    if(applySpheyaPack8()) return true;
    #endif
    #ifdef SPHEYA_PACK_9
    if(applySpheyaPack9()) return true;
    #endif
    return false;
}

