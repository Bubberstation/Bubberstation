/// Uncomment this to enable testing of Vampire features (such as vassalizing people with a mind instead of a client).
//#define VAMPIRE_TESTING
#if defined(VAMPIRE_TESTING) && defined(CIBUILDING)
	#error VAMPIRE_TESTING is enabled, disable this!
#endif

// Blood-level defines
/// Determines Vampire regeneration rate
#define BS_BLOOD_VOLUME_MAX_REGEN 700
/// The most vitae a vassal can hold. One drink from their master fills it.
#define VASSAL_VITAE_MAX 150
/// Once blood is this low, will enter a Frenzy
#define FRENZY_THRESHOLD_ENTER 25
/// Once blood is this high, will exit the Frenzy. Intentionally high, we want to kill the person we feed off of
#define FRENZY_THRESHOLD_EXIT 500
/// How much blood drained from the vampire each lifetick
#define VAMPIRE_PASSIVE_BLOOD_DRAIN 0.1
/// The number that incoming levels are divided by when comitting the Amaranth. Example: 2 would divide the victims level by 2, and give that to the diablerist
#define DIABLERIE_DIVISOR 1.5
/// Amount of vitae drunk from another player required to level up.
#define VITAE_GOAL_STANDARD 250

/// Default amount of damage the vampire's punch/kick damage increases with each level.
#define VAMPIRE_UNARMED_DMG_INCREASE_ON_RANKUP 0.5

/// How many starting levels do we want each one to have?
#define VAMPIRE_STARTING_LEVELS 3
/// How many free levels the vampire gets gradually.
#define VAMPIRE_FREE_LEVELS 3
/// Vampire's default stamina resist.
#define VAMPIRE_INHERENT_STAMINA_RESIST 0.75

/// When do we warn them about their low blood?
#define VAMPIRE_LOW_BLOOD_WARNING 300

/// Lumcount above which costs_double_in_light powers pay double
#define SHADOW_SPECIES_BRIGHT_LIGHT 0.6

/// Seconds in the life tick the PR's per-tick costs were balanced around
#define VAMPIRE_LIFE_TICK_SECONDS 2

// how much to multiply the coffin size by mob_size
#define COFFIN_ENLARGE_MULT 0.5

// Humanity gains (The actual tracking lists and such are in the datum duh)
// These are supposed to be somewhat nontrivial, to the point of sometimes not being viable.
/// Hugging of separate people
#define HUMANITY_HUGGING_TYPE "hug"
/// Petting of separate animals
#define HUMANITY_PETTING_TYPE "pet"
/// Watching of art
#define HUMANITY_ART_TYPE "art"

#define HUMANITY_GAIN_TYPES list(HUMANITY_HUGGING_TYPE, HUMANITY_PETTING_TYPE, HUMANITY_ART_TYPE)

/// Starting Humanity
#define VAMPIRE_DEFAULT_HUMANITY 7
/// Below this humanity a vampire has no Blush of Life, looks deathly pale, and is fair game for hunters, chaplains and royalty
#define VAMPIRE_LOW_HUMANITY 7
/// At or below this humanity the deathly pale look shows from any distance, and the chapel burns them
#define VAMPIRE_HUMANITY_MONSTROUS 2

// Cooldown defines
/// Spam prevention for healing messages.
#define VAMPIRE_SPAM_HEALING (15 SECONDS)
#define VAMPIRE_SPAM_BLUSH_OF_LIFE (60 SECONDS)

/// Shared cooldown group for the disabling mind powers (Summon, Entrancement, Mesmerize)
#define VAMPIRE_SHARED_COOLDOWN_MIND (1<<10)

// Clan defines
#define CLAN_BRUJAH "Brujah Clan"
#define CLAN_TOREADOR "Toreador Clan"
#define CLAN_NOSFERATU "Nosferatu Clan"
#define CLAN_TREMERE "Tremere Clan"
#define CLAN_GANGREL "Gangrel Clan"
#define CLAN_VENTRUE "Ventrue Clan"
#define CLAN_MALKAVIAN "Malkavian Clan"
#define CLAN_TZIMISCE "Tzimisce Clan"
#define CLAN_HECATA "Hecata Clan"
#define CLAN_LASOMBRA "Lasombra Clan"

// Power defines, for vampire_check_flags. Consciousness, incapacitation and phasing use the action's check_flags.
/// This Power can't be used in Torpor
#define BP_CANT_USE_IN_TORPOR (1<<0)
/// This Power can't be used in Frenzy.
#define BP_CANT_USE_IN_FRENZY (1<<1)
/// This Power can't be used with a stake in you
#define BP_CANT_USE_WHILE_STAKED (1<<2)

/// This Power can be used by a vampire with no heart
#define BP_CAN_USE_HEARTLESS (1<<3)

/// This is a Default Power that all Vampires get.
#define VAMPIRE_DEFAULT_POWER (1<<1)

// For vampire_power_flags
/// This Power is a Toggled Power
#define BP_AM_TOGGLE (1<<0)
/// This Power is a Single-Use Power
#define BP_AM_SINGLEUSE (1<<1)
/// This Power has a Static cooldown
#define BP_AM_STATIC_COOLDOWN (1<<2)
/// This Power doesn't cost bloot to run while unconscious
#define BP_AM_COSTLESS_UNCONSCIOUS (1<<3)
/// This Power has a cooldown that is more dynamic than a typical power
#define BP_AM_VERY_DYNAMIC_COOLDOWN (1<<4)

// Signals
///Called when a Vampire reaches Final Death.
#define COMSIG_VAMPIRE_FINAL_DEATH "vampire_final_death"
	///Whether the vampire should not be dusted when arriving Final Death
	#define DONT_DUST (1<<0)
/// Sent whenever vampires get a "natural" rank up.
#define COMSIG_SOL_RANKUP_VAMPIRES "sol_rankup_vampires"
/// Sent when tracking humanity gain progress: (type, subject)
#define COMSIG_VAMPIRE_TRACK_HUMANITY_GAIN "comsig_vampire_track_humanity_gain"
/// Called on the mind when a Vampire chooses a clan: (datum/antagonist/vampire, datum/vampire_clan)
#define COMSIG_VAMPIRE_CLAN_CHOSEN "vampire_clan_chosen"
/// Called on the vampire datum when it enters Frenzy
#define COMSIG_VAMPIRE_ENTERS_FRENZY "vampire_enters_frenzy"
/// Called on the vampire datum when it exits Frenzy
#define COMSIG_VAMPIRE_EXITS_FRENZY "vampire_exits_frenzy"
/// From petting a basic or simple animal: (mob/living/pet)
#define COMSIG_LIVING_PET_ANIMAL "living_pet_animal"
/// From hugging or headpatting a carbon: (mob/living/carbon/hugged)
#define COMSIG_LIVING_HUG_CARBON "living_hug_carbon"
/// From /datum/element/art when appraising art: (atom/art_piece)
#define COMSIG_LIVING_APPRAISE_ART "living_appraise_art"

// Clan drinking defines
/// Drinks blood the normal Vampire way.
#define VAMPIRE_DRINK_NORMAL "vampire_drink_normal"
/// Drinks blood but is snobby, refusing to drink from mindless
#define VAMPIRE_DRINK_SNOBBY "vampire_drink_snobby"

// Traits
/// Falsifies Health analyzer blood levels
#define TRAIT_BLUSH_OF_LIFE "blush_of_life"
/// For people in the middle of being staked
#define TRAIT_BEINGSTAKED "beingstaked"
/// This vampire is currently in a frenzy,
#define TRAIT_FRENZY "frenzy"
/// This vampire can tell if another vampire has committed diablere on examine.
#define TRAIT_SEE_DIABLERIE "see_diablerie"
/// Hides TRAIT_GENELESS if it's only from the same sources as TRAIT_FAKEGENES.
#define TRAIT_FAKEGENES "fakegenes"
/// Mind trait: You have special interactions with vampires and the occult.
#define TRAIT_OCCULTIST "occultist"
/// Mind trait: a vampire or vassal. Check `HAS_MIND_TRAIT(user, TRAIT_VAMPIRE_ALIGNED)` instead of `IS_VAMPIRE(user) || IS_VASSAL(user)`
#define TRAIT_VAMPIRE_ALIGNED "vampire_aligned"

// Trait sources
/// Source trait for all vampire traits
#define TRAIT_VAMPIRE "trait_vampire"
/// Source trait while Feeding
#define FEED_TRAIT "feed_trait"

// Misc
#define FACTION_VAMPIRE "Vampire"
#define LANGUAGE_VAMPIRE "vampire"
#define LANGUAGE_VASSAL "vassal"
#define CAT_VAMPIRE "Vampire"
#define DOAFTER_SOURCE_ARCHIVE_OF_THE_KINDRED "doafter_archive_of_the_kindred"
#define DOAFTER_SOURCE_PERSUASION_RACK "doafter_persuasion_rack"
#define LOG_CATEGORY_UPLINK_VAMPIRE "uplink-vampire"
#define POLL_IGNORE_VASSAL "vassal"

#define span_awe(str) ("<span class='awe'>" + str + "</span>")
#define span_vampire_master(str) ("<span class='vampire_master'>" + str + "</span>")

// Macros
/// Checks if the given mob is a vampire
#define IS_VAMPIRE(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vampire))
/// Checks if the given mob is a vassal
#define IS_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal))
#define IS_CURATOR(mob) istype(mob?.mind?.assigned_role, /datum/job/curator)
/// Monster hunters aren't ported
#define IS_MONSTERHUNTER(mob) (FALSE)
#define IS_VAMPIRE_HUNTER(mob) (IS_CURATOR(mob) || IS_MONSTERHUNTER(mob))

#define VAMPIRE_SIGHT_COLOR_CUTOFF list(25, 8, 5)

#define VAMPIRE_BLACKLISTED_ROLES list( \
	JOB_CAPTAIN, \
	JOB_HEAD_OF_PERSONNEL, \
	JOB_HEAD_OF_SECURITY, \
	JOB_WARDEN, \
	JOB_SECURITY_OFFICER, \
	JOB_DETECTIVE, \
)

#define VAMPIRE_RESTRICTED_SPECIES list( \
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
)
