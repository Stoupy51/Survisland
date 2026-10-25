
# Imports
from stewbeet import Item, JsonDict, Mem


# Main function
def main() -> None:

	# If disabled in config, skip loading this module
	meta: JsonDict = Mem.ctx.meta["survisland"].get("modules", {}).get("lespetitstravaux", {})
	if not meta.get("sounds", False):
		Mem.ctx.meta["stewbeet"]["sounds"]["exclude_patterns"].append("lespetitstravaux/*")
	if not meta.get("items", False):
		return

	Item(id="kokodr_crigolo", base_item="minecraft:stick")