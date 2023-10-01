
file = open("update_sidebar_timer.mcfunction", "w")
file.write("\n")

for i in range(1200):

    m = str(i // 60)
    if (len(m) == 1):
        m = "0" + m
    s = str(i % 60)
    if (len(s) == 1):
        s = "0" + s

    file.write(f"""execute if score #remaining_time survisland.data matches {i} run team modify survisland.temp.sidebar.11 suffix [{{"text":"Temps restant : "}},{{"text":"{m}","color":"gray"}},{{"text":"m"}},{{"text":"{s}","color":"gray"}},{{"text":"s"}}]\n""")

file.write("\n")

