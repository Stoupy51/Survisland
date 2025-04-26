
file = open("update_sidebar_alives.mcfunction", "w")
file.write("\n")

for i in range(40):
	file.write(f"""execute if score #specs_restants survisland.data matches {i} run team modify survisland.temp.sidebar.10 suffix [{{"text":"Specs restants : ","color":"gray"}},{{"text":"{i}","color":"white"}}]\n""")
	file.write(f"""execute if score #mPonogoro_restants survisland.data matches {i} run team modify survisland.temp.sidebar.8 suffix [{{"text":"Joueurs restants : ","color":"light_purple"}},{{"text":"{i}","color":"gray"}}]\n""")
	file.write(f"""execute if score #mKecak_restants survisland.data matches {i} run team modify survisland.temp.sidebar.5 suffix [{{"text":"Joueurs restants : ","color":"gold"}},{{"text":"{i}","color":"gray"}}]\n""")
	file.write(f"""execute if score #mSinaoh_restants survisland.data matches {i} run team modify survisland.temp.sidebar.2 suffix [{{"text":"Joueurs restants : ","color":"green"}},{{"text":"{i}","color":"gray"}}]\n""")

file.write("\n")

