///I'm trying my best allright
/mob/living/carbon/human
	icon = 'GainStation13/icons/mob/fat.dmi'
	var/hunger = 0

/mob/living/carbon/human/Life()
	. = ..()
	hunger = hunger + 1
	switch(hunger)
		if(0 to 10)
			icon_state = "fat_m_body"

			update_body()
			//chubby
		if(11 to 20)
			icon_state = "obese_m_body"
			update_body()
			//fed
		if(21 to 30)
			icon_state = "mobese_m_body"
			update_body()
			//full
		if(31 to 40)
			icon_state = "imm_m_body"
			update_body()
			//fat
		else
			icon_state = "blob_m_body"
			update_body()
			//chungus
