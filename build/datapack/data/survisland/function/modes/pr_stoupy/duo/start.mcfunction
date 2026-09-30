
#> survisland:modes/pr_stoupy/duo/start
#
# @within	???
#
# @args		tp (unknown)
#

tag @a[tag=survisland.pr_stoupy.back,predicate=!survisland:modes/pr_stoupy/on_start_pad] remove survisland.pr_stoupy.back
# $(tp) moves each player of a new pair from where it stands, "" to leave them on the pads
$data modify storage survisland:pr_stoupy tp set value "$(tp)"

# Objectives of the mode, all but the first one are carried by the mannequins themselves
scoreboard objectives add survisland.pr_stoupy_duo dummy
scoreboard objectives add survisland.pr_stoupy_duo.group dummy
scoreboard objectives add survisland.pr_stoupy_duo.phase dummy
scoreboard objectives add survisland.pr_stoupy_duo.pose dummy
scoreboard objectives add survisland.pr_stoupy_duo.sprint dummy
scoreboard objectives add survisland.pr_stoupy_duo.moving dummy

# Speeds shared by every group, in thousandths of a block per tick
scoreboard players set #pr_stoupy_duo_speed_walk survisland.data 216
scoreboard players set #pr_stoupy_duo_speed_sprint survisland.data 281
scoreboard players set #pr_stoupy_duo_speed_back survisland.data 130
scoreboard players set #pr_stoupy_duo_speed_sneak survisland.data 65

# Nothing happens until enough free players stand here, so a group already playing is never disturbed
execute store result score #pr_stoupy_duo_free survisland.data if entity @a[tag=!survisland.pr_stoupy_duo,tag=!survisland.pr_stoupy.back,distance=..16,predicate=survisland:modes/pr_stoupy/on_start_pad,gamemode=!creative,gamemode=!spectator]
execute if score #pr_stoupy_duo_free survisland.data matches 0 run return 0
execute unless score #pr_stoupy_solo survisland.data matches 1 if score #pr_stoupy_duo_free survisland.data matches ..3 run return 0

# The nearest free players are split into groups, each one taking the closest players still free
function survisland:modes/pr_stoupy/duo/body/form_group
function survisland:modes/pr_stoupy/duo/body/form_group

schedule function survisland:modes/pr_stoupy/duo/tick 1t replace

