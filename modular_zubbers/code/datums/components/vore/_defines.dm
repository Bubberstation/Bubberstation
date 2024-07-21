#define MAX_BELLIES 10
#define MAX_PREY 3
#define VORE_DELAY 1 SECONDS // TODO: Change to 30 SECONDS
#define RESIST_ESCAPE_DELAY 15 SECONDS // TODO: find something to change this to
#define MATRYOSHKA_BANNED FALSE // TODO: Change this
#define FRIES_SENSORS TRUE
#define REQUIRES_PLAYER FALSE // TODO: Change this
#define VORE_TESTING_ALL_MOBS_ARE_VORE_MOBS // Makes every mob into a vore mob for testing
#define BELLY_BACKUP_COUNT 5 // Number of rolling backups bellies will keep

#define DIGEST_MODE_NONE "None"
#define DIGEST_MODE_DIGEST "Digest"

#define MAX_BURN_DAMAGE 2.5
#define MAX_BRUTE_DAMAGE 2.5

#define PREF_TRINARY_NEVER 0
#define PREF_TRINARY_PROMPT 1
#define PREF_TRINARY_ALWAYS 2

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
