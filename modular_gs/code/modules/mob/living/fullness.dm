/mob/living/carbon/proc/reduce_fullness(amount, notify = TRUE) // fullness_amount should be between 5 and 20 for balance and below 80 for functionality
	if(!ishuman(src))
		return

	if(fullness >= FULLNESS_LEVEL_BLOATED && fullness_reduction_timer + FULLNESS_REDUCTION_COOLDOWN < world.time)

		fullness -= amount // Remove Fullness

		if(!notify)
			return

		if(amount <= 5)
			to_chat(src, "You felt that make some space")
		if(amount > 5)
			to_chat(src, "You felt that make a lot of space")

