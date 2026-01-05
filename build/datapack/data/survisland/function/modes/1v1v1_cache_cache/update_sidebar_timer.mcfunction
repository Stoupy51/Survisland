
#> survisland:modes/1v1v1_cache_cache/update_sidebar_timer
#
# @within	survisland:modes/1v1v1_cache_cache/second
#

data modify storage survisland:main input set value {add_m:"",minutes:0,add_s:"",seconds:0}

scoreboard players operation #seconds survisland.data = #remaining_time survisland.data
scoreboard players operation #seconds survisland.data %= #60 survisland.data
execute store result storage survisland:main input.seconds int 1 run scoreboard players get #seconds survisland.data
execute if score #seconds survisland.data matches ..9 run data modify storage survisland:main input.add_s set value "0"

scoreboard players operation #minutes survisland.data = #remaining_time survisland.data
scoreboard players operation #minutes survisland.data /= #60 survisland.data
execute store result storage survisland:main input.minutes int 1 run scoreboard players get #minutes survisland.data
execute if score #minutes survisland.data matches ..9 run data modify storage survisland:main input.add_m set value "0"

function survisland:modes/1v1v1_cache_cache/macro_update_sb_timer with storage survisland:main input

