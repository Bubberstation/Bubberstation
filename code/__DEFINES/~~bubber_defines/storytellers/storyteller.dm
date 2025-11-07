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

// Minor antagonist weight (weak threats like space ninjas)
#define STORY_MINOR_ANTAG_WEIGHT (STORY_DEFAULT_ANTAG_WEIGHT + 5)

// Medium antagonist weight (moderate threats like traitors)
#define STORY_MEDIUM_ANTAG_WEIGHT (STORY_MINOR_ANTAG_WEIGHT * 2)

// Major antagonist weight (severe threats like cults or blobs)
#define STORY_MAJOR_ANTAG_WEIGHT (STORY_MEDIUM_ANTAG_WEIGHT * 2)

// Job Roles Weights
// These modifiers adjust weights based on job roles, affecting how the storyteller
// prioritizes events or subgoals involving specific crew members.
// For example, engineers might have higher weight in infrastructure-related goals.

#define STORY_DEFAULT_JOB_WEIGHT 10.0  // Default multiplier for job-based weight adjustments

#define STORY_ENGINEER_JOB_WEIGHT (STORY_DEFAULT_JOB_WEIGHT * 1.5)

#define STORY_SECURITY_JOB_WEIGHT (STORY_DEFAULT_JOB_WEIGHT * 2.5)

#define STORY_MEDICAL_JOB_WEIGHT (STORY_DEFAULT_JOB_WEIGHT * 1.5)

#define STORY_HEAD_JOB_WEIGHT (STORY_DEFAULT_JOB_WEIGHT * 3)

#define STORY_UNIMPORTANT_JOB_WEIGHT (STORY_DEFAULT_JOB_WEIGHT * 0.5)

// Goal weight modifiers (affects event selection probability)
#define STORY_GOAL_BASE_WEIGHT 1.0  // Standard event weight
#define STORY_GOAL_BIG_WEIGHT 3.0   // Significant event weight
#define STORY_GOAL_MAJOR_WEIGHT 5.0  // Major event weight

#define STORY_WEIGHT_MINOR_ANTAGONIST (STORY_GOAL_BIG_WEIGHT * 1.2)
#define STORY_WEIGHT_MAJOR_ANTAGONIST (STORY_GOAL_MAJOR_WEIGHT * 1.2)


// Goal priority levels (affects scheduling order)
#define STORY_GOAL_BASE_PRIORITY 1    // Normal priority
#define STORY_GOAL_HIGH_PRIORITY 5    // High priority
#define STORY_GOAL_CRITICAL_PRIORITY 10  // Critical priority

// Goal threat levels (determines when events can trigger)
#define STORY_GOAL_NO_THREAT 0.0       // No threat required
#define STORY_GOAL_THREAT_BASIC 0.9    // Low threat level
#define STORY_GOAL_THREAT_ELEVATED 2.5 // Medium threat level
#define STORY_GOAL_THREAT_HIGH 3.0     // High threat level
#define STORY_GOAL_THREAT_EXTREME 5.0  // Extreme threat level

// Round progression milestones (0.0 = start, 1.0 = end)
#define STORY_ROUND_PROGRESSION_START 0    // Round start (0%)
#define STORY_ROUND_PROGRESSION_EARLY 0.12 // Early phase (0-12%)
#define STORY_ROUND_PROGRESSION_MID 0.51   // Mid phase (12-51%)
#define STORY_ROUND_PROGRESSION_LATE 0.73  // Late phase (51-73%)

// Analyzer scan flags (bitflags for what to scan)
#define RESCAN_STATION_INTEGRITY (1 << 0)  // Scan station integrity/hull
#define RESCAN_STATION_VALUE (1 << 1)      // Scan station value/resources

DEFINE_BITFIELD(story_analyzer_flags, list(
	"STORYTELLER_SCAN_INTEGRITY" = RESCAN_STATION_INTEGRITY,
	"STORYTELLER_SCAN_VALUE" = RESCAN_STATION_VALUE,
))


// Storytellers traits

#define STORYTELLER_TRAIT_NO_MERCY "NO_MERCY" // No bonus tension from events
#define STORYTELLER_TRAIT_CAN_HELP "CAN_HELP" // Storyteller can help the crew
#define STORYTELLER_TRAIT_FORCE_TENSION "FORCE_TENSION" // Force tension to be high
#define STORYTELLER_TRAIT_SPEAKER "LOVE_SPEAK" // Storyteller will speak more often
#define STORYTELLER_TRAIT_BALANCING_TENSTION "BALANCER" // Storyteller will balance tension more often
#define STORYTELLER_TRAIT_NO_GOOD_EVENTS "NO_GOOD_EVENTS" // No good events
#define STORYTELLER_TRAIT_KIND "KIND" // Good event will be more likely
#define STORYTELLER_TRAIT_NO_ADAPTATION_DECAY "NO_ADAPTAION_DECAY" // No adaptation decay, IT'S VEY BAD FOR CREW
#define STORYTELLER_TRAIT_RARE_ANTAG_SPAWN "RARE_ANTAG_SPAWN"  // Rare antagonist spawns
#define STORYTELLER_TRAIT_FREQUENT_ANTAG_SPAWN "FREQUENT_ANTAG_SPAWN"  // Frequent antagonist spawns
#define STORYTELLER_TRAIT_NO_ANTAGS "NO_ANTAGS"  // No antagonists at all
#define STORYTELLER_TRAIT_IMMEDIATE_ANTAG_SPAWN "IMMEDIATE_ANTAG_SPAWN"  // Spawn immediately when current weight drops

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
// Goal that's wound't be selected
#define STORY_GOAL_NEVER (1 << 6)
// Antagonist-related goals
#define STORY_GOAL_ANTAGONIST (1 << 7)

DEFINE_BITFIELD(story_goal_category, list(
	"GOAL_RANDOM" = STORY_GOAL_RANDOM,
	"GOAL_GOOD" = STORY_GOAL_GOOD,
	"GOAL_BAD" = STORY_GOAL_BAD,
	"GOAL_GLOBAL" = STORY_GOAL_GLOBAL,
	"GOAL_NEUTRAL" = STORY_GOAL_NEUTRAL,
	"GOAL_UNCATEGORIZED" = STORY_GOAL_UNCATEGORIZED,
	"GOAL_NEVER" = STORY_GOAL_NEVER,
	"GOAL_ANTAGONIST" = STORY_GOAL_ANTAGONIST,
))




// Bitfield categories for jobs flags
// Flags that mark job roles for special handling in storyteller logic

#define STORY_JOB_IMPORTANT (1 << 0)    // Important role (heads, etc.)
#define STORY_JOB_COMBAT (1 << 1)       // Combat-oriented role
#define STORY_JOB_ANTAG_MAGNET (1 << 2) // Role attracts antagonists
#define STORY_JOB_HEAVYWEIGHT (1 << 3)  // High-value target
#define STORY_JOB_SECURITY (1 << 4)     // Security/peacekeeping role

DEFINE_BITFIELD(story_job_flags, list(
	"JOB_IMPORTANT" = STORY_JOB_IMPORTANT,
	"JOB_COMBAT" = STORY_JOB_COMBAT,
	"JOB_ANTAG_MAGNET" = STORY_JOB_ANTAG_MAGNET,
	"JOB_HEAVYWEIGHT" = STORY_JOB_HEAVYWEIGHT,
	"JOB_SECURITY" = STORY_JOB_SECURITY,
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
// Affects Crew Mind: Goals impacting mental state (hallucinations, confusion, etc.)
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
// Affects whole station on include wide-station impact
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
// This event relates to antagonists
#define STORY_TAG_ANTAGONIST (1 << 19)
// This event occurs mid-round
#define STORY_TAG_MIDROUND (1 << 20)
// this event occurs on round start
#define STORY_TAG_ROUNDSTART (1 << 21)

// Combined tag: targets infrastructure, technology, or environment systems
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
	"ANTAGONIST" = STORY_TAG_ANTAGONIST,
	"MIDROUND" = STORY_TAG_MIDROUND,
	"ROUNDSTART" = STORY_TAG_ROUNDSTART,
))

// Goals statuses in planning tree for external use
#define STORY_GOAL_PENDING "goal_pending"
#define STORY_GOAL_FIRING "goal_firing"
#define STORY_GOAL_COMPLETED "goal_completed"
#define STORY_GOAL_FAILED "goal_failed"

// Core storyteller pacing and difficulty constants
#define STORY_THINK_BASE_DELAY (2 MINUTES)          // Base delay between thinker cycles
#define STORY_MIN_EVENT_INTERVAL (30 SECONDS)       // Minimum time between events
#define STORY_MAX_EVENT_INTERVAL (20 MINUTES)       // Maximum time between events
#define STORY_DEFAULT_PLAYER_ANTAG_BALANCE 50       // Default balance target (0-100, 50 = balanced)

// Threat/adaptation constants
#define STORY_THREAT_GROWTH_RATE 1.0                // How fast threat points accumulate
#define STORY_ADAPTATION_DECAY_RATE 0.05            // Rate of adaptation decay per cycle
#define STORY_RECENT_DAMAGE_THRESHOLD 20            // Damage threshold for triggering adaptation
#define STORY_TARGET_TENSION 50                     // Target tension level (0-100)
#define STORY_GRACE_PERIOD (10 MINUTES)             // Cooldown after major events
#define STORY_MAX_THREAT_SCALE 100.0                // Maximum threat scale (max 10000 points)
#define STORY_REPETITION_PENALTY 0.5                // Penalty multiplier for repeated events
#define STORY_DIFFICULTY_MULTIPLIER 1.0             // Base difficulty multiplier

// Planner constants
#define STORY_RECALC_INTERVAL (10 MINUTES)          // Interval for plan recalculation
#define STORY_INITIAL_GOALS_COUNT 2                	// Minimum pending goals in timeline
#define STORY_PICK_THREAT_BONUS_SCALE 0.01          // Threat bonus scaling for goal selection
#define STORY_BALANCE_BONUS 1.5                     // Balance adjustment bonus multiplier
#define STORY_PACE_MIN 0.1                          // Minimum pace multiplier
#define STORY_PACE_MAX 3.0                          // Maximum pace multiplier

// Balancer constants
#define STORY_BALANCER_PLAYER_WEIGHT 1.0            // Base weight per player
#define STORY_BALANCER_ANTAG_WEIGHT 2.0            // Base weight per antagonist
#define STORY_BALANCER_WEAK_ANTAG_THRESHOLD 0.5    // Threshold for "weak antags" (0-1)
#define STORY_BALANCER_INACTIVE_ACTIVITY_THRESHOLD 0.25  // Threshold for inactive antags (0-1)
#define STORY_STATION_STRENGTH_MULTIPLIER 1.0       // Station strength multiplier
#define STORY_MAX_TENSION_BONUS 30                  // Maximum tension bonus from events
#define STORY_TENSION_BONUS_DECAY_RATE 1           // Tension bonus decay per cycle

// Metric thresholds (scaling factors for activity calculations)
#define STORY_INACTIVITY_ACT_INDEX_THRESHOLD 0.15  // Threshold for inactive activity index
#define STORY_ACTIVITY_CREW_SCALE 0.1              // Crew activity scaling factor
#define STORY_DAMAGE_SCALE 100                     // Damage scaling divisor
#define STORY_ACTIVITY_TIME_SCALE 10               // Time-based activity scaling
#define STORY_DISRUPTION_SCALE 10                  // Disruption scaling divisor
#define STORY_INFLUENCE_SCALE 5                    // Influence scaling divisor
#define STORY_KILLS_CAP 3                          // Maximum kills value (0-3)
#define STORY_OBJECTIVES_CAP 4                     // Maximum objectives value (0-4)

// Round progression tuning (target: ~3 hours average round, 60-80 players)
#define STORY_ROUND_PROGRESSION_TRESHOLD (2 HOURS)  // Time for 100% progression

// Threat point thresholds (for event intensity scaling)
#define STORY_THREAT_LOW 100                       // Low threat threshold
#define STORY_THREAT_MODERATE 500                  // Moderate threat threshold
#define STORY_THREAT_HIGH 2000                     // High threat threshold
#define STORY_THREAT_EXTREME 5000                  // Extreme threat threshold
#define STORY_THREAT_APOCALYPTIC 10000             // Apocalyptic threat threshold

#define STORY_INVERTED_THREAT_POINTS(TP) (max(STORY_THREAT_APOCALYPTIC - (TP), 0))


// Converts threat points to good points for good event scaling
#define STORY_GOOD_POINTS(TP) (STORY_INVERTED_THREAT_POINTS(TP))

#define STORY_GOOD_EXTREME 0                   // Extreme good threshold (low threat)
#define STORY_GOOD_HIGH 2000                   // High good threshold
#define STORY_GOOD_MODERATE 5000               // Moderate good threshold
#define STORY_GOOD_LOW 7000                    // Low good threshold
#define STORY_GOOD_MINIMAL 9000

#define STORY_USEFULNESS_LEVEL(TP) ( \
	(TP) <= STORY_GOOD_EXTREME ? 5 : \
	(TP) <= STORY_GOOD_HIGH ? 4 : \
	(TP) <= STORY_GOOD_MODERATE ? 3 : \
	(TP) <= STORY_GOOD_LOW ? 2 : \
	1 \
)
