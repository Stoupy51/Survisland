
tellraw @a[tag=convention.debug] {"text":"[Loaded Survisland v1.2.0]","italic":false,"color":"green"}

execute unless entity @a run schedule function survisland:post_load 1t

