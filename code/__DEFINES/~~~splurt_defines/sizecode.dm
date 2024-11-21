//I am not a coder. Please fucking tear apart my code, and insult me for how awful I am at coding. Please and thank you. -Dahlular
//alright bet -BoxBoy
#define RESIZE_MACRO 6
#define RESIZE_HUGE 4
#define RESIZE_BIG 2
#define RESIZE_NORMAL 1
#define RESIZE_SMALL 0.75
#define RESIZE_TINY 0.50
#define RESIZE_MICRO 0.25

//averages
#define RESIZE_A_MACROHUGE (RESIZE_MACRO + RESIZE_HUGE) / 2
#define RESIZE_A_HUGEBIG (RESIZE_HUGE + RESIZE_BIG) / 2
#define RESIZE_A_BIGNORMAL (RESIZE_BIG + RESIZE_NORMAL) / 2
#define RESIZE_A_NORMALSMALL (RESIZE_NORMAL + RESIZE_SMALL) / 2
#define RESIZE_A_SMALLTINY (RESIZE_SMALL + RESIZE_TINY) / 2
#define RESIZE_A_TINYMICRO (RESIZE_TINY + RESIZE_MICRO) / 2

/*
 * # get_size(mob/living/target)
 * Grabs the size of your critter, works for any living creature even carbons with dna
 * Now, please don't tell me your creature has a dna but it's very snowflakey, then i say you should rewrite your mob
 * instead of touching this file.
*/
/proc/get_size(mob/living/target)
	if(!target)
		CRASH("get_size(NULL) was called")
	if(!istype(target))
		CRASH("get_size() called with an invalid target, only use this for /mob/living!")
	var/datum/dna/has_dna = target.has_dna()
	if(ishuman(target) && has_dna)
		return has_dna.features["body_size"]
	else
		return target.size_multiplier

/*
 * # COMPARE_SIZES(mob/living/user, mob/living/target)
 * Returns how bigger or smaller the target is in comparison to user
 * Example:
 * - user = 2, target = 1, result = 0.5
 * - user = 1, target = 2, result = 2
 * Args:
 * - user = /mob/living
 * - target = /mob/living
*/
#define COMPARE_SIZES(user, target) abs((get_size(user) / get_size(target)))
