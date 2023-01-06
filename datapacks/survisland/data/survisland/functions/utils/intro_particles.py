
import math

a = 0.1
b = 0.1
r = 16

stepSize = 0.06
pos = []
t = 0
acc = math.pi
while t <= 6 * math.pi:
	br = r - (t / (6 * math.pi) * r)

	# cercle de 2 couleurs : vert, rose
	vert = (round(br * math.cos(t + acc) + a, 3), round(br * math.sin(t + acc) + b, 3))
	rose = (round(br * -math.cos(t + acc) + a, 3), round(br * -math.sin(t + acc) + b, 3))
 
	# cercle de 3 couleurs : rouge, violet, jaune
	rouge = (round(br * math.cos(t + acc) + a, 3), round(br * math.sin(t + acc) + b, 3))
	violet = (round(br * math.cos(t + acc + math.pi * 2/3) + a, 3), round(br * math.sin(t + acc + math.pi * 2/3) + b, 3))
	jaune = (round(br * math.cos(t + acc + math.pi * 4/3) + a, 3), round(br * math.sin(t + acc + math.pi * 4/3) + b, 3))

	pos.append((vert,rose,rouge,violet,jaune))
	t += stepSize
	acc *= 1.01

t = 1
f = open("intro_particles.mcfunction", "a")
f.write("\n")
for vert, rose, rouge, violet, jaune in pos:
	x1, z1 = vert
	x2, z2 = rose
	x3, z3 = rouge
	x4, z4 = violet
	x5, z5 = jaune
	f.write(f"execute if score #saison survisland.data matches 09 if score #intro survisland.data matches {t} run particle dust 0 0001 0000 3 ~{x1} ~{round(t/20,3)} ~{z1} 0.1 0.1 0.1 0 10 force @a[distance=0..]\n")
	f.write(f"execute if score #saison survisland.data matches 09 if score #intro survisland.data matches {t} run particle dust 1 .078 .136 3 ~{x2} ~{round(t/20,3)} ~{z2} 0.1 0.1 0.1 0 10 force @a[distance=0..]\n")
	f.write(f"execute if score #saison survisland.data matches 10 if score #intro survisland.data matches {t} run particle dust 1 0000 0000 3 ~{x3} ~{round(t/20,3)} ~{z3} 0.1 0.1 0.1 0 10 force @a[distance=0..]\n")
	f.write(f"execute if score #saison survisland.data matches 10 if score #intro survisland.data matches {t} run particle dust 1 0000 0001 3 ~{x4} ~{round(t/20,3)} ~{z4} 0.1 0.1 0.1 0 10 force @a[distance=0..]\n")
	f.write(f"execute if score #saison survisland.data matches 10 if score #intro survisland.data matches {t} run particle dust 1 0001 0000 3 ~{x5} ~{round(t/20,3)} ~{z5} 0.1 0.1 0.1 0 10 force @a[distance=0..]\n")
	t += 1

f.write(f"\n\n")
f.close()

