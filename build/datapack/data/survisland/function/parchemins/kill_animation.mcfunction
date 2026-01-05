
#> survisland:parchemins/kill_animation
#
# @within	survisland:parchemins/animation_closing 1t replace [ scheduled ]
#			survisland:parchemins/kill_animation 1t replace [ scheduled ]
#

# Increase score
scoreboard players add @e[tag=survisland.deployed_scroll,scores={survisland.cooldown=1..}] survisland.cooldown 1

# Kill when reaching 10 ticks
kill @e[tag=survisland.deployed_scroll,scores={survisland.cooldown=10..}]

# Continue loop if remaining entities
execute if entity @e[tag=survisland.deployed_scroll,scores={survisland.cooldown=1..}] run schedule function survisland:parchemins/kill_animation 1t replace

