
#> survisland:modes/pr_stoupy/villager/deliver
#
# @executed	as the player & at current position
#
# @within	survisland:modes/pr_stoupy/villager/talk
#

clear @s *[custom_data~{survisland:{blue_star:true}}] 5
tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" "},{"selector":"@s","color":"aqua"},{"text":" a rapporté les 5 étoiles bleues à Maarcouscous : le laboratoire du professeur Stoupy est terminé !","color":"gold"}]
title @a[distance=..32] times 10 70 20
title @a[distance=..32] subtitle {"text":"Laboratoire du professeur Stoupy","color":"aqua"}
title @a[distance=..32] title {"text":"Épreuve terminée !","color":"gold"}
playsound minecraft:entity.villager.celebrate neutral @a[distance=..32]
playsound minecraft:ui.toast.challenge_complete master @a[distance=..32]

