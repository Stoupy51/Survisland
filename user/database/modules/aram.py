
# Imports
from stewbeet import JsonDict, Mem


# Main function
def main() -> None:

	# If disabled in config, keep the ARAM lib out of the weld merge and out of the build destinations
	meta: JsonDict = Mem.ctx.meta["survisland"].get("modules", {}).get("aram", {})
	if not meta.get("libs", False):
		Mem.ctx.meta["stewbeet"]["libs_exclude_patterns"].append("resource_pack/*ARAM.zip")

