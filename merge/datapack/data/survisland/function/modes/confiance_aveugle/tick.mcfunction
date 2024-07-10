
##Fonction executée tous les ticks lorsque le mode de jeu est activé
schedule function survisland:modes/confiance_aveugle/tick 1t replace

scoreboard players add #conf_av_ticks survisland.data 1

execute positioned -1205 60 -2815 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_kembali
execute positioned -1205 60 -2799 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_kembali
execute positioned -1205 60 -2782 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_tuarua
execute positioned -1205 60 -2766 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_tuarua
execute positioned -1205 60 -2749 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_peluang
execute positioned -1205 60 -2733 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_peluang

execute positioned -1226 62 -2829 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_kembali
execute positioned -1226 62 -2813 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_kembali
execute positioned -1226 62 -2796 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_tuarua
execute positioned -1226 62 -2780 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_tuarua
execute positioned -1226 62 -2763 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_peluang
execute positioned -1226 62 -2747 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_peluang

execute positioned -1241 62 -2829 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_kembali
execute positioned -1241 62 -2813 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_kembali
execute positioned -1241 62 -2796 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_tuarua
execute positioned -1241 62 -2780 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_tuarua
execute positioned -1241 62 -2763 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_peluang
execute positioned -1241 62 -2747 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_peluang

execute positioned -1248 61 -2815 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_kembali
execute positioned -1248 61 -2799 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_kembali
execute positioned -1248 61 -2782 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_tuarua
execute positioned -1248 61 -2766 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_tuarua
execute positioned -1248 61 -2749 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_peluang
execute positioned -1248 61 -2733 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_peluang

execute positioned -1256 68 -2828 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_kembali
execute positioned -1256 68 -2812 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_kembali
execute positioned -1256 68 -2795 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_tuarua
execute positioned -1256 68 -2779 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_tuarua
execute positioned -1256 68 -2762 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_peluang
execute positioned -1256 68 -2746 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_peluang

execute positioned -1264 66 -2815 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_kembali
execute positioned -1264 66 -2799 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_kembali
execute positioned -1264 66 -2782 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_tuarua
execute positioned -1264 66 -2766 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_tuarua
execute positioned -1264 66 -2749 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_peluang
execute positioned -1264 66 -2733 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_peluang

execute positioned -1267 59 -2829 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_kembali
execute positioned -1267 59 -2813 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_kembali
execute positioned -1267 59 -2796 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_tuarua
execute positioned -1267 59 -2780 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_tuarua
execute positioned -1267 59 -2763 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_peluang
execute positioned -1267 59 -2747 if block ~ ~ ~ stone_button[powered=true] run function survisland:modes/confiance_aveugle/button_peluang

execute if score #detect_end survisland.data matches 0 if blocks -1277 50 -2800 -1285 58 -2808 -1285 50 -2820 masked run scoreboard players set #detect_end survisland.data 1
execute if score #detect_end survisland.data matches 0 if blocks -1277 50 -2767 -1285 58 -2775 -1285 50 -2787 masked run scoreboard players set #detect_end survisland.data 2
execute if score #detect_end survisland.data matches 0 if blocks -1277 50 -2734 -1285 58 -2742 -1285 50 -2754 masked run scoreboard players set #detect_end survisland.data 3
execute if score #detect_end survisland.data matches 1.. run function survisland:modes/confiance_aveugle/process_end

