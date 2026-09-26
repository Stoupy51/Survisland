
#> survisland:modes/pr_stoupy/rats/spread
#
# @within	survisland:modes/pr_stoupy/rats/here/spawn_rats with storage survisland:pr_rats spread
#
# @args		radius (unknown)
#			max_y (unknown)
#

$spreadplayers ~ ~ 1 $(radius) under $(max_y) false @e[type=minecraft:ocelot,tag=survisland.pr_rats.spreading]
tag @e[type=minecraft:ocelot,tag=survisland.pr_rats.spreading] remove survisland.pr_rats.spreading

