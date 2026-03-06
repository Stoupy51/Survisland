TEXT_EFFECT(240, 240, 0) {
    apply_shaking_movement();
    override_text_color(rgb(255, 82, 82));
    override_shadow_color(rgb(100, 20, 80));
}

TEXT_EFFECT(240, 240, 4) {
    apply_waving_movement();
    override_text_color(rgb(255, 235, 60));
    override_shadow_color(rgb(150, 60, 30));
}

TEXT_EFFECT(240, 240, 8) {
    apply_iterating_movement();
    override_text_color(rgb(86, 235, 86));
    override_shadow_color(rgb(20, 80, 90));
}

TEXT_EFFECT(240, 240, 12) {
    apply_flipping_movement();
    override_text_color(rgb(74, 222, 209));
    override_shadow_color(rgb(37, 71, 150));
}

TEXT_EFFECT(240, 240, 16) {
    apply_skewing_movement();
    override_text_color(rgb(122, 80, 251));
    override_shadow_color(rgb(40, 40, 140));
}

TEXT_EFFECT(240, 240, 20) {
    override_text_color(rgb(255, 82, 82));
    apply_outline(rgb(100, 20, 80));
}

TEXT_EFFECT(240, 240, 24) {
    apply_gradient(rgb(255, 235, 120), rgb(255, 82, 82));
}

TEXT_EFFECT(240, 240, 28) {
    apply_rainbow();
}

TEXT_EFFECT(240, 240, 32) {
    override_text_color(rgb(86, 235, 86));
    override_shadow_color(rgb(20, 80, 90));
    apply_shimmer();
}

TEXT_EFFECT(240, 240, 36) {
    override_text_color(rgb(255, 255, 255));
    apply_chromatic_abberation();
    remove_text_shadow();
}

TEXT_EFFECT(240, 240, 40) {
    apply_metalic(rgb(160, 160, 200));
}

TEXT_EFFECT(240, 240, 44) {
    override_text_color(rgb(255, 20, 20));
    apply_fire();
}

TEXT_EFFECT(240, 240, 48) {
    apply_growing_movement();
    override_text_color(rgb(255, 82, 82));
    override_shadow_color(rgb(100, 20, 80));
}

TEXT_EFFECT(240, 240, 52) {
    override_text_color(rgb(255, 235, 60));
    override_shadow_color(rgb(150, 60, 30));
    apply_fade(rgb(86, 235, 86));
}

TEXT_EFFECT(240, 240, 56) {
    override_text_color(rgb(86, 235, 86));
    override_shadow_color(rgb(20, 80, 90));
    apply_blinking();
}

TEXT_EFFECT(240, 240, 60) {
    override_text_color(rgb(74, 222, 209));
    override_shadow_color(rgb(37, 71, 150));
    apply_glowing();
}

TEXT_EFFECT(240, 240, 64) {
    apply_lesbian_pride();
}

TEXT_EFFECT(240, 240, 68) {
    apply_mlm_pride();
}

TEXT_EFFECT(240, 240, 72) {
    apply_bisexual_pride();
}

TEXT_EFFECT(240, 240, 76) {
    apply_transgender_pride();
}

TEXT_EFFECT(240, 240, 80) {
    apply_pride();
}

TEXT_EFFECT(240, 240, 84) {
    apply_pansexual_pride();
}

TEXT_EFFECT(240, 240, 88) {
    apply_asexual_pride();
}

TEXT_EFFECT(240, 240, 92) {
    apply_aromantic_pride();
}

TEXT_EFFECT(240, 240, 96) {
    apply_non_binary_pride();
}

TEXT_EFFECT(94, 171, 136) {
    apply_waving_movement(1.0, 1.5);
    apply_gradient(rgb(189, 221, 100), rgb(50, 117, 132));
    override_shadow_color(rgb(70, 70, 100));
}

TEXT_EFFECT(255, 255, 248) {
    apply_vertical_shadow();
    apply_metalic(rgb(255, 255, 255), rgb(150, 163, 177) * 0.95);
    override_shadow_color(rgb(70, 70, 100));
}
/*
TEXT_EFFECT(0, 0, 4) {
    apply_blackhole_effect();
    //apply_metalic(rgb(255, 255, 255), rgb(150, 163, 177) * 0.95);
}
*/
TEXT_EFFECT(0, 0, 8) {
    vec3 fireColors[MAX_GRADIENT_COLORS];
    fireColors[0] = rgb(255, 180, 65);
    fireColors[1] = rgb(255, 113, 56);
    fireColors[2] = rgb(255, 99, 200);
    fireColors[3] = rgb(163, 108, 255);
    fireColors[4] = rgb(255, 99, 200);
    fireColors[5] = rgb(255, 113, 56);

    apply_cycling_gradient(fireColors, 6, 2);
    apply_shimmer(2.0, 0.5);
}

TEXT_EFFECT(0, 0, 170) {
    vec3 fireColors[MAX_GRADIENT_COLORS];
    fireColors[0] = rgb(255, 180, 65);
    fireColors[1] = rgb(255, 113, 56);
    fireColors[2] = rgb(255, 99, 200);
    fireColors[3] = rgb(163, 108, 255);
    fireColors[4] = rgb(255, 99, 200);
    fireColors[5] = rgb(255, 113, 56);

    apply_cycling_gradient(fireColors, 6, 2);
    apply_shimmer(2.0, 0.5);
}

