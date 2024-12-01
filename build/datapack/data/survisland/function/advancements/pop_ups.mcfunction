
#> survisland:advancements/pop_ups
#
# @within	advancement survisland:pop_ups/confort_dans_30_minutes
#			advancement survisland:pop_ups/confort_dans_10_minutes
#			advancement survisland:pop_ups/confort_dans_5_minutes
#			advancement survisland:pop_ups/confort_maintenant
#			advancement survisland:pop_ups/immunite_dans_30_minutes
#			advancement survisland:pop_ups/immunite_dans_10_minutes
#			advancement survisland:pop_ups/immunite_dans_5_minutes
#			advancement survisland:pop_ups/immunite_maintenant
#			advancement survisland:pop_ups/conseil_dans_30_minutes
#			advancement survisland:pop_ups/conseil_dans_10_minutes
#			advancement survisland:pop_ups/conseil_dans_5_minutes
#			advancement survisland:pop_ups/conseil_maintenant
#

# Revoke all pop-ups
schedule function survisland:advancements/pop_ups_revoke 1s replace

# Tellraw
tellraw @a[advancements={survisland:pop_ups/confort_dans_30_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 30 minutes !","color":"aqua"}]
tellraw @a[advancements={survisland:pop_ups/confort_dans_10_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 10 minutes !","color":"aqua"}]
tellraw @a[advancements={survisland:pop_ups/confort_dans_5_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 5 minutes !","color":"aqua"}]
tellraw @a[advancements={survisland:pop_ups/confort_maintenant=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort maintenant !","color":"aqua"}]
tellraw @a[advancements={survisland:pop_ups/immunite_dans_30_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 30 minutes !","color":"aqua"}]
tellraw @a[advancements={survisland:pop_ups/immunite_dans_10_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 10 minutes !","color":"aqua"}]
tellraw @a[advancements={survisland:pop_ups/immunite_dans_5_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 5 minutes !","color":"aqua"}]
tellraw @a[advancements={survisland:pop_ups/immunite_maintenant=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité maintenant !","color":"aqua"}]
tellraw @a[advancements={survisland:pop_ups/conseil_dans_30_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 30 minutes !","color":"aqua"}]
tellraw @a[advancements={survisland:pop_ups/conseil_dans_10_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 10 minutes !","color":"aqua"}]
tellraw @a[advancements={survisland:pop_ups/conseil_dans_5_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 5 minutes !","color":"aqua"}]
tellraw @a[advancements={survisland:pop_ups/conseil_maintenant=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil maintenant !","color":"aqua"}]

# Playsound
playsound ui.toast.in
playsound ui.toast.in
playsound ui.toast.in
playsound ui.toast.in

