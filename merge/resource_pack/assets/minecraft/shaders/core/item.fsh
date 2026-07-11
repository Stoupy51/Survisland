#version 330

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:globals.glsl>

uniform sampler2D Sampler0;

in float sphericalVertexDistance;
in float cylindricalVertexDistance;
in vec4 vertexColor;
in vec4 lightMapColor;
in vec2 texCoord0;
in vec3 c_;

out vec4 fragColor;

const float f_ = 3.1415926536;
const float g_ = f_ * 2.;
const vec3 h_ = vec3(0., -.4, -.9);
const float i_ = .4;
const float j_ = .5;
const float k_ = 1;
const vec3 l_ = vec3(.64, 0., 0.);
const float m_ = .1;
const float n_ = -1.;
const float o_ = 1.;
const vec3 p_ = vec3(.04, .3, .47);
const float q_ = 4.;

vec4 r_(vec3 s_, float t_) {
    vec4 u_ = vec4(0.);
    float t = t_;
    for (float z = 0., v_ = 0., w_ = 0.; w_ < 20.; w_++) {
        vec3 p = z * normalize(s_);
        p = vec3(atan(p.y / .2, p.x) * 2., p.z / 3., length(p.xy) - 5. - z * .2);
        for (v_ = 1.; v_ < 7.; v_++) {
            p += sin(p.yzx * v_ + t + .3 * w_) / v_;
        }
        z += v_ = length(vec4(.4 * cos(p) - .4, p.z));
        u_ += (cos(p.x + w_ * .4 + z + vec4(6., 1., 2., 0.)) + 1.) / v_;
    }
    u_ = tanh(u_ * u_ / 4e2);
    return u_;
}

vec4 x_() {
    vec3 y_ = normalize(c_);
    vec3 z_ = h_ * (fract(GameTime) * j_);
    vec3 A_ = z_;
    float B_ = dot(h_, y_);
    float C_ = dot(h_, A_);
    float a = 1. - B_ * B_;
    float b = 2. * (dot(y_, A_) - B_ * C_);
    float D_ = dot(A_, A_) - C_ * C_ - i_ * i_;
    float E_ = b * b - 4. * a * D_;
    if (E_ < 0.) {
        discard;
    }
    float F_ = sqrt(E_);
    float G_ = 1. / (2. * a);
    float H_ = (-b - F_) * G_;
    float I_ = (-b + F_) * G_;
    float t = -1.;
    if (H_ > 0. && I_ > 0.) {
        t = min(H_, I_);
    } else if (H_ > 0.) {
        t = H_;
    } else if (I_ > 0.) {
        t = I_;
    }
    if (t < 0.) {
        discard;
    }
    vec3 J_ = z_ + y_ * t;
    vec3 K_ = h_;
    vec3 L_ = abs(K_.y) < .9 ? vec3(0., 1., 0.) : vec3(1., 0., 0.);
    vec3 M_ = normalize(cross(K_, L_));
    vec3 N_ = cross(K_, M_);
    vec3 O_ = vec3(dot(J_, M_), dot(J_, N_), dot(J_, K_));
    vec4 l = r_(O_, fract(GameTime) * 320.);
    vec3 P_ = h_ * dot(J_, h_);
    vec3 normal = normalize(J_ - P_);
    float Q_ = 1. - max(0., dot(normal, -y_));
    float R_ = pow(Q_, q_);
    vec3 S_ = p_ * R_ * k_;
    float T_ = dot(J_, h_);
    float U_ = exp(-T_ * T_ * m_);
    vec3 V_ = l_ * U_ * k_;
    l.rgb = vec3(1.) - (vec3(1.) - l.rgb) * (vec3(1.) - S_);
    l.rgb = vec3(1.) - (vec3(1.) - l.rgb) * (vec3(1.) - V_);
    float W_ = smoothstep(n_, o_, T_);
    l.a *= W_;
    vec4 X_ = vec4(0., 0., 0., 1.);
    vec4 Y_ = mix(X_, l, l.a);
    Y_.a = 1;
    return Y_;
}

vec3 Ia;
vec3 E_;

float Ja(vec3 p, float t_);
vec2 Ka(vec3 T, vec3 y_, float t_);

vec2 La(vec2 p, float Ma) {
    float Na = (f_ * 2.0) / Ma;
    float a = atan(p.y, p.x) + Na * .5;
    a = mod(a, Na) - Na * .5;
    return vec2(cos(a), sin(a)) * length(p);
}

float Ja(vec3 p, float t_) {
    float Oa;
    float Pa = 1e5;
    vec3 Qa = p;
    Oa = step(-1. + cos(floor(p.z * 6.) / 6. + t_ * 1.) * 3.14, mod(atan(p.x, p.y), 6.28) - 3.14)
       * step(mod(atan(p.x, p.y), 6.28) - 3.14 - 1.5, -1. + cos(floor(p.z * 3.) / 1. + t_ * 1.) * 3.14)
       * step(0., (length(fract(vec2(Qa.z, min(abs(Qa.x), abs(Qa.y))) * 10.) - .5) - .2));
    Oa = cos(Oa * 1. + floor(p.z) + t_ * (mod(floor(p.z), 2.) - 1. == 0. ? -1. : 1.));
    float Ra = 1e5;
    Ia = 1. - vec3(.5 - Oa * .5, .5, .3 + Oa * .5);
    Pa = length(p.xy) - 1. + .1 * Oa;
    Pa = max(Pa, Oa * -(length(fract(vec2(Qa.z, min(abs(Qa.x), abs(Qa.y))) * 10.) - .5) - .1));
    Pa = max(Pa, -(length(p.xy) - .9 + .1 * Oa));
    p.xy = La(p.yx, 50. + 50. * sin(p.z * .25));
    p.z = fract(p.z * 3.) - .5;
    if (Oa != 0.) {
        Ra = length(p.zy) - .0251 - .25 * sin(Qa.z * 5.5);
        Ra = max(Ra, -p.x + .4 + clamp(Oa, 0., 1.));
    }
    Pa = min(Pa, Ra);
    E_ += vec3(.5, .8, .5) * (Oa != 0. ? 1. : 0.) * .0125 / (.01 + max(Pa - Oa * .1, 1e-4) * max(Pa - Oa * .1, 1e-4));
    return Pa;
}

vec2 Ka(vec3 T, vec3 y_, float t_) {
    vec2 Sa = vec2(0., 0.);
    vec3 p = vec3(0., 0., 0.);
    vec2 s = vec2(0., 0.);
    for (float w_ = -1.; w_ < 200.0; ++w_) {
        p = T + y_ * Sa.y;
        Sa.x = Ja(p, t_);
        Sa.y += Sa.x * .2;
        if (Sa.x < 0.0001 || Sa.y > 50.0) {
            break;
        }
        s.x++;
    }
    s.y = Sa.y;
    return s;
}

vec4 Ta() {
    float t = fract(GameTime) * 300.125;
    vec3 Ua = vec3(0.);
    vec3 y_ = normalize(c_);
    vec3 T = vec3(0., 0., 4.5 - fract(GameTime) * 2e2);
    E_ = vec3(0.);
    vec2 Va = Ka(T, y_, t);
    if (Va.y <= 50.0) {
        Ua.xyz = Ia * (1. - Va.x * .0025);
    } else {
        Ua = vec3(0.);
    }
    Ua += E_ * .005125;
    return vec4(Ua, 1.);
}

float Wa(vec3 p, float t_) {
    p.xy *= mat2(cos(p.z * .2 + vec4(0, 33, 11, 0)));
    float distance = sin(p.y + p.x);
    for (float pa = 1.; pa < 32.; pa += pa) {
        vec3 Xa = cos(.3 * t_ + p * pa);
        distance -= abs(dot(Xa, vec3(.3))) / pa;
    }
    return distance;
}

vec4 Ya() {
    vec3 Za = normalize(c_);
    vec3 z_ = vec3(0., 0., -2. * fract(GameTime) * 4e3);
    float _b = 0.;
    float cb = 0.;
    vec4 db = vec4(0.);
    for (int w_ = 0; w_ < 100; w_++) {
        vec3 p = z_ + Za * _b;
        cb = Wa(p, fract(GameTime));
        _b += .01 + abs(cb) * .8;
        db += 1. / (abs(cb) + 1e-3);
        if (_b > 50.) {
            break;
        }
    }
    vec4 eb = db / 2e4;
    eb /= length(Za.xy);
    eb = tanh(eb);
    return vec4(eb.rrr, eb.r);
}

#define mb(x) fract(sin(x) * 43758.5453123)

float nb(float x, float pa) {
    const float ob = .3;
    float w_ = floor(x);
    float za = x - w_;
    float pb = smoothstep(.5 - ob, .5 + ob, za);
    float qb = mix(floor(mb(w_) * pa), floor(mb(w_ + 1.) * pa), pb);
    qb /= (pa - 1.) * .5;
    return qb - 1.;
}

vec3 sb(vec3 p) {
    vec3 offset = vec3(0.);
    offset.x += nb(p.z * .05, 5.) * 5.;
    offset.y += nb(p.z * .07, 3.975) * 5.;
    return offset;
}

float tb(vec2 p, float s) {
    p = abs(p);
    return (p.x + p.y - s) * inversesqrt(2.);
}

vec3 ub(vec3 p, vec3 vb, float t) {
    return mix(dot(vb, p) * vb, p, cos(t)) + cross(vb, p) * sin(t);
}

vec4 wb() {
    vec3 Ua = vec3(0.);
    float t_ = fract(GameTime) * 500;
    vec3 xb = vec3(0., 0., -1. + t_ * 5.);
    vec3 yb = vec3(0., 0., 0. + t_ * 5.);
    xb += sb(xb);
    yb += sb(yb);
    vec3 z = normalize(yb - xb);
    vec3 x = normalize(vec3(z.z, 0., -z.x));
    vec3 y = cross(z, x);
    mat3 zb = mat3(x, y, z);
    float Ab = nb(t_ + mb(c_.x * c_.y * t_) * .05, 6.);
    vec3 Bb = zb * ub(normalize(c_), vec3(0., 0., 1.), Ab);
    float w_ = 0., Cb = 0., g = 0.;
    for (; w_++ < 99.;) {
        vec3 p = xb + Bb * g;
        p -= sb(p);
        float r = 0.;
        vec3 pp = p;
        float Db = 1.;
        for (float Eb = 0.; Eb++ < 4.;) {
            r = clamp(r + abs(dot(sin(pp * 3.), cos(pp.yzx * 2.)) * .3 - .1) / Db, -.5, .5);
            pp = ub(pp, normalize(vec3(.1, .2, .3)), .785 + Eb);
            pp += pp.yzx + Eb * 50.;
            Db *= 1.5;
            pp *= 1.5;
        }
        float E_ = abs(tb(p.xy, 7.)) - 3. - r;
        vec3 Fb = ub(p, vec3(0., 0., 1.), sb(p).x * .5 + p.z * .2);
        float t = length(abs(Fb.xy) - .5) - .1;
        E_ = min(t, E_);
        Cb = max(1e-3, E_);
        g += Cb;
        vec3 Gb = vec3(.3, .2, .1) * (1e2 * exp(-20. * fract(p.z * .25 + t_)));
        Gb *= mod(floor(p.z * 4.) + mod(floor(p.y * 4.), 2.), 2.);
        vec3 Hb = vec3(.1);
        vec3 Ib = (t < E_) ? Gb : Hb;
        Ua += Ib * .0325 / exp(w_ * w_ * Cb);
    }
    Ua = mix(Ua, vec3(.9, .9, 1.1), 1. - exp(-.01 * g * g * g));
    return vec4(Ua, 1.);
}

const float Ac = .38;
const float Bc = 1.;
const float Cc = 1.5;
const int Dc = 12;
const int Ec = 36;

vec2 Fc(vec2 Y, vec2 Gc, float Hc, float Ic) {
    float x = dot(Gc, Y) * Hc + Ic;
    float Jc = exp(sin(x) - 1.);
    float Kc = Jc * cos(x);
    return vec2(Jc, -Kc);
}

float Lc(vec2 Y, int Mc, float t_) {
    float Nc = length(Y) * .1;
    float Oc = 0.;
    float Hc = 1.;
    float Pc = 2.;
    float ya = 1.;
    float Qc = 0.;
    float Rc = 0.;
    for (int w_ = 0; w_ < Mc; w_++) {
        vec2 p = vec2(sin(Oc), cos(Oc));
        vec2 qb = Fc(Y, p, Hc, t_ * Pc + Nc);
        Y += p * qb.y * ya * Ac;
        Qc += qb.x * ya;
        Rc += ya;
        ya = mix(ya, 0., .2);
        Hc *= 1.18;
        Pc *= 1.07;
        Oc += 1232.399963;
    }
    return Qc / Rc;
}

float Sc(vec3 Tc, vec3 Uc, vec3 Vc, float Wc, float t_) {
    vec3 T = Uc;
    vec3 y_ = normalize(Vc - Uc);
    for (int w_ = 0; w_ < 64; w_++) {
        float Xc = Lc(T.xz, Dc, t_) * Wc - Wc;
        if (Xc + .01 > T.y) {
            return distance(T, Tc);
        }
        T += y_ * (T.y - Xc);
    }
    return distance(Uc, Tc);
}

vec3 Yc(vec2 T, float Cb, float Wc, float t_) {
    vec2 Zc = vec2(Cb, 0);
    float _d = Lc(T.xy, Ec, t_) * Wc;
    vec3 a = vec3(T.x, _d, T.y);
    return normalize(cross(
        a - vec3(T.x - Cb, Lc(T.xy - Zc.xy, Ec, t_) * Wc, T.y),
        a - vec3(T.x, Lc(T.xy + Zc.yx, Ec, t_) * Wc, T.y + Cb)
    ));
}

float ad(vec3 bd, vec3 Gc, vec3 cd, vec3 normal) {
    return clamp(dot(cd - bd, normal) / dot(Gc, normal), -1., 9991999.);
}

vec3 dd(float t_) {
    return normalize(vec3(-.077, .5 + sin(t_ * .2 + 2.6) * .45, .577));
}

vec3 ed(vec3 fd, vec3 qc) {
    float gd = 1. / (fd.y * 1. + .1);
    float hd = 1. / (qc.y * 11. + 1.);
    float id = pow(abs(dot(qc, fd)), 2.);
    float jd = pow(max(0., dot(qc, fd)), 8.);
    float kd = jd * gd * .2;
    vec3 ld = mix(vec3(1.), max(vec3(0.), vec3(1.) - vec3(5.5, 13., 22.4) / 22.4), hd);
    vec3 md = vec3(5.5, 13., 22.4) / 22.4 * ld;
    vec3 nd = max(vec3(0.), md - vec3(5.5, 13., 22.4) * 2e-3 * (gd + -6. * qc.y * qc.y));
    nd *= gd * (.24 + id * .24);
    return nd * (1. + 1. * pow(1. - fd.y, 3.));
}

float od(vec3 y_, vec3 qc) {
    return pow(max(0., dot(y_, qc)), 720.) * 210.;
}

vec3 pd(vec3 l) {
    mat3 qd = mat3(.59719, .076, .0284, .35458, .90834, .13383, .04823, .01566, .83777);
    mat3 rd = mat3(1.60475, -.10208, -.00327, -.53108, 1.10813, -.07276, -.07367, -.00605, 1.07602);
    vec3 Nb = qd * l;
    vec3 a = Nb * (Nb + .0245786) - 9.0537e-5;
    vec3 b = Nb * (.983729 * Nb + .432951) + .238081;
    return pow(clamp(rd * (a / b), 0., 1.), vec3(1. / 2.2));
}

vec4 sd() {
    float t_ = fract(GameTime) * 400;
    vec3 td = normalize(c_);
    vec3 qc = dd(0.);
    if (td.y >= 0.) {
        vec3 l = ed(td, qc) * .5 + od(td, qc);
        return vec4(pd(l * 2.), 1.);
    }
    vec3 bd = vec3(t_ * .2, Cc, 1.);
    vec3 ud = vec3(0., 0., 0.);
    vec3 vd = vec3(0., -Bc, 0.);
    float wd = ad(bd, td, ud, vec3(0., 1., 0.));
    float xd = ad(bd, td, vd, vec3(0., 1., 0.));
    vec3 yd = bd + td * wd;
    vec3 zd = bd + td * xd;
    float Sa = Sc(bd, yd, zd, Bc, t_);
    vec3 Ad = bd + td * Sa;
    vec3 Bd = Yc(Ad.xz, .01, Bc, t_);
    Bd = mix(Bd, vec3(0., 1., 0.), .8 * min(1., sqrt(Sa * .01) * 1.1));
    float Cd = (.04 + (1. - .04) * (pow(1. - max(0., dot(-Bd, td)), 5.)));
    vec3 Dd = normalize(reflect(td, Bd));
    Dd.y = abs(Dd.y);
    vec3 Ed = ed(Dd, qc) * .5 + od(Dd, qc);
    vec3 Fd = vec3(.0293, .0698, .1717) * .1 * (.2 + (Ad.y + Bc) / Bc);
    vec3 l = Cd * Ed + Fd;
    return vec4(pd(l * 2.), 1.);
}

vec4 Gd() {
    float t_ = fract(GameTime) * 2000;
    float z = 0.;
    float v_ = 0.;
    float s = 0.;
    vec3 y_ = normalize(c_);
    vec3 Ua = vec3(0);
    for (float w_ = 0.; w_ < 100.0; w_++) {
        vec3 p = z * y_;
        for (float Eb = 0., za = 5.0; Eb < 8.0; Eb++, za *= 1.8) {
            p += 0.6 * sin(p * za - vec3(0.2) * t_).yzx / za;
        }
        s = .3 - abs(p.y);
        v_ = 0.005 + max(s, -s * 0.2) / 4.;
        z += v_;
        float Hd = 14.0 * s + dot(p, vec3(1, -1, 0)) + 0.5 * t_;
        vec3 Id = (cos(Hd - vec3(0.0, 1.0, 2.0)) + 1.5) * exp(s * 10.0) / v_;
        Ua += Id;
    }
    Ua *= 0.005 / 100.0 * 1.0;
    return vec4(tanh(Ua * Ua), 1.);
}

mat2 Jd(in float a) {
    float D_ = cos(a), s = sin(a);
    return mat2(D_, s, -s, D_);
}

const mat2 rd = mat2(.95534, .29552, -.29552, .95534);

float Kd(in float x) {
    return clamp(abs(fract(x) - .5), .01, .49);
}

vec2 Ld(in vec2 p) {
    return vec2(Kd(p.x) + Kd(p.y), Kd(p.y + Kd(p.x)));
}

float Md(in vec2 pa) {
    return fract(sin(dot(pa, vec2(12.9898, 4.1414))) * 43758.5453);
}

float Nd(in vec2 p, float Od) {
    float z = 1.8;
    float Pd = 2.5;
    float Qd = 0.;
    p *= Jd(p.x * .06);
    vec2 Rd = p;
    for (float w_ = 0.; w_ < 5.; w_++) {
        vec2 Sd = Ld(Rd * 1.85) * .75;
        Sd *= Jd(fract(GameTime) * Od);
        p -= Sd / Pd;
        Rd *= 1.3;
        Pd *= .45;
        z *= .42;
        p *= 1.21 + (Qd - 1.) * .02;
        Qd += Kd(p.x + Kd(p.y)) * z;
        p *= -rd;
    }
    return clamp(1. / pow(Qd * 29., 1.3), 0., .55);
}

vec4 Td(vec3 xb, vec3 Bb) {
    vec4 Ua = vec4(0);
    vec4 Ud = vec4(0);
    for (float w_ = 0.; w_ < 50.; w_++) {
        float Vd = 6e-3 * Md(c_.xy * 1e2) * smoothstep(0., 15., w_);
        float pt = ((.8 + pow(w_, 1.4) * 2e-3) - xb.y) / (Bb.y * 2. + .4);
        pt -= Vd;
        if (pt < 0.) continue;
        vec3 Wd = xb + pt * Bb;
        vec2 p = Wd.zx;
        float Xd = Nd(p, 2e2);
        vec4 Yd = vec4(0, 0, 0, Xd);
        Yd.rgb = (sin(1. - vec3(2.15, -.5, 1.2) + w_ * .043) * .5 + .5) * Xd;
        Ud = mix(Ud, Yd, .5);
        Ua += Ud * exp2(-w_ * .065 - 2.5) * smoothstep(0., 5., w_);
    }
    Ua *= (clamp(Bb.y * 15. + .4, 0., 1.));
    return Ua * 1.8;
}

vec4 Zd() {
    vec3 Bb = normalize(c_);
    vec3 xb = vec3(0., 0., 0.);
    vec4 l = vec4(0.);
    if (Bb.y > 0.) {
        vec4 _e = smoothstep(0., 1.5, Td(xb, Bb));
        float ae = smoothstep(0., .01, abs(Bb.y)) * .1 + .9;
        _e *= ae;
        l = vec4(_e.rgb, _e.a);
    }
    return l;
}

vec4 be() {
    vec3 y_ = normalize(vec3(c_.xy, c_.z / 0.800));
    float t_ = fract(GameTime) * 0.110;
    float ce = t_ * .2;
    float de = t_ * .1;
    mat2 ee = mat2(cos(ce), sin(ce), -sin(ce), cos(ce));
    mat2 fe = mat2(cos(de), sin(de), -sin(de), cos(de));
    y_.xz *= ee;
    y_.xy *= fe;
    vec3 ge = vec3(1., .5, .5);
    ge += vec3(t_ * 2., t_, -2.);
    ge.xz *= ee;
    ge.xy *= fe;
    float s = .1;
    float ae = 1.;
    vec3 Nb = vec3(0.);
    for (int r = 0; r < 20; r++) {
        vec3 p = ge + s * y_ * .5;
        p = abs(vec3(0.850) - mod(p, vec3(0.850 * 2.)));
        float he = 0., a = 0.;
        for (int w_ = 0; w_ < 15; w_++) {
            p = abs(p) / dot(p, p) - 0.53;
            a += abs(length(p) - he);
            he = length(p);
        }
        float ie = max(0., 0.300 - a * a * 1e-3);
        a *= a * a;
        if (r > 6) {
            ae *= 1. - ie;
        }
        Nb += ae;
        Nb += vec3(s, s * s, s * s * s * s) * a * 0.0015 * ae;
        ae *= 0.730;
        s += 0.1;
    }
    Nb = mix(vec3(length(Nb)), Nb, 0.850);
    return vec4(Nb * .01, 1.);
}

#define je(a) if (ke(a))

bool ke(float le) {
    float me = .5;
    vec4 ne = texture(Sampler0, texCoord0) * 255.;
    return abs(ne.a - le) < me && abs(ne.r - le) < me && abs(ne.g - 255.) < me && abs(ne.b - 200.) < me;
}

void main() {
    vec4 l = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    je(254) { fragColor = x_(); return; }
    je(253) { fragColor = sd(); return; }
    je(252) { fragColor = Zd(); return; }
    je(251) { fragColor = Ta(); return; }
    je(250) { fragColor = Ya(); return; }
    je(249) { fragColor = wb(); return; }
    je(248) { fragColor = Gd(); return; }
    je(247) { fragColor = be(); return; }
#ifdef ALPHA_CUTOUT
    if (l.a < ALPHA_CUTOUT) {
        discard;
    }
#else
    if (l.a < .02) {
        discard;
    }
#endif
    l *= lightMapColor;
    fragColor = apply_fog(l, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}
