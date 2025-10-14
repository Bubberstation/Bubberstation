// Story Values for Base Atoms
// These define the baseline "story value" for different types of atoms in the game.
// Story value represents how significant an atom is to the narrative, influencing
// event planning, analysis, and balancing in the storyteller system.
// Higher values indicate greater importance (e.g., humans are more valuable than basic atoms).

// Basic atom (generic, low narrative impact)
#define STORY_VALUE_BASE_ATOM 1
// Turfs (floors, walls, etc., foundational but replaceable)
#define STORY_VALUE_BASE_TURF 10
// Items (tools, objects, moderate utility)
#define STORY_VALUE_BASE_ITEM 10
// Machines (complex systems like engines or fabricators)
#define STORY_VALUE_BASE_MACHINE 100
// Structures (simple builds, low impact)
#define STORY_VALUE_BASE_STRUCTURE 1
// Mobs (living entities, high narrative potential)
#define STORY_VALUE_BASE_MOB 100
// Carbon-based life (organic mobs, similar to mobs)
#define STORY_VALUE_BASE_CARBON 100
// Humans (key players, highest base value for crew)
#define STORY_VALUE_BASE_HUMAN 150

// Registration Macro for Storyteller
// This macro registers an atom with the storyteller subsystem (SSstorytellers).
// Used to track atoms for analysis, event targeting, and value computation.
// Call this when spawning or initializing relevant atoms.

#define REGISTER_ATOM_FOR_STORYTELLER(A) do { \
	SSstorytellers.register_atom_for_storyteller(A); \
} while(FALSE)  // Wrapped in do-while for safe multi-line usage




// Storyteller Memory Defines
// These are keys for storing data in the storyteller's memory system.
// Used for caching event candidates, progress tracking, or temporary states.

// Key for potential event candidates during planning
#define STORY_MEMORY_EVENT_CANDIDATE "memory_event_candidate"



// Weights for Entities in Balancing
// These weights are used in the balancer subsystem to compute relative importance
// of entities (e.g., players vs. antagonists) when updating plans or adjusting difficulty.
// They scale based on STORY_DEFAULT_WEIGHT and influence global goal progress,
// event intensity, and antagonist spawning.


// Baseline weight for generic entities
#define STORY_DEFAULT_WEIGHT 1
// Weight for living mobs (e.g., animals)
#define STORY_LIVING_WEIGHT (STORY_DEFAULT_WEIGHT * 2)
// Weight for carbon-based life (organic complexity)
#define STORY_CARBON_WEIGHT (STORY_DEFAULT_WEIGHT * 5)
// Weight for humans (core crew members)
#define STORY_HUMAN_WEIGHT (STORY_DEFAULT_WEIGHT * 10)
// Weight for antagonists (high threat/disruption)
#define STORY_DEFAULT_ANTAG_WEIGHT (STORY_DEFAULT_WEIGHT * 10)

#define STORY_MINOR_ANTAG_WEIGHT (STORY_DEFAULT_ANTAG_WEIGHT + 5)

#define STORY_MEDIUM_ANTAG_WEIGHT (STORY_MINOR_ANTAG_WEIGHT * 2)

#define STORY_MAJOR_ANTAG_WEIGHT (STORY_MEDIUM_ANTAG_WEIGHT * 2)

// Job Roles Weights
// These modifiers adjust weights based on job roles, affecting how the storyteller
// prioritizes events or subgoals involving specific crew members.
// For example, engineers might have higher weight in infrastructure-related goals.

#define STORY_DEFAULT_JOB_WEIGHT_MODIFIER 1.0  // Default multiplier for job-based weight adjustments
// Higher for tech-focused roles
#define STORY_ENGINEER_JOB_WEIGHT_MODIFIER (STORY_DEFAULT_JOB_WEIGHT_MODIFIER * 1.5)
// Higher for conflict roles
#define STORY_SECURITY_JOB_WEIGHT_MODIFIER (STORY_DEFAULT_JOB_WEIGHT_MODIFIER * 2.0)

#define STORY_GOAL_BASE_WEIGHT 1.0

#define STORY_GOAL_BIG_WEIGHT 3.0

#define STORY_GOAL_MAJOR_WEIGHT 5.0

#define STORY_GOAL_BASE_PRIORITY 1

#define STORY_GOAL_HIGH_PRIORITY 5

#define STORY_GOAL_CRITICAL_PRIORITY 10


#define STORY_GOAL_NO_THREAT 0.0
// Basic threat level for standard goals
#define STORY_GOAL_THREAT_BASIC 1.0

#define STORY_GOAL_THREAT_ELEVATED 4.0

#define STORY_GOAL_THREAT_HIGH 8.0

#define STORY_GOAL_THREAT_EXTREME 10.0

#define STORY_ROUND_PROGRESSION_START 0

#define STORY_ROUND_PROGRESSION_EARLY 0.21

#define STORY_ROUND_PROGRESSION_MID 0.51

#define STORY_ROUND_PROGRESSION_LATE 0.81

#define RESCAN_STATION_INTEGRITY (1 << 0)
#define RESCAN_STATION_VALUE (1 << 1)

DEFINE_BITFIELD(story_analyzer_flags, list(
	"STORYTELLER_SCAN_INTEGRITY" = RESCAN_STATION_INTEGRITY,
	"STORYTELLER_SCAN_VALUE" = RESCAN_STATION_VALUE,
))


// Bitfield categories for story goals

// Goals selected in a random order
#define STORY_GOAL_RANDOM (1 << 0)
// Positive goals
#define STORY_GOAL_GOOD (1 << 1)
// Negative goals
#define STORY_GOAL_BAD (1 << 2)
// Global goals that can be selected as the primary goal, actually it's a sub-category
#define STORY_GOAL_GLOBAL (1 << 3)
// Goals related to actions involving antagonists
#define STORY_GOAL_NEUTRAL (1 << 4)
// Goals without a specific category
#define STORY_GOAL_UNCATEGORIZED (1 << 5)


DEFINE_BITFIELD(story_goal_category, list(
	"GOAL_RANDOM" = STORY_GOAL_RANDOM,
	"GOAL_GOOD" = STORY_GOAL_GOOD,
	"GOAL_BAD" = STORY_GOAL_BAD,
	"GOAL_GLOBAL" = STORY_GOAL_GLOBAL,
	"GOAL_NEUTRAL" = STORY_GOAL_NEUTRAL,
	"GOAL_UNCATEGORIZED" = STORY_GOAL_UNCATEGORIZED,
))


// Bitfield for universal tags describing areas of influence
// These tags characterize the scope or impact of a goal, such as escalation/deescalation or effects on specific station elements.
// They complement categories (directionality like good/bad) by focusing on what the goal affects (e.g., crew health, resources).
// Used in storyteller planning to filter/weight goals based on station metrics (e.g., low health prioritizes AFFECTS_CREW_HEALTH).

// Escalation: Goals that increase tension, chaos, or threats (e.g., triggering conflicts or disasters).
#define STORY_TAG_ESCALATION (1 << 0)
// Deescalation: Goals that reduce tension, promote recovery, or stabilize the station (e.g., healing or resource restoration).
#define STORY_TAG_DEESCALATION (1 << 1)
// Affects Crew Health: Goals impacting crew well-being, such as healing wounds, spreading diseases, or causing harm.
#define STORY_TAG_AFFECTS_CREW_HEALTH (1 << 2)

#define STORY_TAG_AFFECTS_CREW_MIND (1 << 3)
// Affects Antagonist: Goals influencing antagonists, like boosting/hindering their power or triggering antag-related events.
#define STORY_TAG_AFFECTS_ANTAGONIST (1 << 4)
// Affects Resources: Goals related to station resources, such as generating/supplying items, destroying infrastructure, or economic impacts.
#define STORY_TAG_AFFECTS_RESOURCES (1 << 5)
// Affects Morale: Goals influencing crew mood or psychological state (e.g., events boosting/lowering happiness or panic).
#define STORY_TAG_AFFECTS_MORALE (1 << 6)
// Affects Infrastructure: Goals targeting station structures, like repairs, sabotage, or environmental changes.
#define STORY_TAG_AFFECTS_INFRASTRUCTURE (1 << 7)
// Affects Economy: Goals involving trade, credits, or resource allocation (e.g., cargo shipments or thefts).
#define STORY_TAG_AFFECTS_ECONOMY (1 << 8)
// Affects Security: Goals related to security systems, arrests, or law enforcement dynamics.
#define STORY_TAG_AFFECTS_SECURITY (1 << 9)
//
#define STORY_TAG_AFFECTS_WHOLE_STATION (1 << 10)
// Affects Research: Goals impacting science/tech progress, like experiments or tech unlocks/destruction.
#define STORY_TAG_AFFECTS_RESEARCH (1 << 11)
// Goals impacting station environment, like atmos breaches, radiation, or hull integrity.
#define STORY_TAG_AFFECTS_ENVIRONMENT (1 << 12)
// Goals related to tech systems, AI, comms, or machinery (e.g., hacks or upgrades).
#define STORY_TAG_AFFECTS_TECHNOLOGY (1 << 13)
// Goals influencing command structure, laws, or crew hierarchy (e.g., mutinies or promotions).
#define STORY_TAG_AFFECTS_POLITICS (1 << 14)
// Goals introducing randomness or unpredictability, favoring volatile moods.
#define STORY_TAG_CHAOTIC (1 << 15)
// Goals targeting specific individuals rather than groups or the whole station.
#define STORY_TAG_TARGETS_INDIVIDUALS (1 << 16)
// Goals with broad impact across multiple station systems or the entire station.
#define STORY_TAG_WIDE_IMPACT (1 << 17)
// Goals involving entities (mobs, creatures) rather than just objects or systems.
#define STORY_TAG_ENTITIES (1 << 18)

#define STORY_TAG_TARGETS_SYSTEMS (STORY_TAG_AFFECTS_INFRASTRUCTURE | STORY_TAG_AFFECTS_TECHNOLOGY | STORY_TAG_AFFECTS_ENVIRONMENT)

DEFINE_BITFIELD(story_universal_tags, list(
	"ESCALATION" = STORY_TAG_ESCALATION,
	"DEESCALATION" = STORY_TAG_DEESCALATION,
	"AFFECTS_CREW_HEALTH" = STORY_TAG_AFFECTS_CREW_HEALTH,
	"AFFECTS_CREW_MIND" = STORY_TAG_AFFECTS_CREW_MIND,
	"AFFECTS_ANTAGONIST" = STORY_TAG_AFFECTS_ANTAGONIST,
	"AFFECTS_RESOURCES" = STORY_TAG_AFFECTS_RESOURCES,
	"AFFECTS_MORALE" = STORY_TAG_AFFECTS_MORALE,
	"AFFECTS_INFRASTRUCTURE" = STORY_TAG_AFFECTS_INFRASTRUCTURE,
	"AFFECTS_ECONOMY" = STORY_TAG_AFFECTS_ECONOMY,
	"AFFECTS_SECURITY" = STORY_TAG_AFFECTS_SECURITY,
	"AFFECTS_WHOLESTATION" = STORY_TAG_AFFECTS_WHOLE_STATION,
	"AFFECTS_RESEARCH" = STORY_TAG_AFFECTS_RESEARCH,
	"AFFECTS_ENVIRONMENT" = STORY_TAG_AFFECTS_ENVIRONMENT,
	"AFFECTS_TECHNOLOGY" = STORY_TAG_AFFECTS_TECHNOLOGY,
	"AFFECTS_POLITICS" = STORY_TAG_AFFECTS_POLITICS,
	"CHAOTIC" = STORY_TAG_CHAOTIC,
	"TARGETS_INDIVIDUALS" = STORY_TAG_TARGETS_INDIVIDUALS,
	"WIDE_IMPACT" = STORY_TAG_WIDE_IMPACT,
	"ENTITIES" = STORY_TAG_ENTITIES,
))

#define STORY_GOAL_PENDING "goal_pending"
#define STORY_GOAL_FIRING "goal_firing"
#define STORY_GOAL_COMPLETED "goal_completed"
#define STORY_GOAL_FAILED "goal_failed"

// Core storyteller pacing and difficulty constants
#define STORY_THINK_BASE_DELAY (2 MINUTES)
#define STORY_MIN_EVENT_INTERVAL (30 SECONDS)
#define STORY_MAX_EVENT_INTERVAL (20 MINUTES)
#define STORY_DEFAULT_PLAYER_ANTAG_BALANCE 50

// Threat/adaptation constants
#define STORY_THREAT_GROWTH_RATE 1.0
#define STORY_ADAPTATION_DECAY_RATE 0.05
#define STORY_RECENT_DAMAGE_THRESHOLD 20
#define STORY_TARGET_TENSION 50
#define STORY_GRACE_PERIOD (10 MINUTES)
#define STORY_MAX_THREAT_SCALE 100.0 // Maximum 10 000 points for events
#define STORY_REPETITION_PENALTY 0.5
#define STORY_DIFFICULTY_MULTIPLIER 1.0
#define STORY_POPULATION_FACTOR 1.0

// Planner constants
#define STORY_RECALC_INTERVAL (10 MINUTES)
#define STORY_BASE_SUBGOALS_COUNT 3
#define STORY_PICK_THREAT_BONUS_SCALE 0.01
#define STORY_BALANCE_BONUS 1.5
#define STORY_PACE_MIN 0.1
#define STORY_PACE_MAX 3.0

// Balancer constants
#define STORY_BALANCER_PLAYER_WEIGHT 1.0
#define STORY_BALANCER_ANTAG_WEIGHT 2.0
#define STORY_BALANCER_WEAK_ANTAG_THRESHOLD 0.5
#define STORY_BALANCER_INACTIVE_ACTIVITY_THRESHOLD 0.25
#define STORY_STATION_STRENGTH_MULTIPLIER 1.0

// Metric thresholds
#define STORY_INACTIVITY_ACT_INDEX_THRESHOLD 0.15
#define STORY_ACTIVITY_CREW_SCALE 0.1
#define STORY_DAMAGE_SCALE 100
#define STORY_ACTIVITY_TIME_SCALE 10
#define STORY_DISRUPTION_SCALE 10
#define STORY_INFLUENCE_SCALE 5
#define STORY_KILLS_CAP 3
#define STORY_OBJECTIVES_CAP 3

// Round progression tuning (target: ~3 hours average round, 60-80 players)
#define STORY_ROUND_PROGRESSION_TRESHOLD (2 HOURS)
#define STORY_EARLY_WARMUP_DURATION (20 MINUTES)
#define STORY_EARLY_CREW_FAVOR 1.15
#define STORY_EARLY_STORYTELLER_WEAKNESS 0.85
#define STORY_THREAT_RAMP_TARGET 1.5
#define STORY_DIFFICULTY_RAMP_TARGET 1.3
#define STORY_GRACE_MIN (2 MINUTES)
#define STORY_GRACE_MAX STORY_GRACE_PERIOD_DEFAULT
#define STORY_GRACE_PERIOD_DEFAULT (5 MINUTES)
#define STORY_PLAYER_BASELINE 70
#define STORY_POPULATION_MIN 0.8
#define STORY_POPULATION_MAX 1.8



#define STORY_THREAT_LOW 100
#define STORY_THREAT_MODERATE 500
#define STORY_THREAT_HIGH 2000
#define STORY_THREAT_EXTREME 5000
#define STORY_THREAT_APOCALYPTIC 10000
