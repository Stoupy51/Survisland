
# Tick更新
    execute store result storage global Time int 1 run time query gametime

# 取得部分
    function e.anchor:get_data/selecteditem
    function e.anchor:get_data/inventory
    function e.anchor:get_data/item_check
	data modify storage chuz:context Item.Offhand set from storage chuz:context Item.Inventory[-1]
