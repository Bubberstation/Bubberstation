
//EXPLAINATION
//The code is weird and multiplies movespeed by 1.5, so that is what the default is. This means by default, you are 50% slower than what the config is.
//This is fucking weird, but whatever. We'll work with it.
//Changeling haste, which is the fastest movespeed modifier in the game, subtracts 0.8
//Thus the value here is 0.7
#define MOVEMENT_DELAY_MULTIPLIER_LIMIT 0.7

/mob/living/update_movespeed()
	. = ..()
	cached_multiplicative_slowdown = max(.,MOVEMENT_DELAY_MULTIPLIER_LIMIT) //Max means get the largest of this two.

#undef MOVEMENT_DELAY_MULTIPLIER_LIMIT
