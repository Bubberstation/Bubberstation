/mob/living/carbon/proc/get_fullness_text()
	var/t_He = p_They()
	var/t_His = p_Their()

	switch(fullness)
		if(FULLNESS_LEVEL_BLOATED to FULLNESS_LEVEL_BEEG)
			return "[t_He] look[p_s()] like [t_He] ate a bit too much.\n"
		if(FULLNESS_LEVEL_BEEG to FULLNESS_LEVEL_NOMOREPLZ)
			return "[t_His] stomach looks very round and very full.\n"
		if(FULLNESS_LEVEL_NOMOREPLZ to INFINITY)
			return "[t_His] stomach has been stretched to enormous proportions.\n"

/mob/living/carbon/proc/get_weight_text()
	var/t_He = p_They()
	var/t_His = p_Their()
	var/t_is = p_are()
	
	if(fatness >= FATNESS_LEVEL_BLOB)
		return "[t_He] [t_is] completely engulfed in rolls upon rolls of flab. [t_His] head is poking out on top of [t_His] body, akin to a marble on top of a hill.\n"

	if(fatness >= FATNESS_LEVEL_IMMOBILE)
		return "[t_His] body is buried in an overflowing surplus of adipose, and [t_His] legs are completely buried beneath layers of meaty, obese flesh.\n"

	if(fatness >= FATNESS_LEVEL_BARELYMOBILE)
		return "[t_He] [t_is] as wide as [t_He] [t_is] tall, barely able to move [t_His] masssive body that seems to be overtaken with piles of flab.\n"

	if(fatness >= FATNESS_LEVEL_EXTREMELY_OBESE)
		return "[t_He] [t_is] ripe with numerous rolls of fat, almost all of [t_His] body layered with adipose.\n"

	if(fatness >= FATNESS_LEVEL_MORBIDLY_OBESE)
		return "[t_He] [t_is] utterly stuffed with abundant lard, [t_He] doesn't seem to be able to move much.\n"

	if(fatness >= FATNESS_LEVEL_OBESE)
		return "[t_He] [t_is] engorged with fat, [t_His] body laden in rolls of fattened flesh.\n"

	if(fatness >= FATNESS_LEVEL_VERYFAT)
		return "[t_He] [t_is] pleasantly plushy, [t_His] body gently wobbling whenever they move. \n"

	if(fatness >= FATNESS_LEVEL_FATTER)
		return "[t_He] [t_is] soft and curvy, [t_His] belly looking like a small pillow.\n"
	
	return