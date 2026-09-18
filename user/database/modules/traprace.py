
# Imports
from stewbeet import JsonDict, Mem


# Main function
def main() -> None:

	# If disabled in config, skip loading this module
	meta: JsonDict = Mem.ctx.meta["survisland"].get("modules", {}).get("traprace", {})
	if not meta.get("sounds", False):
		Mem.ctx.meta["stewbeet"]["sounds"]["exclude_patterns"].append("traprace/*")

