
schedule function survisland:modes/mob_escape/second 1s replace


execute if score #mob_escape_seconds survisland.data matches 5 run summon bat -2253 100 -1172 {Tags:["survisland.new","survisland.mob"],Passengers:[{id:"minecraft:skeleton",Tags:["survisland.new","survisland.mob"],HandItems:[{id:"minecraft:bow",Count:1b},{}]}]}
execute if score #mob_escape_seconds survisland.data matches 5 run summon wither_skeleton -2253 100 -1172 {Tags:["survisland.new","survisland.mob"],ArmorItems:[{},{},{},{id:"minecraft:leather_helmet",tag:{display:{color:10489877}},Count:1b}]}
execute if score #mob_escape_seconds survisland.data matches 5 run summon shulker -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 5 run summon slime -2253 100 -1172 {Tags:["survisland.new","survisland.mob"],Size:3}
execute if score #mob_escape_seconds survisland.data matches 5 run summon zombie -2253 100 -1172 {Tags:["survisland.new","survisland.mob"],IsBaby:1b,ArmorItems:[{},{},{},{id:"minecraft:leather_helmet",tag:{display:{color:707331}},Count:1b}]}
execute if score #mob_escape_seconds survisland.data matches 5 run summon ghast -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 5 run summon blaze -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 5 run summon witch -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 5 run summon phantom -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 5 run summon ravager -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 5 run summon iron_golem -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 5 run summon vindicator -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 5 run summon vex -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}

execute if score #mob_escape_seconds survisland.data matches 32 run give @a snowball 16
execute if score #mob_escape_seconds survisland.data matches 32 run summon warden -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}

execute if score #mob_escape_seconds survisland.data matches 10.. if predicate survisland:chance/0.05 run summon bat -2253 100 -1172 {Tags:["survisland.new","survisland.mob"],Passengers:[{id:"minecraft:skeleton",Tags:["survisland.new","survisland.mob"],HandItems:[{id:"minecraft:bow",Count:1b},{}]}]}
execute if score #mob_escape_seconds survisland.data matches 10.. if predicate survisland:chance/0.05 run summon wither_skeleton -2253 100 -1172 {Tags:["survisland.new","survisland.mob"],ArmorItems:[{},{},{},{id:"minecraft:leather_helmet",tag:{display:{color:10489877}},Count:1b}]}
execute if score #mob_escape_seconds survisland.data matches 10.. if predicate survisland:chance/0.05 run summon shulker -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 10.. if predicate survisland:chance/0.05 run summon slime -2253 100 -1172 {Tags:["survisland.new","survisland.mob"],Size:3}
execute if score #mob_escape_seconds survisland.data matches 10.. if predicate survisland:chance/0.05 run summon zombie -2253 100 -1172 {Tags:["survisland.new","survisland.mob"],IsBaby:1b,ArmorItems:[{},{},{},{id:"minecraft:leather_helmet",tag:{display:{color:707331}},Count:1b}]}
execute if score #mob_escape_seconds survisland.data matches 10.. if predicate survisland:chance/0.05 run summon ghast -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 10.. if predicate survisland:chance/0.05 run summon blaze -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 10.. if predicate survisland:chance/0.05 run summon witch -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 10.. if predicate survisland:chance/0.05 run summon phantom -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 10.. if predicate survisland:chance/0.05 run summon ravager -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 10.. if predicate survisland:chance/0.05 run summon iron_golem -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 10.. if predicate survisland:chance/0.05 run summon vindicator -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}
execute if score #mob_escape_seconds survisland.data matches 10.. if predicate survisland:chance/0.05 run summon vex -2253 100 -1172 {Tags:["survisland.new","survisland.mob"]}


spreadplayers -2253 -1172 0 10 under 90 false @e[tag=survisland.new]
execute as @e[tag=survisland.new] run data modify entity @s AbsorptionAmount set value 2048.0f
effect give @e[tag=survisland.new] jump_boost 4 250 true
effect give @e[tag=survisland.new] slowness 4 255 true
tag @e[tag=survisland.new] remove survisland.new

