""" Data of the crew modes, where several players share the controls of one mannequin.

A CrewMode holds everything that differs between two of them: where its functions live, how many players share a body, and its command sets.
Everything the generator writes (tags, predicates, tellraw help, interaction range attributes, cleanup) is derived from these tables.
"""
# ruff: noqa: E501
# Imports
from dataclasses import dataclass

# Constants
INPUT_KEYS: tuple[str, ...] = ("forward", "backward", "left", "right", "jump", "sneak", "sprint")
""" The seven keys readable through a 26.2 input predicate (see InputPredicate.java).
Each one is the raw key state, so "sprint" is the sprint key itself and misses a sprint started by double tapping forward.
"""

RADIUS: int = 50
""" Radius of every search made around a mannequin: its players, its seat, and who reads its help message.
A teleport carries the mannequin and its passengers but leaves the seat and whoever fell off behind, so the radius is wide enough to catch them.
"""

TRIGGER_RADIUS: int = 3
""" Radius of the command blocks driving a group.
The start block enrolls the free players standing on it, the others act on the nearest mannequin.
"""

CRAWL_KEY: str = "sprint"
""" Key read on the "crawl" holder to lay the mannequin down, since no vanilla key exists for it.
It stays free in the Fort part because the sprint action belongs to another player there.
"""

WALK_SPEED: int = 216
""" Horizontal speed in thousandths of a block per tick, matching the vanilla walking speed. """

SPRINT_SPEED: int = 281
""" Horizontal speed when sprinting, the vanilla 1.3 times the walking speed. """

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
	""" Used for the function path <mode path>/set_phase/<id>. """
	display: str
	""" Title shown when the part begins. """
	bindings: dict[str, tuple[int, ...]]
	""" Action name -> slots (1 to group size) holding it. An action missing from the dict is disabled for the whole part.
	"""


@dataclass(frozen=True)
class CrewMode:
	""" One mode built on the shared mannequin, with its own functions, tags and objectives. """
	id: str
	""" Suffix of every tag, objective and fake player of the mode, so two modes never read each other's state. """
	path: str
	""" Function folder of the mode, ex: "modes/all_together". """
	group_size: int
	""" Number of slots of a group, so the number of players sharing one mannequin. """
	start_players: int
	""" Free players needed within TRIGGER_RADIUS for a start block to run, split into groups of group_size by distance. """
	phases: list[Phase]
	""" Command sets in play order, the first one being dealt when a group forms. """
	profile: str
	""" Player name giving its skin to the mannequin, empty to wear the skin of the Joueur 1 of the group. """
	start_filter: str = f"distance=..{TRIGGER_RADIUS}"
	""" Selector arguments a free player must match to be taken by the start block. """
	solo_flag: str = ""
	camera_distance: int = 5
	""" Third person camera distance of the mannequin, used by the players riding its head, so never by the click holder on its seat. """
	""" Score that, at 1, lets a single player start alone and hold every command, ex: "#solo survisland.data". """


# Constants (tables)
ACTIONS: list[Action] = [
	Action(name="forward",  display="Avancer"),
	Action(name="backward", display="Reculer"),
	Action(name="left",     display="Marcher à gauche"),
	Action(name="right",    display="Marcher à droite"),
	Action(name="jump",     display="Sauter"),
	Action(name="sneak",    display="S'accroupir"),
	Action(name="sprint",   display="Sprinter"),
	Action(name="crawl",    display="S'allonger (touche sprint)"),
	Action(name="look",     display="Tourner la tête"),
	Action(name="click",    display="Clic gauche / Clic droit"),
]
""" Every action, in the order used to build the help message. """

PHASES: list[Phase] = [
	Phase(id="clairiere", display="Partie 1 - Clairière", bindings={"forward": (1,), "backward": (1,), "click": (2,), "jump": (3,), "left": (3,), "right": (3,), "look": (4,)}),
	Phase(id="riviere",   display="Partie 2 - Rivière",   bindings={"look": (1,), "forward": (2,), "jump": (3,), "click": (3,), "left": (4,), "right": (4,), "backward": (4,)}),
	Phase(id="fort",      display="Partie 3 - Fort",      bindings={"click": (1,), "look": (2,), "backward": (2,), "sprint": (3,), "left": (3,), "right": (3,), "jump": (3,), "forward": (4,), "sneak": (4,), "crawl": (4,)}),
]
""" The three parts where the mannequin is shared, in play order.
Before the first one and after the last one the players own their body, so there is no phase for those.
"""

ALL_TOGETHER: CrewMode = CrewMode(id="all_together", path="modes/all_together", group_size=4, start_players=4, phases=PHASES, profile="GoldVision98")
""" The original adventure: four players on one mannequin, over three parts. """


# Functions
def actions_of_slot(phase: Phase, slot: int) -> list[Action]:
	""" List the actions held by a slot during a phase, in ACTIONS order

	Args:
		phase: The phase to look into
		slot:  The slot number, from 1 to the group size
	Returns:
		The actions held by that slot

	>>> [action.name for action in actions_of_slot(PHASES[0], 1)]
	['forward', 'backward']
	>>> [action.name for action in actions_of_slot(PHASES[0], 4)]
	['look']
	"""
	return [action for action in ACTIONS if slot in phase.bindings.get(action.name, ())]

