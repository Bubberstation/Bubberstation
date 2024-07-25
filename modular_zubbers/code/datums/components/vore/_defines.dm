/// Key used for versioning savefiles
#define VORE_DB_REPO "bubber_vore"
/// Value used for versioning savefiles
#define VORE_DB_VERSION "1.0"
/// Key used for belly versioning independent of savefile version
#define VORE_BELLY_KEY "version"
/// Value used for belly versioning independent of savefile version
#define VORE_BELLY_VERSION "1.0"
/// Maximum amount of bellies allowed within one layout
#define MAX_BELLIES 10
/// Maximum amount of prey that can be eaten at once
#define MAX_PREY 3
/// Amount of time it takes for players to eat someone
#define VORE_DELAY 1 SECONDS // TODO: Change to 30 SECONDS
/// Amount of time it takes for players to resist-squirm out of a belly
#define RESIST_ESCAPE_DELAY 15 SECONDS // TODO: find something to change this to
/// If true, prevents people with prey inside them from being eaten
#define MATRYOSHKA_BANNED FALSE // TODO: Change this
/// If true, automatically disables sensors when prey is eaten
#define DISABLES_SENSORS TRUE
/// If true, prevents mobs in crit or death from engaging in vore
#define NO_DEAD TRUE
/// If true, mobs with no player cannot be pred or prey
#define REQUIRES_PLAYER FALSE // TODO: Change this
/// Makes every mob spawn with a vore component, just for testing
#define VORE_TESTING_ALL_MOBS_ARE_VORE_MOBS
/// Number of rolling backups bellies will keep
#define BELLY_BACKUP_COUNT 5
/// Maximum number of belly layout slots
#define MAX_BELLY_LAYOUTS 20
/// Rate limit on belly creation, as it can get a little expensive
#define BELLY_CREATION_COOLDOWN 2 SECONDS

#define TRAIT_SOURCE_VORE "vore"

#define DIGEST_MODE_NONE "None"
#define DIGEST_MODE_DIGEST "Digest"

/// Max burn damage a player is allowed to set their belly to
#define MAX_BURN_DAMAGE 2.5
/// Max brute damage a player is allowed to set their belly to
#define MAX_BRUTE_DAMAGE 2.5

/// Amount of nutrition given per point of damage dealt
#define NUTRITION_PER_DAMAGE 2
/// Amount of nutrition given when digesting something fully
#define NUTRITION_PER_KILL 50

#define DIGESTION_NOISE_COOLDOWN 10 SECONDS

#define PREF_TRINARY_NEVER 0
#define PREF_TRINARY_PROMPT 1
#define PREF_TRINARY_ALWAYS 2

#define CHANNEL_PREYLOOP 1004
#define COOLDOWN_PREYLOOP "preyloop"

/// What types of mobs are allowed to participate in vore at all?
/// This controls whether vore components are added on any mob Login for vore-enabled clients
GLOBAL_LIST_INIT(vore_allowed_mob_types, typecacheof(list(
	/mob/living
	// TODO: Change to
	// /mob/living/carbon/human,
	// /mob/living/silicon/robot
)))

/// List of types that will be automatically ejected from prey when they enter a belly
GLOBAL_LIST_INIT(vore_blacklist_types, list(
	/obj/item/disk/nuclear,
))

// Belly Planet! Used to return always-safe air to prey.
/datum/gas_mixture/immutable/planetary/belly
GLOBAL_DATUM_INIT(belly_air, /datum/gas_mixture/immutable/planetary, init_belly_air())
/proc/init_belly_air()
	var/datum/gas_mixture/immutable/planetary/belly_air = new()
	belly_air.parse_string_immutable(OPENTURF_DEFAULT_ATMOS)
	return belly_air

GLOBAL_LIST_INIT(vore_sounds_slosh, list(
	'modular_zubbers/sound/vore/walkslosh1.ogg',
	'modular_zubbers/sound/vore/walkslosh2.ogg',
	'modular_zubbers/sound/vore/walkslosh3.ogg',
	'modular_zubbers/sound/vore/walkslosh4.ogg',
	'modular_zubbers/sound/vore/walkslosh5.ogg',
	'modular_zubbers/sound/vore/walkslosh6.ogg',
	'modular_zubbers/sound/vore/walkslosh7.ogg',
	'modular_zubbers/sound/vore/walkslosh8.ogg',
	'modular_zubbers/sound/vore/walkslosh9.ogg',
	'modular_zubbers/sound/vore/walkslosh10.ogg'
))

//Classic Vore sounds
GLOBAL_LIST_INIT(vore_sounds_insert_classic, list(
	"Gulp" = 'modular_zubbers/sound/vore/gulp.ogg',
	"Insert" = 'modular_zubbers/sound/vore/insert.ogg',
	"Insertion1" = 'modular_zubbers/sound/vore/insertion1.ogg',
	"Insertion2" = 'modular_zubbers/sound/vore/insertion2.ogg',
	"Insertion3" = 'modular_zubbers/sound/vore/insertion3.ogg',
	"Schlorp" = 'modular_zubbers/sound/vore/schlorp.ogg',
	"Squish1" = 'modular_zubbers/sound/vore/squish1.ogg',
	"Squish2" = 'modular_zubbers/sound/vore/squish2.ogg',
	"Squish3" = 'modular_zubbers/sound/vore/squish3.ogg',
	"Squish4" = 'modular_zubbers/sound/vore/squish4.ogg',
	"Rustle (cloth)" = 'sound/effects/rustle1.ogg',
	"Rustle 2 (cloth)"	= 'sound/effects/rustle2.ogg',
	"Rustle 3 (cloth)"	= 'sound/effects/rustle3.ogg',
	"Rustle 4 (cloth)"	= 'sound/effects/rustle4.ogg',
	"Rustle 5 (cloth)"	= 'sound/effects/rustle5.ogg',
	"Zipper" = 'sound/items/zip.ogg',
	"None" = null
))

GLOBAL_LIST_INIT(vore_sounds_release_classic, list(
	"Rustle (cloth)" = 'sound/effects/rustle1.ogg',
	"Rustle 2 (cloth)" = 'sound/effects/rustle2.ogg',
	"Rustle 3 (cloth)" = 'sound/effects/rustle3.ogg',
	"Rustle 4 (cloth)" = 'sound/effects/rustle4.ogg',
	"Rustle 5 (cloth)" = 'sound/effects/rustle5.ogg',
	"Zipper" = 'sound/items/zip.ogg',
	"Splatter" = 'sound/effects/splat.ogg',
	"None" = null
))

//Poojy's Fancy Sounds
GLOBAL_LIST_INIT(vore_sounds_insert_fancy, list(
	"Gulp" = 'modular_zubbers/sound/vore/sunesound/pred/swallow_01.ogg',
	"Swallow" = 'modular_zubbers/sound/vore/sunesound/pred/swallow_02.ogg',
	"Insertion1" = 'modular_zubbers/sound/vore/sunesound/pred/insertion_01.ogg',
	"Insertion2" = 'modular_zubbers/sound/vore/sunesound/pred/insertion_02.ogg',
	"Tauric Swallow" = 'modular_zubbers/sound/vore/sunesound/pred/taurswallow.ogg',
	"Stomach Move" = 'modular_zubbers/sound/vore/sunesound/pred/stomachmove.ogg',
	"Schlorp" = 'modular_zubbers/sound/vore/sunesound/pred/schlorp.ogg',
	"Squish1" = 'modular_zubbers/sound/vore/sunesound/pred/squish_01.ogg',
	"Squish2" = 'modular_zubbers/sound/vore/sunesound/pred/squish_02.ogg',
	"Squish3" = 'modular_zubbers/sound/vore/sunesound/pred/squish_03.ogg',
	"Squish4" = 'modular_zubbers/sound/vore/sunesound/pred/squish_04.ogg',
	"Rustle (cloth)" = 'sound/effects/rustle1.ogg',
	"Rustle 2 (cloth)" = 'sound/effects/rustle2.ogg',
	"Rustle 3 (cloth)" = 'sound/effects/rustle3.ogg',
	"Rustle 4 (cloth)" = 'sound/effects/rustle4.ogg',
	"Rustle 5 (cloth)" = 'sound/effects/rustle5.ogg',
	"Zipper" = 'sound/items/zip.ogg',
	"None" = null
))

GLOBAL_LIST_INIT(vore_sounds_release_fancy, list(
	"Rustle (cloth)" = 'sound/effects/rustle1.ogg',
	"Rustle 2 (cloth)" = 'sound/effects/rustle2.ogg',
	"Rustle 3 (cloth)" = 'sound/effects/rustle3.ogg',
	"Rustle 4 (cloth)" = 'sound/effects/rustle4.ogg',
	"Rustle 5 (cloth)" = 'sound/effects/rustle5.ogg',
	"Zipper" = 'sound/items/zip.ogg',
	"Stomach Move" = 'modular_zubbers/sound/vore/sunesound/pred/stomachmove.ogg',
	"Pred Escape" = 'modular_zubbers/sound/vore/sunesound/pred/escape.ogg',
	"Splatter" = 'sound/effects/splat.ogg',
	"None" = null
))

GLOBAL_LIST_INIT(vore_sounds_hunger, list(
	'modular_zubbers/sound/vore/growl1.ogg', 'modular_zubbers/sound/vore/growl2.ogg', 'modular_zubbers/sound/vore/growl3.ogg',
	'modular_zubbers/sound/vore/growl4.ogg', 'modular_zubbers/sound/vore/growl5.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_digestion_classic, list(
	'modular_zubbers/sound/vore/digest1.ogg', 'modular_zubbers/sound/vore/digest2.ogg', 'modular_zubbers/sound/vore/digest3.ogg', 'modular_zubbers/sound/vore/digest4.ogg',
	'modular_zubbers/sound/vore/digest5.ogg', 'modular_zubbers/sound/vore/digest6.ogg', 'modular_zubbers/sound/vore/digest7.ogg', 'modular_zubbers/sound/vore/digest8.ogg',
	'modular_zubbers/sound/vore/digest9.ogg', 'modular_zubbers/sound/vore/digest10.ogg', 'modular_zubbers/sound/vore/digest11.ogg', 'modular_zubbers/sound/vore/digest12.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_death_classic, list(
	'modular_zubbers/sound/vore/death1.ogg', 'modular_zubbers/sound/vore/death2.ogg', 'modular_zubbers/sound/vore/death3.ogg', 'modular_zubbers/sound/vore/death4.ogg',
	'modular_zubbers/sound/vore/death5.ogg', 'modular_zubbers/sound/vore/death6.ogg', 'modular_zubbers/sound/vore/death7.ogg', 'modular_zubbers/sound/vore/death8.ogg',
	'modular_zubbers/sound/vore/death9.ogg', 'modular_zubbers/sound/vore/death10.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_struggle_classic, list(
	'modular_zubbers/sound/vore/squish1.ogg', 'modular_zubbers/sound/vore/squish2.ogg', 'modular_zubbers/sound/vore/squish3.ogg', 'modular_zubbers/sound/vore/squish4.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_struggle_fancy, list(
	'modular_zubbers/sound/vore/sunesound/prey/struggle_01.ogg', 'modular_zubbers/sound/vore/sunesound/prey/struggle_02.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/struggle_03.ogg', 'modular_zubbers/sound/vore/sunesound/prey/struggle_04.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/struggle_05.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_digestion_fancy, list(
	'modular_zubbers/sound/vore/sunesound/pred/digest_01.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_02.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_03.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/digest_04.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_05.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_06.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/digest_07.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_08.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_09.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/digest_10.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_11.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_12.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/digest_13.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_14.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_15.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/digest_16.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_17.ogg','modular_zubbers/sound/vore/sunesound/pred/digest_18.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_death_fancy, list(
	'modular_zubbers/sound/vore/sunesound/pred/death_01.ogg','modular_zubbers/sound/vore/sunesound/pred/death_02.ogg','modular_zubbers/sound/vore/sunesound/pred/death_03.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/death_04.ogg','modular_zubbers/sound/vore/sunesound/pred/death_05.ogg','modular_zubbers/sound/vore/sunesound/pred/death_06.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/death_07.ogg','modular_zubbers/sound/vore/sunesound/pred/death_08.ogg','modular_zubbers/sound/vore/sunesound/pred/death_09.ogg',
	'modular_zubbers/sound/vore/sunesound/pred/death_10.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_digestion_fancy_prey, list(
	'modular_zubbers/sound/vore/sunesound/prey/digest_01.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_02.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_03.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/digest_04.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_05.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_06.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/digest_07.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_08.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_09.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/digest_10.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_11.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_12.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/digest_13.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_14.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_15.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/digest_16.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_17.ogg','modular_zubbers/sound/vore/sunesound/prey/digest_18.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_death_fancy_prey, list(
	'modular_zubbers/sound/vore/sunesound/prey/death_01.ogg','modular_zubbers/sound/vore/sunesound/prey/death_02.ogg','modular_zubbers/sound/vore/sunesound/prey/death_03.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/death_04.ogg','modular_zubbers/sound/vore/sunesound/prey/death_05.ogg','modular_zubbers/sound/vore/sunesound/prey/death_06.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/death_07.ogg','modular_zubbers/sound/vore/sunesound/prey/death_08.ogg','modular_zubbers/sound/vore/sunesound/prey/death_09.ogg',
	'modular_zubbers/sound/vore/sunesound/prey/death_10.ogg'
))

GLOBAL_LIST_INIT(vore_sounds_belches, list(
	'modular_zubbers/sound/vore/belches/belch1.ogg','modular_zubbers/sound/vore/belches/belch2.ogg','modular_zubbers/sound/vore/belches/belch3.ogg','modular_zubbers/sound/vore/belches/belch4.ogg',
	'modular_zubbers/sound/vore/belches/belch5.ogg','modular_zubbers/sound/vore/belches/belch6.ogg','modular_zubbers/sound/vore/belches/belch7.ogg','modular_zubbers/sound/vore/belches/belch8.ogg',
	'modular_zubbers/sound/vore/belches/belch9.ogg','modular_zubbers/sound/vore/belches/belch10.ogg','modular_zubbers/sound/vore/belches/belch11.ogg','modular_zubbers/sound/vore/belches/belch12.ogg',
	'modular_zubbers/sound/vore/belches/belch13.ogg','modular_zubbers/sound/vore/belches/belch14.ogg','modular_zubbers/sound/vore/belches/belch15.ogg'
))

GLOBAL_LIST_INIT(digest_messages_pred, list(
		"You feel %prey's body succumb to your digestive system, which breaks it apart into soft slurry.",
		"You hear a lewd glorp as your %belly muscles grind %prey into a warm pulp.",
		"Your %belly lets out a rumble as it melts %prey into sludge.",
		"You feel a soft gurgle as %prey's body loses form in your %belly. They're nothing but a soft mass of churning slop now.",
		"Your %belly begins gushing %prey's remains through your system, adding some extra weight to your thighs.",
		"Your %belly begins gushing %prey's remains through your system, adding some extra weight to your rump.",
		"Your %belly begins gushing %prey's remains through your system, adding some extra weight to your belly.",
		"Your %belly groans as %prey falls apart into a thick soup. You can feel their remains soon flowing deeper into your body to be absorbed.",
		"Your %belly kneads on every fiber of %prey, softening them down into mush to fuel your next hunt.",
		"Your %belly churns %prey down into a hot slush. You can feel the nutrients coursing through your digestive track with a series of long, wet glorps."))

GLOBAL_LIST_INIT(digest_messages_prey, list(
		"Your body succumbs to %pred's digestive system, which breaks you apart into soft slurry.",
		"%pred's %belly lets out a lewd glorp as their muscles grind you into a warm pulp.",
		"%pred's %belly lets out a rumble as it melts you into sludge.",
		"%pred feels a soft gurgle as your body loses form in their %belly. You're nothing but a soft mass of churning slop now.",
		"%pred's %belly begins gushing your remains through their system, adding some extra weight to %pred's thighs.",
		"%pred's %belly begins gushing your remains through their system, adding some extra weight to %pred's rump.",
		"%pred's %belly begins gushing your remains through their system, adding some extra weight to %pred's belly.",
		"%pred's %belly groans as you fall apart into a thick soup. Your remains soon flow deeper into %pred's body to be absorbed.",
		"%pred's %belly kneads on every fiber of your body, softening you down into mush to fuel their next hunt.",
		"%pred's %belly churns you down into a hot slush. Your nutrient-rich remains course through their digestive track with a series of long, wet glorps."))
