#define MAX_BELLIES 10
#define MAX_PREY 3
#define VORE_DELAY 1 SECONDS // TODO: Change to 30 SECONDS
#define RESIST_ESCAPE_DELAY 15 SECONDS // TODO: find something to change this to
#define MATRYOSHKA_BANNED FALSE // TODO: Change this
#define FRIES_SENSORS TRUE
#define REQUIRES_PLAYER FALSE // TODO: Change this

#define DIGEST_MODE_NONE "None"
#define DIGEST_MODE_DIGEST "Digest"

#define MAX_BURN_DAMAGE 2.5
#define MAX_BRUTE_DAMAGE 2.5

GLOBAL_LIST_INIT(vore_allowed_mob_types, typecacheof(list(
	/mob/living
	// TODO: Change to
	// /mob/living/carbon/human,
	// /mob/living/silicon/robot
)))

#define PREF_TRINARY_NEVER 0
#define PREF_TRINARY_PROMPT 1
#define PREF_TRINARY_ALWAYS 2
