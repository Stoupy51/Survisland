
execute if score #intro survisland.data matches 0..315 run function survisland:utils/intro_particles

execute if score #intro survisland.data matches 315 run kill @s
execute if score #intro survisland.data matches 315 run summon firework_rocket ~ ~15.75 ~ {LifeTime:0,FireworksItem:{id:"firework_rocket",Count:1b,tag:{Fireworks:{Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;16777215],FadeColors:[I;16777215]}]}}}}
execute if score #intro survisland.data matches 315 run summon firework_rocket ~ ~15.75 ~ {LifeTime:0,FireworksItem:{id:"firework_rocket",Count:1b,tag:{Fireworks:{Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;16777215],FadeColors:[I;16777215]}]}}}}
execute if score #intro survisland.data matches 315 run summon firework_rocket ~ ~15.75 ~ {LifeTime:0,FireworksItem:{id:"firework_rocket",Count:1b,tag:{Fireworks:{Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;16777215],FadeColors:[I;16777215]}]}}}}
execute if score #intro survisland.data matches 315 run summon firework_rocket ~ ~15.75 ~ {LifeTime:0,FireworksItem:{id:"firework_rocket",Count:1b,tag:{Fireworks:{Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;16777215],FadeColors:[I;16777215]}]}}}}
execute if score #intro survisland.data matches 315 run summon firework_rocket ~ ~15.75 ~ {LifeTime:0,FireworksItem:{id:"firework_rocket",Count:1b,tag:{Fireworks:{Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;16777215],FadeColors:[I;16777215]}]}}}}

execute if score #intro survisland.data matches 315 run title @a times 20 60 20
execute if score #intro survisland.data matches 315 run title @a title ""
execute if score #intro survisland.data matches 315 run title @a subtitle {"text":"Bonne chance à vous, survivants !","color":"gray"}
execute if score #intro survisland.data matches 315 as @a at @s run function survisland:sounds/wither.spawn

execute if score #intro survisland.data matches 315 run scoreboard players reset #intro survisland.data

