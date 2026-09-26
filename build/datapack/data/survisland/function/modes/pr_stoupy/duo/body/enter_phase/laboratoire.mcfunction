
#> survisland:modes/pr_stoupy/duo/body/enter_phase/laboratoire
#
# @executed	at @s
#
# @within	survisland:modes/pr_stoupy/duo/body/setup_sensors
#			survisland:modes/pr_stoupy/duo/body/set_phase/laboratoire
#			survisland:modes/pr_stoupy/duo/body/apply_phase
#

# Remember which part this group is running
scoreboard players set @s survisland.pr_stoupy_duo.phase 0
scoreboard players operation #pr_stoupy_duo_group survisland.data = @s survisland.pr_stoupy_duo.group

# Single scan of the group: every player is dealt its own command set, then put back on the right vehicle
execute as @a[tag=survisland.pr_stoupy_duo,predicate=survisland:modes/pr_stoupy/duo/same_group,distance=..50] run function survisland:modes/pr_stoupy/duo/body/deal/laboratoire
function survisland:modes/pr_stoupy/duo/body/remount

# The help is read by the whole group and by anyone watching them
tellraw @a[distance=..50] [{"text": "\n"}, {"text": "Joueur 1 : ", "color": "yellow"}, {"text": "Avancer / Reculer / Sprinter / Tourner la tête\n", "color": "white"}, {"text": "Joueur 2 : ", "color": "yellow"}, {"text": "Marcher à gauche / Marcher à droite / Sauter / S'accroupir / S'allonger (touche sprint) / Clic gauche / Clic droit\n", "color": "white"}]

