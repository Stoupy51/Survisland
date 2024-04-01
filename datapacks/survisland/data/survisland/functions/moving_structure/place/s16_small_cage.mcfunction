
# /function survisland:moving_structure/place/s16_small_cage {x:-280,y:134,z:104,duration:80}
# Temporary tag
tag @e[type=block_display] add survisland.old

# Summon block displays
execute align xyz run summon block_display ~ ~-1 ~ {block_state:{Name:"minecraft:red_mushroom_block"}}
execute align xyz run summon block_display ~1 ~-1 ~ {block_state:{Name:"minecraft:brown_mushroom_block"}}
execute align xyz run summon block_display ~-1 ~-1 ~ {block_state:{Name:"minecraft:brown_mushroom_block"}}
execute align xyz run summon block_display ~ ~-1 ~1 {block_state:{Name:"minecraft:brown_mushroom_block"}}
execute align xyz run summon block_display ~ ~-1 ~-1 {block_state:{Name:"minecraft:brown_mushroom_block"}}
execute align xyz run summon block_display ~1 ~ ~ {block_state:{Name:"minecraft:cobblestone_wall"}}
execute align xyz run summon block_display ~-1 ~ ~ {block_state:{Name:"minecraft:cobblestone_wall"}}
execute align xyz run summon block_display ~ ~ ~1 {block_state:{Name:"minecraft:cobblestone_wall"}}
execute align xyz run summon block_display ~ ~ ~-1 {block_state:{Name:"minecraft:cobblestone_wall"}}
execute align xyz run summon block_display ~1 ~1 ~ {block_state:{Name:"minecraft:iron_bars"}}
execute align xyz run summon block_display ~-1 ~1 ~ {block_state:{Name:"minecraft:iron_bars"}}
execute align xyz run summon block_display ~ ~1 ~1 {block_state:{Name:"minecraft:iron_bars"}}
execute align xyz run summon block_display ~ ~1 ~-1 {block_state:{Name:"minecraft:iron_bars"}}
execute align xyz run summon block_display ~1 ~2 ~ {block_state:{Name:"minecraft:iron_bars"}}
execute align xyz run summon block_display ~-1 ~2 ~ {block_state:{Name:"minecraft:iron_bars"}}
execute align xyz run summon block_display ~ ~2 ~1 {block_state:{Name:"minecraft:iron_bars"}}
execute align xyz run summon block_display ~ ~2 ~-1 {block_state:{Name:"minecraft:iron_bars"}}
execute align xyz run summon block_display ~1 ~3 ~ {block_state:{Name:"minecraft:andesite_stairs",Properties:{facing:"west"}}}
execute align xyz run summon block_display ~-1 ~3 ~ {block_state:{Name:"minecraft:andesite_stairs",Properties:{facing:"east"}}}
execute align xyz run summon block_display ~ ~3 ~1 {block_state:{Name:"minecraft:andesite_stairs",Properties:{facing:"north"}}}
execute align xyz run summon block_display ~ ~3 ~-1 {block_state:{Name:"minecraft:andesite_stairs",Properties:{facing:"south"}}}
execute align xyz run summon block_display ~ ~3 ~ {block_state:{Name:"minecraft:andesite_slab",Properties:{type:"top"}}}
execute align xyz run summon block_display ~ ~4 ~ {block_state:{Name:"minecraft:birch_slab"}}
tag @e[type=block_display,tag=!survisland.old] add survisland.s16_small_cage
tag @e[type=block_display,tag=!survisland.old] add survisland.moving_structure

# Summon the controller marker
$data modify storage survisland:temp moving_structure set value {Tags:["survisland.s16_small_cage"],destination:[$(x),$(y),$(z)],duration:$(duration)}
execute align xyz summon marker run function survisland:moving_structure/place/_on_new

# Remove old block displays tag
tag @e[type=block_display,tag=survisland.old] remove survisland.old

