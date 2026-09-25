
#> survisland:utils/compteur_subtitle
#
# @within	survisland:utils/compteur_schedule
#

# Images of the rat (only drawn from 8 down to GO)
execute if score #compteur_images survisland.data matches 1 if score #compteur survisland.data matches ..8 run return run function survisland:utils/compteur_images

# Text
execute if score #compteur survisland.data matches 4.. run title @a subtitle [{"score":{"name":"#compteur","objective":"survisland.data"}},{"text":"..."}]
execute if score #compteur survisland.data matches 3 run title @a subtitle {"text":"3...","color":"yellow"}
execute if score #compteur survisland.data matches 2 run title @a subtitle {"text":"2...","color":"gold"}
execute if score #compteur survisland.data matches 1 run title @a subtitle {"text":"1...","color":"red"}
execute if score #compteur survisland.data matches 0 run title @a subtitle {"text":"GO !","color":"dark_red"}

