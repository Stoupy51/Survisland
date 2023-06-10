
##Fonction executée lors du lancement de la partie


# Round 1 : phantoms
# Round 2 : blazes
# Round 3 : chicken
# Round 4 : bat
# Round 5 : bee

# execute as @a[gamemode=adventure] run ride @s mount @e[tag=shopping_kart.kart,predicate=!survisland:has_passenger,sort=nearest,limit=1]
# item replace entity @a[gamemode=adventure] weapon.offhand with crossbow{Enchantments:[{id:"minecraft:quick_charge",lvl:5s}],Unbreakable:1b}
# give @a[gamemode=adventure] arrow 512

give @p player_head{survisland:{detect:{go_down:1b}},SkullOwner:{Id:[I;-1864701848,-334870135,-2029676573,613468765],Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNzI0MzE5MTFmNDE3OGI0ZDJiNDEzYWE3ZjVjNzhhZTQ0NDdmZTkyNDY5NDNjMzFkZjMxMTYzYzBlMDQzZTBkNiJ9fX0="}]}}}
give @p player_head{survisland:{detect:{go_up:1b}},SkullOwner:{Id:[I;733532205,-1048623952,-1224856685,128611050],Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNmNjYmY5ODgzZGQzNTlmZGYyMzg1YzkwYTQ1OWQ3Mzc3NjUzODJlYzQxMTdiMDQ4OTVhYzRkYzRiNjBmYyJ9fX0="}]}}}


# Tellraw
tellraw @a ["\n",{"nbt":"Survisland","storage":"survisland:main","interpret":true},{"text":" Préparation de l'épreuve..."}]

# Scoreboards
scoreboard objectives add survisland.temp.sidebar dummy {"text":" Points ","color":"green"}
scoreboard objectives setdisplay sidebar survisland.temp.sidebar
scoreboard players set @a[gamemode=adventure] survisland.temp.sidebar 0

scoreboard players set #game survisland.data 70
scoreboard players set #space_riding_ticks survisland.data 0
scoreboard players set #default_max_engine shopping_kart.data 750

# Schedule
schedule function survisland:modes/space_riding/tick 1t replace

