
file = open("update_sidebar_points.mcfunction", "w")
file.write("\n")

for i in range(-100, 5001, 10):
	file.write(f"""execute if score #mPonogoro_points survisland.data matches {i} run team modify survisland.temp.sidebar.4 suffix [{{"text":"Points : ","color":"light_purple"}},{{"text":"{i}","color":"gray"}}]\n""")
	file.write(f"""execute if score #mKecak_points survisland.data matches {i} run team modify survisland.temp.sidebar.4 suffix [{{"text":"Points : ","color":"gold"}},{{"text":"{i}","color":"gray"}}]\n""")
	file.write(f"""execute if score #mSinaoh_points survisland.data matches {i} run team modify survisland.temp.sidebar.1 suffix [{{"text":"Points : ","color":"green"}},{{"text":"{i}","color":"gray"}}]\n""")

file.write("\n")

