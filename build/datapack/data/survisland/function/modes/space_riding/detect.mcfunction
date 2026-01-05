
#> survisland:modes/space_riding/detect
#
# @executed	as @a[predicate=survisland:has_vehicle,nbt={SelectedItem:{tag:{survisland:{detect:{}}}}}]
#
# @within	survisland:modes/space_riding/tick [ as @a[predicate=survisland:has_vehicle,nbt={SelectedItem:{tag:{survisland:{detect:{}}}}}] ]
#

execute if data entity @s SelectedItem.components."minecraft:custom_data".survisland.detect.go_up on vehicle run data modify entity @s Motion[1] set value 0.4d
execute if data entity @s SelectedItem.components."minecraft:custom_data".survisland.detect.go_down on vehicle run data modify entity @s Motion[1] set value -0.4d

