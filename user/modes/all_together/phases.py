
""" Data of the "All Together" mode: the actions a player can be given, and the command set of each part of the adventure.

Everything the generator writes (tags, predicates, tellraw help, interaction range attributes, cleanup) is derived from these tables.
"""
# ruff: noqa: E501
# Imports
from dataclasses import dataclass

# Constants
MODE: str = "all_together"
""" Folder name of the mode, used for every generated function path and every tag. """

INPUT_KEYS: tuple[str, ...] = ("forward", "backward", "left", "right", "jump", "sneak", "sprint")
""" The seven keys readable through a 26.2 input predicate (see InputPredicate.java). """

GROUP_RADIUS: int = 50
""" Radius around a mannequin holding its own four players.
Teams are always more than 150 blocks apart, so this radius groups them without ever needing to know how many there are.
"""

CRAWL_KEY: str = "sprint"
""" Key read on the "crawl" holder to lay the mannequin down, since no vanilla key exists for it.
It stays free in the Fort part because the sprint action belongs to another player there.
"""

MANNEQUIN_PROFILE: str = ""
""" Player name giving its skin to the mannequin, empty to keep the default skin. """

WALK_SPEED: int = 216
""" Horizontal speed in thousandths of a block per tick, matching the vanilla walking speed. """

SPRINT_SPEED: int = 280
""" Horizontal speed when sprinting. """

BACK_SPEED: int = 130
""" Horizontal speed when walking backward. """

SNEAK_SPEED: int = 65
""" Horizontal speed when sneaking. """

JUMP_VELOCITY: int = 420
""" Vertical velocity given on jump, matching the vanilla 0.42 block per tick. """

EYE_OFFSET: str = "1.519"
""" Height at which the players are teleported so their eyes match the mannequin ones: 1.62 - 1.62 * 0.0625 (scale is clamped to 0.0625). """


# Classes
@dataclass(frozen=True)
class Action:
	""" One thing the mannequin can do, and how the tick reads it. """
	name: str
	""" Tag suffix and, for movement actions, name of the input predicate to test. """
	display: str
	""" Label shown to the players when a part begins. """


@dataclass(frozen=True)
class Phase:
	""" One part of the adventure, with its command set. """
	id: str
	""" Used for the function path survisland:modes/all_together/set_phase/<id>. """
	display: str
	""" Title shown when the part begins. """
	bindings: dict[str, tuple[int, ...]]
	""" Action name -> slots (1 to 4) holding it. An action missing from the dict is disabled for the whole part. """
	sprint_when_all_forward: bool = False
	""" Sprint when every holder of "forward" presses it at the same time, instead of relying on the "sprint" action. """


# Constants (tables)
ACTIONS: list[Action] = [
	Action(name="forward",  display="Avancer"),
	Action(name="backward", display="Reculer"),
	Action(name="left",     display="Marcher à gauche"),
	Action(name="right",    display="Marcher à droite"),
	Action(name="jump",     display="Sauter"),
	Action(name="sneak",    display="S'accroupir"),
	Action(name="sprint",   display="Sprinter"),
	Action(name="crawl",    display="S'allonger"),
	Action(name="look",     display="Tourner la tête"),
	Action(name="click",    display="Clic gauche / Clic droit"),
]
""" Every action, in the order used to build the help message. """

ALL: tuple[int, ...] = (1, 2, 3, 4)
""" Shorthand for the parts where everybody controls everything. """

PHASES: list[Phase] = [
	Phase(id="prologue",  display="Prologue - Laboratoire", bindings={"forward": ALL, "backward": ALL, "left": ALL, "right": ALL, "jump": ALL, "sneak": ALL, "sprint": ALL, "look": ALL, "click": ALL}),
	Phase(id="clairiere", display="Partie 1 - Clairière",   bindings={"forward": (1,), "backward": (1,), "click": (2,), "jump": (3,), "left": (3,), "right": (3,), "look": (4,)}),
	Phase(id="riviere",   display="Partie 2 - Rivière",     bindings={"look": (1,), "forward": (2, 4), "jump": (3,), "backward": (3,)}, sprint_when_all_forward=True),
	Phase(id="fort",      display="Partie 3 - Fort",        bindings={"click": (1,), "backward": (1,), "jump": (2,), "look": (2,), "sprint": (3,), "left": (3,), "right": (3,), "forward": (4,), "sneak": (4,), "crawl": (4,)}),
	Phase(id="donjon",    display="Partie 4 - Donjon",      bindings={"forward": ALL, "backward": ALL, "left": ALL, "right": ALL, "jump": ALL, "sneak": ALL, "sprint": ALL, "look": ALL, "click": ALL}),
]
""" The five parts of the game design document, in play order. """


# Functions
def actions_of_slot(phase: Phase, slot: int) -> list[Action]:
	""" List the actions held by a slot during a phase, in ACTIONS order

	Args:
		phase (Phase): The phase to look into
		slot  (int):   The slot number, from 1 to 4
	Returns:
		list[Action]: The actions held by that slot

	Examples:
		>>> [action.name for action in actions_of_slot(PHASES[1], 1)]
		['forward', 'backward']
		>>> [action.name for action in actions_of_slot(PHASES[1], 4)]
		['look']
	"""
	return [action for action in ACTIONS if slot in phase.bindings.get(action.name, ())]

