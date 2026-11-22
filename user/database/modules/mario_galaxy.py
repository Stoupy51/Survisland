import stouputils as stp
from stewbeet import Item, JsonDict, Mem

DISPLAYS: tuple[str, ...] = (
	"thirdperson_righthand", "thirdperson_lefthand", "firstperson_righthand", "firstperson_lefthand",
	"ground", "gui", "head", "fixed", "on_shelf",
)

def main() -> None:
	ns: str = Mem.ctx.project_id
	meta: JsonDict = Mem.ctx.meta["survisland"].get("modules", {}).get("mario_galaxy", {})
	if not meta.get("items", False):
		return

	# For Mario Galaxy Trial
	override_model: JsonDict = {"display": {x: {"scale": [1, 1, 1]} for x in DISPLAYS}}
	override_model["display"]["ground"] = {"scale": [0, 0, 0]}
	Item(id="red_coin", manual_category="misc", override_model=override_model, components={"item_name": {"text":"Pièce Rouge","color":"red","italic":False}})
	Item(id="super_star", manual_category="misc", components={"item_name": {"text":"Etoile","color":"gold","italic":False}})

	for star in ("launch_star", "launch_star_inner", "galaxy_kart"):
		model: JsonDict = stp.json_load(f"{Mem.ctx.directory}/assets/models/mario_galaxy/{star}.json")
		for k in model["textures"]:
			model["textures"][k] = f"{ns}:item/{star}"
		Item(id=star, override_model=model)
