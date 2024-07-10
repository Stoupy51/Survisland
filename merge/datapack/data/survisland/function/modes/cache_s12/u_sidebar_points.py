
file = open("update_sidebar_points.mcfunction", "w")
file.write("\n")

for i in range(-100, 5001, 10):
	file.write('execute if score #mKuning_points survisland.data matches '+ str(i) + ' run team modify survisland.temp.sidebar.4 suffix [{"text":"s : ","color":"yellow"},{"text":"' + str(i) + '","color":"gray"}]\n')
	file.write('execute if score #mMayra_points survisland.data matches '+ str(i) + ' run team modify survisland.temp.sidebar.1 suffix [{"text":" : ","color":"red"},{"text":"' + str(i) + '","color":"gray"}]\n')

file.write("\n")

