
#> survisland:modes/pr_stoupy/rats/here/place_rat
#
# @within	???
#
# @args		variant (unknown)
#

# One rat of the given variant (grey, white, brown, mutant) right here
$function survisland:modes/pr_stoupy/rats/summon/$(variant)
execute as @e[type=minecraft:ocelot,tag=survisland.pr_rats.new] run function survisland:modes/pr_stoupy/rats/resize

