
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
""" The seven keys readable through a 26.2 input predicate (see InputPredicate.java).
Each one is the raw key state, so "sprint" is the sprint key itself and misses a sprint started by double tapping forward.
"""

GROUP_SIZE: int = 4
""" Number of slots of a group, so the number of players sharing one mannequin. """

GROUP_RADIUS: int = 16
""" Radius searched first when a rider has to be put back on its vehicle.
A player who fell off is normally right there, and the whole world is searched only when that fails.
"""

TRIGGER_RADIUS: int = 3
""" Radius of the command blocks driving a group.
The start block enrolls the free players standing on it, the others act on the nearest mannequin.
"""

SEAT_RADIUS: int = 3
""" Radius searched around a mannequin for the item display carrying its click holder.
Out of range means the mannequin was teleported without its seat, and the seat is then searched everywhere.
"""

START_PLAYERS: int = 4
""" Free players needed within TRIGGER_RADIUS for a start block to form a group, lower it to test with fewer people. """

CRAWL_KEY: str = "sprint"
""" Key read on the "crawl" holder to lay the mannequin down, since no vanilla key exists for it.
It stays free in the Fort part because the sprint action belongs to another player there.
"""

MANNEQUIN_PROFILE: str = "GoldVision98"
""" Player name giving its skin to the mannequin, empty to keep the default skin. """

WALK_SPEED: int = 216
""" Horizontal speed in thousandths of a block per tick, matching the vanilla walking speed. """

SPRINT_SPEED: int = 432
""" Horizontal speed when sprinting, twice the walking speed. """

SPRINT_HOLD: int = 5
""" Ticks a sprint press keeps the mannequin sprinting.
Holding the key with Toggle Sprint on makes it flip on every keyboard repeat, so the press is latched instead of read raw.
"""

BACK_SPEED: int = 130
""" Horizontal speed when walking backward. """

SNEAK_SPEED: int = 65
""" Horizontal speed when sneaking. """

JUMP_VELOCITY: int = 420
""" Vertical velocity given on jump, matching the vanilla 0.42 block per tick. """

CLICK_OFFSET: str = "0.6"
""" Blocks in front of the mannequin eyes where the click holder sits.
Sitting on the head would fill its screen with the mannequin skin and put the mannequin in the way of every raycast.
"""


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
	""" Action name -> slots (1 to 4) holding it. An action missing from the dict is disabled for the whole part.
	One slot cannot hold both "look" and "click": the click holder rides its own seat, out of reach of the pass reading the aim.
	"""


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

PHASES: list[Phase] = [
	Phase(id="clairiere", display="Partie 1 - Clairière", bindings={"forward": (1,), "backward": (1,), "click": (2,), "jump": (3,), "left": (3,), "right": (3,), "look": (4,)}),
	Phase(id="riviere",   display="Partie 2 - Rivière",   bindings={"look": (1,), "forward": (2,), "jump": (3,), "backward": (3,), "left": (4,), "right": (4,)}),
	Phase(id="fort",      display="Partie 3 - Fort",      bindings={"click": (1,), "backward": (1,), "jump": (2,), "look": (2,), "sprint": (3,), "left": (3,), "right": (3,), "forward": (4,), "sneak": (4,), "crawl": (4,)}),
]
""" The three parts where the mannequin is shared, in play order.
Before the first one and after the last one the players own their body, so there is no phase for those.
"""


# Functions
def actions_of_slot(phase: Phase, slot: int) -> list[Action]:
	""" List the actions held by a slot during a phase, in ACTIONS order

	Args:
		phase: The phase to look into
		slot:  The slot number, from 1 to 4
	Returns:
		The actions held by that slot

	>>> [action.name for action in actions_of_slot(PHASES[0], 1)]
	['forward', 'backward']
	>>> [action.name for action in actions_of_slot(PHASES[0], 4)]
	['look']
	"""
	return [action for action in ACTIONS if slot in phase.bindings.get(action.name, ())]

