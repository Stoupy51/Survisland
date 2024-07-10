
file = open("update_sidebar_alives.mcfunction", "w")
file.write("\n")

for i in range(40):
	file.write(f"""execute if score #specs_restants survisland.data matches {i} run team modify survisland.temp.sidebar.7 suffix [{{"text":"Specs restants : ","color":"gray"}},{{"text":"{i}","color":"white"}}]\n""")
	file.write(f"""execute if score #mLiwai_restants survisland.data matches {i} run team modify survisland.temp.sidebar.5 suffix [{{"text":"Joueurs restants : ","color":"white"}},{{"text":"{i}","color":"yellow"}}]\n""")
	file.write(f"""execute if score #mMoemoea_restants survisland.data matches {i} run team modify survisland.temp.sidebar.2 suffix [{{"text":"Joueurs restants : ","color":"dark_gray"}},{{"text":"{i}","color":"yellow"}}]\n""")

file.write("\n")

