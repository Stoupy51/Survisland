
# Imports
from stewbeet import JsonDict, Mem


# Main function
def main() -> None:

	# If disabled in config, keep the Cache-cache libs out of the weld merge and out of the build destinations
	meta: JsonDict = Mem.ctx.meta["survisland"].get("modules", {}).get("cache_cache", {})
	if not meta.get("libs", False):
		Mem.ctx.meta["stewbeet"]["libs_exclude_patterns"].extend(("datapack/Cache-cache*.zip", "resource_pack/Cache-cache*.zip"))

