
file = open("update_sidebar_alives.mcfunction", "w")
file.write("\n")

for i in range(20):
	file.write('execute if score #specs_restants survisland.data matches '+ str(i) + ' run team modify survisland.temp.sidebar.7 suffix [{"text":" restants : ","color":"gray"},{"text":"'+ str(i) + '","color":"white"}]\n')
	file.write('execute if score #mKuning_restants survisland.data matches '+ str(i) + ' run team modify survisland.temp.sidebar.5 suffix [{"text":"eurs restants : ","color":"yellow"},{"text":"'+ str(i) + '","color":"gray"}]\n')
	file.write('execute if score #mMayra_restants survisland.data matches '+ str(i) + ' run team modify survisland.temp.sidebar.2 suffix [{"text":"urs restants : ","color":"red"},{"text":"'+ str(i) + '","color":"gray"}]\n')

file.write("\n")

