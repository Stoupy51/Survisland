
#> survisland:advancements/pop_ups
#
# @executed	as the player & at current position
#
# @within	advancement survisland:pop_ups/confort_dans_5_minutes
#			advancement survisland:pop_ups/confort_dans_10_minutes
#			advancement survisland:pop_ups/confort_dans_15_minutes
#			advancement survisland:pop_ups/confort_dans_20_minutes
#			advancement survisland:pop_ups/confort_dans_25_minutes
#			advancement survisland:pop_ups/confort_dans_30_minutes
#			advancement survisland:pop_ups/confort_dans_35_minutes
#			advancement survisland:pop_ups/confort_dans_40_minutes
#			advancement survisland:pop_ups/confort_dans_45_minutes
#			advancement survisland:pop_ups/confort_dans_50_minutes
#			advancement survisland:pop_ups/confort_dans_55_minutes
#			advancement survisland:pop_ups/confort_dans_60_minutes
#			advancement survisland:pop_ups/confort_maintenant
#			advancement survisland:pop_ups/immunite_dans_5_minutes
#			advancement survisland:pop_ups/immunite_dans_10_minutes
#			advancement survisland:pop_ups/immunite_dans_15_minutes
#			advancement survisland:pop_ups/immunite_dans_20_minutes
#			advancement survisland:pop_ups/immunite_dans_25_minutes
#			advancement survisland:pop_ups/immunite_dans_30_minutes
#			advancement survisland:pop_ups/immunite_dans_35_minutes
#			advancement survisland:pop_ups/immunite_dans_40_minutes
#			advancement survisland:pop_ups/immunite_dans_45_minutes
#			advancement survisland:pop_ups/immunite_dans_50_minutes
#			advancement survisland:pop_ups/immunite_dans_55_minutes
#			advancement survisland:pop_ups/immunite_dans_60_minutes
#			advancement survisland:pop_ups/immunite_maintenant
#			advancement survisland:pop_ups/conseil_dans_5_minutes
#			advancement survisland:pop_ups/conseil_dans_10_minutes
#			advancement survisland:pop_ups/conseil_dans_15_minutes
#			advancement survisland:pop_ups/conseil_dans_20_minutes
#			advancement survisland:pop_ups/conseil_dans_25_minutes
#			advancement survisland:pop_ups/conseil_dans_30_minutes
#			advancement survisland:pop_ups/conseil_dans_35_minutes
#			advancement survisland:pop_ups/conseil_dans_40_minutes
#			advancement survisland:pop_ups/conseil_dans_45_minutes
#			advancement survisland:pop_ups/conseil_dans_50_minutes
#			advancement survisland:pop_ups/conseil_dans_55_minutes
#			advancement survisland:pop_ups/conseil_dans_60_minutes
#			advancement survisland:pop_ups/conseil_maintenant
#

# Revoke all pop-ups
schedule function survisland:advancements/pop_ups_revoke 1s replace

# Tellraw
tellraw @s[advancements={survisland:pop_ups/confort_dans_5_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 5 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/confort_dans_10_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 10 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/confort_dans_15_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 15 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/confort_dans_20_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 20 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/confort_dans_25_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 25 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/confort_dans_30_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 30 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/confort_dans_35_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 35 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/confort_dans_40_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 40 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/confort_dans_45_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 45 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/confort_dans_50_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 50 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/confort_dans_55_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 55 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/confort_dans_60_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort dans 60 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/confort_maintenant=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Confort maintenant !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/immunite_dans_5_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 5 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/immunite_dans_10_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 10 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/immunite_dans_15_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 15 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/immunite_dans_20_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 20 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/immunite_dans_25_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 25 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/immunite_dans_30_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 30 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/immunite_dans_35_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 35 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/immunite_dans_40_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 40 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/immunite_dans_45_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 45 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/immunite_dans_50_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 50 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/immunite_dans_55_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 55 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/immunite_dans_60_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité dans 60 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/immunite_maintenant=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Immunité maintenant !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/conseil_dans_5_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 5 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/conseil_dans_10_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 10 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/conseil_dans_15_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 15 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/conseil_dans_20_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 20 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/conseil_dans_25_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 25 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/conseil_dans_30_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 30 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/conseil_dans_35_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 35 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/conseil_dans_40_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 40 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/conseil_dans_45_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 45 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/conseil_dans_50_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 50 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/conseil_dans_55_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 55 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/conseil_dans_60_minutes=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil dans 60 minutes !","color":"aqua"}]
tellraw @s[advancements={survisland:pop_ups/conseil_maintenant=true}] [{"nbt":"SurvislandWarning","storage":"survisland:main","interpret":true},{"text":" Conseil maintenant !","color":"aqua"}]

# Playsound
playsound ui.toast.in
playsound ui.toast.in
playsound ui.toast.in
playsound ui.toast.in

