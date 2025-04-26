
file = open("update_sidebar_points.mcfunction", "w")
file.write("\n")

for i in range(-100, 5001, 10):
	file.write(f"""execute if score #mLiwai_points survisland.data matches {i} run team modify survisland.temp.sidebar.4 suffix [{{"text":"Points : ","color":"white"}},{{"text":"{i}","color":"yellow"}}]\n""")
	file.write(f"""execute if score #mMoemoea_points survisland.data matches {i} run team modify survisland.temp.sidebar.1 suffix [{{"text":"Points : ","color":"dark_gray"}},{{"text":"{i}","color":"yellow"}}]\n""")

file.write("\n")

