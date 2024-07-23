//Remember, this is a multiplier for delay.
//This means that 0.5 is double your movespeed (1/2)
//This means that 0.25 is quadruple your movespeed (1/4)
#define MOVEMENT_DELAY_MULTIPLIER_LIMIT 0.25

/mob/living/update_movespeed()
	. = ..()
	cached_multiplicative_slowdown = max(.,MOVEMENT_DELAY_MULTIPLIER_LIMIT) //Max means get the largest of this two.

#undef MOVEMENT_DELAY_MULTIPLIER_LIMIT
