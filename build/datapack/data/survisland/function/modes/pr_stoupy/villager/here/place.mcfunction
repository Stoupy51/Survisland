
#> survisland:modes/pr_stoupy/villager/here/place
#
# @within	(public)
#

# Replace any villager of the lab spawned here, facing the rotation of the caller, then free to wander off and be found again
kill @e[tag=survisland.pr_stoupy.villager,distance=..2]
summon minecraft:marker ~ ~ ~ {Tags:["survisland.pr_stoupy.villager","survisland.pr_stoupy.villager.spawn"]}
summon minecraft:villager ~ ~ ~ {Tags:["survisland.pr_stoupy.villager"],Invulnerable:1b,Silent:1b,PersistenceRequired:1b,CustomName:"Maarcouscous",CustomNameVisible:1b,VillagerData:{profession:"minecraft:nitwit",level:1,type:"minecraft:plains"},equipment:{head:{id:"minecraft:player_head",count:1,components:{"minecraft:profile":{id:[I;-2040882918,-788446949,-1259858514,297369748],name:"Maarcouscous",properties:[{name:"textures",signature:"bS4xBEhwLaTBjgYaG90BlXMcSELmlqEuzrFcHF8C4xzZYks9rkjms896tZq+jPpJZt7Z0L7au9nAA6UrlFRaRJ/G2uwCeQRS8M3k+6W5RfCyY0OhFCcc/EmCGBJOwfnM+Ib6fa9RJbs3tQ38moWAaGYP3e+o758AR0/oLt7UIdhoz5+UZdpzlCWLet6ptxY9Gxz5xzdmQB/qLNELK2kPr6KBUWcxDVRXv5oLYL2ZGhlBAfLS+KeHgQ1Qo8K/fIHPc6cjGIsKPmManj0ZO84Hhdl1LEI5SB0RkQ0+N32JGpisaLxEY7AGu5ocX+Dmc9Q4GJCQg/oZhpHcAIqqydcdKRqDVVOHPC5c0d6xLilvtlZm8VW9PIQTfC21RBanW1mUVMmyXF+raGDv1TVgmv++c/POA2WHcWYiz5MJKnWXbmBs9eyE30z2t7bjSpXECcl7Av5+W7TlaVrFIx4xQhXs3sCF+XilrmQLLtZsz5w2SrTKc28TkV6+R3Rj1Ob6Ix3q766m8XXAlTe8LOdQZ4Plw1J9jNhzRqWhAEwt/i2rOLeWHzcvbEU84mDsph6ew1Wes3Ts+6YbeTuoWVN8v8sbGdhjPErzipJWJg+QIA9SbN7LvASii/wa0oSqCUomvRO1AXGNbO9k94D2SRfK3m9o9uWKqMqsHYQis4dkTPEr3os=",value:"ewogICJ0aW1lc3RhbXAiIDogMTc5MTAzMTkyMDgxNSwKICAicHJvZmlsZUlkIiA6ICI4NjVhOTkxYWQxMDE0MTFiYjRlODE1YWUxMWI5ODA5NCIsCiAgInByb2ZpbGVOYW1lIiA6ICJNYWFyY291c2NvdXMiLAogICJzaWduYXR1cmVSZXF1aXJlZCIgOiB0cnVlLAogICJ0ZXh0dXJlcyIgOiB7CiAgICAiU0tJTiIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYjYzNmJmOTRkNTgzMzYwMzc0ZTlhNDA4ZTM1OWJhY2RjMTRjZTdlNzMwNTRmYTNjOGI3NmM1NDU3N2NhZDRkOSIKICAgIH0KICB9Cn0="}]}}}},drop_chances:{head:0.0f}}
execute as @n[type=villager,tag=survisland.pr_stoupy.villager,distance=..1] run rotate @s ~ 0

