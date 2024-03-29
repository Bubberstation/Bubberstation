///Uncomment this to enable testing of Bloodsucker features (such as vassalizing people with a mind instead of a client).
// #define BLOODSUCKER_TESTING

/// You have special interactions with Bloodsuckers
#define TRAIT_BLOODSUCKER_HUNTER "bloodsucker_hunter"

// how much to multiply the coffin size by mob_size
#define COFFIN_ENLARGE_MULT 0.5
/**
 * Blood-level defines
 */
/// Determines Bloodsucker regeneration rate
#define BS_BLOOD_VOLUME_MAX_REGEN 700
/// Cost to torture someone halfway, in blood. Called twice for full cost
#define TORTURE_BLOOD_HALF_COST 4
/// Cost to convert someone after successful torture, in blood
#define TORTURE_CONVERSION_COST 10
/// How much blood it costs you to make a vassal into a special vassal
#define SPECIAL_VASSAL_COST 150
/// Once blood is this low, will enter Frenzy
#define FRENZY_THRESHOLD_ENTER 25
/// Once blood is this high, will exit Frenzy
#define FRENZY_THRESHOLD_EXIT 250

/// a bloodsucker can't loose more humanity than this, and looses the masquerade ability when reaching it
#define HUMANITY_LOST_MAXIMUM 50

/// Level up blood cost define, max_blood * this = blood cost
#define BLOODSUCKER_LEVELUP_PERCENTAGE 0.15

///The level when at a bloodsucker becomes snobby about who they drink from and gain their non-fledling reputation
#define BLOODSUCKER_HIGH_LEVEL 4

/**
 * Sol defines
 */
///How long Sol will last until it's night again.
#define TIME_BLOODSUCKER_DAY 60
///Base time nighttime should be in for, until Sol rises.
// Can't put defines in defines, so we have to use deciseconds.
#define TIME_BLOODSUCKER_NIGHT_MAX 1320 // 22 minutes
#define TIME_BLOODSUCKER_NIGHT_MIN 1020 // 17 minutes

///Time left to send an alert to Bloodsuckers about an incoming Sol.
#define TIME_BLOODSUCKER_DAY_WARN 90
///Time left to send an urgent alert to Bloodsuckers about an incoming Sol.
#define TIME_BLOODSUCKER_DAY_FINAL_WARN 30
///Time left to alert that Sol is rising.
#define TIME_BLOODSUCKER_BURN_INTERVAL 5

///How much time Sol can be 'off' by, keeping the time inconsistent.
#define TIME_BLOODSUCKER_SOL_DELAY 90

/**
 * Vassal defines
 */
///If someone passes all checks and can be vassalized
#define VASSALIZATION_ALLOWED 0
///If someone has to accept vassalization
#define VASSALIZATION_DISLOYAL 1
///If someone is not allowed under any circimstances to become a Vassal
#define VASSALIZATION_BANNED 2

/**
 * Cooldown defines
 * Used in Cooldowns Bloodsuckers use to prevent spamming
 */
///Spam prevention for healing messages.
#define BLOODSUCKER_SPAM_HEALING (15 SECONDS)
///Span prevention for Sol Masquerade messages.
#define BLOODSUCKER_SPAM_MASQUERADE (60 SECONDS)

///Span prevention for Sol messages.
#define BLOODSUCKER_SPAM_SOL (30 SECONDS)

/**
 * Clan defines
 */
#define CLAN_NONE "Caitiff"
#define CLAN_BRUJAH "Brujah Clan"
#define CLAN_TOREADOR "Toreador Clan"
#define CLAN_NOSFERATU "Nosferatu Clan"
#define CLAN_TREMERE "Tremere Clan"
#define CLAN_GANGREL "Gangrel Clan"
#define CLAN_VENTRUE "Ventrue Clan"
#define CLAN_MALKAVIAN "Malkavian Clan"
#define CLAN_TZIMISCE "Tzimisce Clan"

#define TREMERE_VASSAL "tremere_vassal"
#define FAVORITE_VASSAL "favorite_vassal"
#define REVENGE_VASSAL "revenge_vassal"

/**
 * Power defines
 */
/// This Power can't be used in Torpor
#define BP_CANT_USE_IN_TORPOR (1<<0)
/// This Power can't be used while transformed, for example by the shapeshift spell
#define BP_CAN_USE_TRANSFORMED (1<<1)
/// This Power can't be used in Frenzy.
#define BP_CANT_USE_IN_FRENZY (1<<2)
/// This Power can't be used with a stake in you
#define BP_CAN_USE_WHILE_STAKED (1<<3)
/// This Power can't be used while incapacitated
#define BP_CANT_USE_WHILE_INCAPACITATED (1<<4)
/// This Power can't be used while unconscious
#define BP_CANT_USE_WHILE_UNCONSCIOUS (1<<5)

/// This Power can be purchased by Bloodsuckers
#define BLOODSUCKER_CAN_BUY (1<<0)
/// This is a Default Power that all Bloodsuckers get.
#define BLOODSUCKER_DEFAULT_POWER (1<<1)
/// This Power can be purchased by Tremere Bloodsuckers
#define TREMERE_CAN_BUY (1<<2)
/// This Power can be purchased by Vassals
#define VASSAL_CAN_BUY (1<<3)

/// This Power is a Toggled Power
#define BP_AM_TOGGLE (1<<0)
/// This Power is a Single-Use Power
#define BP_AM_SINGLEUSE (1<<1)
/// This Power has a Static cooldown
#define BP_AM_STATIC_COOLDOWN (1<<2)
/// This Power doesn't cost bloot to run while unconscious
#define BP_AM_COSTLESS_UNCONSCIOUS (1<<3)

/**
 * Torpor check bitflags
 */
#define TORPOR_SKIP_CHECK_ALL (1<<0)
#define TORPOR_SKIP_CHECK_FRENZY (1<<1)
#define TORPOR_SKIP_CHECK_DAMAGE (1<<2)

/**
 * Bloodsucker Signals
 */
///Called when a Bloodsucker ranks up: (datum/bloodsucker_datum, mob/owner, mob/target)
#define BLOODSUCKER_RANK_UP "bloodsucker_rank_up"
///Called when a Bloodsucker interacts with a Vassal on their persuasion rack.
#define BLOODSUCKER_INTERACT_WITH_VASSAL "bloodsucker_interact_with_vassal"
///Called when a Bloodsucker makes a Vassal into their Favorite Vassal: (datum/vassal_datum, mob/master)
#define BLOODSUCKER_MAKE_FAVORITE "bloodsucker_make_favorite"
// called when a bloodsucker looses their favorite vassal, cleaning up whatever they gained
#define BLOODSUCKER_LOOSE_FAVORITE "bloodsucker_loose_favorite"
///Called when a new Vassal is successfully made: (datum/bloodsucker_datum)
#define BLOODSUCKER_MADE_VASSAL "bloodsucker_made_vassal"
///Called when a Bloodsucker exits Torpor.
#define BLOODSUCKER_EXIT_TORPOR "bloodsucker_exit_torpor"
///Called when a Bloodsucker reaches Final Death.
#define BLOODSUCKER_FINAL_DEATH "bloodsucker_final_death"
	///Whether the Bloodsucker should not be dusted when arriving Final Death
	#define DONT_DUST (1<<0)
///Called when a Bloodsucker breaks the Masquerade
#define COMSIG_BLOODSUCKER_BROKE_MASQUERADE "comsig_bloodsucker_broke_masquerade"
///Called when a Bloodsucker enters Frenzy
#define BLOODSUCKER_ENTERS_FRENZY "bloodsucker_enters_frenzy"
///Called when a Bloodsucker exits Frenzy
#define BLOODSUCKER_EXITS_FRENZY "bloodsucker_exits_frenzy"
// Called when anyone enters the coffin
#define COMSIG_ENTER_COFFIN "comsig_enter_coffin"

/**
 * Sol signals & Defines
 */
#define COMSIG_SOL_RANKUP_BLOODSUCKERS "comsig_sol_rankup_bloodsuckers"
#define COMSIG_SOL_RISE_TICK "comsig_sol_rise_tick"
#define COMSIG_SOL_NEAR_START "comsig_sol_near_start"
#define COMSIG_SOL_END "comsig_sol_end"
///Sent when a warning for Sol is meant to go out: (danger_level, vampire_warning_message, vassal_warning_message)
#define COMSIG_SOL_WARNING_GIVEN "comsig_sol_warning_given"
///Called on a Bloodsucker's Lifetick.
#define COMSIG_BLOODSUCKER_ON_LIFETICK "comsig_bloodsucker_on_lifetick"

#define DANGER_LEVEL_FIRST_WARNING 1
#define DANGER_LEVEL_SECOND_WARNING 2
#define DANGER_LEVEL_THIRD_WARNING 3
#define DANGER_LEVEL_SOL_ROSE 4
#define DANGER_LEVEL_SOL_ENDED 5

/**
 * Clan defines
 *
 * This is stuff that is used solely by Clans for clan-related activity.
 */
///Drinks blood the normal Bloodsucker way.
#define BLOODSUCKER_DRINK_NORMAL "bloodsucker_drink_normal"
///Drinks blood but is snobby, refusing to drink from mindless
#define BLOODSUCKER_DRINK_SNOBBY "bloodsucker_drink_snobby"
///Drinks blood from disgusting creatures without Humanity consequences.
#define BLOODSUCKER_DRINK_INHUMANELY "bloodsucker_drink_inhumanely"

/**
 * Traits
 */
/// Falsifies Health analyzer blood levels
#define TRAIT_MASQUERADE "masquerade"
/// Your body is literal room temperature. Does not make you immune to the temp
#define TRAIT_COLDBLOODED "coldblooded"

/**
 * Sources
 */
/// Source trait for Bloodsuckers-related traits
#define BLOODSUCKER_TRAIT "bloodsucker_trait"

#define VASSAL_TRAIT "vassal_trait"

/// Source trait for dominate related traits
#define DOMINATE_TRAIT "dominate_trait"

/// Source trait for Monster Hunter-related traits
#define HUNTER_TRAIT "monsterhunter_trait"
/// Source trait while Feeding
#define FEED_TRAIT "feed_trait"
/// Source trait during a Frenzy
#define FRENZY_TRAIT "frenzy_trait"

///Whether a mob is a Bloodsucker
#define IS_BLOODSUCKER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/bloodsucker))
///Whether a mob is a Vassal
#define IS_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal))
///Whether a mob is a Favorite Vassal
#define IS_FAVORITE_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal/favorite))
///Whether a mob is a Revenge Vassal
#define IS_REVENGE_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal/revenge))

///Whether a mob is a Monster Hunter-NOT NEEDED RIGHT NOW
// #define IS_MONSTERHUNTER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/monsterhunter))
///For future use
#define IS_MONSTERHUNTER(mob) (FALSE)

#define BLOODSUCKER_SIGHT_COLOR_CUTOFF list(25, 8, 5)
#define POLL_IGNORE_VASSAL "vassal"

// Why waste memory on a dynamic global list if we can just bake it in on compile time?
#define BLOODSUCKER_PROTECTED_ROLES list( \
	JOB_CAPTAIN, \
	JOB_HEAD_OF_PERSONNEL, \
	JOB_HEAD_OF_SECURITY, \
	JOB_WARDEN, \
	JOB_SECURITY_OFFICER, \
	JOB_DETECTIVE, \
) \

#define BLOODSUCKER_RESTRICTED_ROLES list( \
	JOB_AI, \
	JOB_CYBORG, \
	JOB_CURATOR, \
) \

#define BLOODSUCKER_RESTRICTED_SPECIES list( \
	/datum/species/synthetic, \
	/datum/species/plasmaman, \
	/datum/species/shadow/nightmare, \
	/datum/species/abductor, \
	/datum/species/android, \
	/datum/species/golem, \
	/datum/species/shadow, \
	/datum/species/skeleton, \
	/datum/species/zombie, \
	/datum/species/mutant, \
	/datum/species/dullahan \
) \
