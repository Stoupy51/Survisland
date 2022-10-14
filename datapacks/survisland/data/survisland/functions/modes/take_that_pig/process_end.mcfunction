
schedule clear survisland:modes/take_that_pig/second

scoreboard players add #process_end survisland.data 1

execute if score #process_end survisland.data matches 1 run function survisland:modes/take_that_pig/process_end_one_time
execute if score #process_end survisland.data matches 1 run tag @a remove survisland.to_take_spec
execute if score #process_end survisland.data matches 1 run tag @a remove survisland.spec_used
execute if score #process_end survisland.data matches 1 run tag @a remove survisland.finished
execute if score #process_end survisland.data matches 1 run team modify mMerge friendlyFire true
execute if score #process_end survisland.data matches 1 run summon firework_rocket ~ ~1 ~ {LifeTime:30,FireworksItem:{id:"firework_rocket",Count:1,tag:{Fireworks:{Flight:2,Explosions:[{Type:1,Flicker:1,Trail:1,Colors:[I;3789123]}]}}}}
execute if score #process_end survisland.data matches 1 run gamemode survival @a[gamemode=adventure]
execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] jump_boost 10 20 true
execute if score #process_end survisland.data matches 1 run effect give @a[gamemode=survival] slow_falling 20 0 true
execute if score #process_end survisland.data matches 1 as @a at @s run playsound entity.wither.death ambient @s


#Fin
execute if score #process_end survisland.data matches 2400 run function survisland:modes/take_that_pig/stop

