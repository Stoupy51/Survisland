
#> survisland:modes/pr_stoupy/give_star
#
# @executed	as @p[distance=..5,gamemode=!spectator]
#
# @within	survisland:modes/pr_stoupy/duo/here/reward {trial:"Les duos"} [ as @p[distance=..5,gamemode=!spectator] ]
#			survisland:modes/pr_stoupy/mirror/here/reward {trial:"Les miroirs"} [ as @p[distance=..5,gamemode=!spectator] ]
#			survisland:modes/pr_stoupy/breakout/victory {trial:"Le casse-briques"} [ as @a[tag=survisland.pr_breakout,predicate=survisland:modes/pr_stoupy/breakout/same_arena,scores={survisland.pr_breakout=1},limit=1] & at @s ]
#			survisland:modes/pr_stoupy/orbit/victory {trial:"L'orbite"} [ as @r[tag=survisland.pr_orbit,predicate=survisland:modes/pr_stoupy/orbit/same_arena] & at @s ]
#			survisland:modes/pr_stoupy/rats/victory {trial:"Les rats de labo"}
#
# @args		trial (string)
#

# @s receives the star of the trial named $(trial)
loot give @s loot survisland:i/blue_star
execute store result score #star_players survisland.data if entity @a[gamemode=!spectator,distance=..24]
$execute if score #star_players survisland.data matches ..1 run tellraw @a[distance=..96] ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Expérience '$(trial)' réussie !\n","color":"green"},{"selector":"@a[gamemode=!spectator,distance=..12]","color":"aqua"},{"text":" récupère une étoile bleue.","color":"green"}]
$execute if score #star_players survisland.data matches 2.. run tellraw @a[distance=..96] ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Expérience '$(trial)' réussie !\n","color":"green"},{"selector":"@a[gamemode=!spectator,distance=..12]","color":"aqua"},{"text":" récupèrent une étoile bleue.","color":"green"}]
title @a[distance=..96] times 10 50 20
$title @a[distance=..96] subtitle {"text":"$(trial)","color":"aqua"}
title @a[distance=..96] title {"text":"Étoile bleue obtenue !","color":"gold"}
execute as @a[distance=..96] at @s run playsound entity.player.levelup ambient @s ~ ~ ~ 0.5 0

