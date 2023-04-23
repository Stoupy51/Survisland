
file = open("update_sidebar_timer.mcfunction", "w")
file.write("\n")

for i in range(1200):

    m = str(i // 60)
    if (len(m) == 1):
        m = "0" + m
    s = str(i % 60)
    if (len(s) == 1):
        s = "0" + s

    file.write('execute if score #remaining_time survisland.data matches '+ str(i) + ' run team modify survisland.temp.sidebar.8 suffix [{"text":"emps restant : "},{"text":"'+ m + '","color":"gray"},{"text":"m"},{"text":"' + s + '","color":"gray"},{"text":"s"}]\n')

file.write("\n")

