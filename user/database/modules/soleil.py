
# Imports
from stewbeet import JsonDict, Mem


# Main function
def main() -> None:

	# If disabled in config, keep the ARAM lib out of the weld merge and out of the build destinations
	meta: JsonDict = Mem.ctx.meta["survisland"].get("modules", {}).get("soleil", {})
	if not meta.get("libs", False):
		Mem.ctx.meta["stewbeet"]["libs_exclude_patterns"].append("datapack/*Soleil_Datapack_1110.zip")

	# If disabled in config, skip loading this module
	if not meta.get("sounds", False):
		Mem.ctx.meta["stewbeet"]["sounds"]["exclude_patterns"].append("soleil/*")

