
#> survisland:modes/pr_stoupy/duo/body/enroll_player
#
# @executed	as @a[tag=!survisland.pr_stoupy_duo,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative,limit=2,sort=nearest]
#
# @within	survisland:modes/pr_stoupy/duo/body/form_group [ as @a[tag=!survisland.pr_stoupy_duo,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative,limit=2,sort=nearest] ]
#

scoreboard players add #pr_stoupy_duo_slot survisland.data 1
scoreboard players operation @s survisland.pr_stoupy_duo = #pr_stoupy_duo_slot survisland.data
tag @s add survisland.pr_stoupy_duo
tag @s add survisland.pr_stoupy_duo.new

