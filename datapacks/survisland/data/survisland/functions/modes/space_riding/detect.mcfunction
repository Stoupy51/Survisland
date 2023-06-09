
execute if data entity @s SelectedItem.tag.survisland.detect.go_up on vehicle run data modify entity @s Motion[1] set value 0.4d
execute if data entity @s SelectedItem.tag.survisland.detect.go_down on vehicle run data modify entity @s Motion[1] set value -0.4d

