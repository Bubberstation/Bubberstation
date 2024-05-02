/mob/living/carbon/Drain()

	src.blood_volume = round(src.blood_volume*0.5,1) //Halves the CURRENT blood volume. Easier to suck more blood when there is more of it.

	become_husk(CHANGELING_DRAIN)

	return TRUE
