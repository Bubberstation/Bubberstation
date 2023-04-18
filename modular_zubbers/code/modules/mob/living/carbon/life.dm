/mob/living/carbon/Life(delta_time, times_fired)
	. = ..()
	handle_hydration()
	handle_urination()
