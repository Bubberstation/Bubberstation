/mob/living/silicon/get_silicon_flavortext()
	. = ..()
	if(SSplayer_ranks.is_vetted(client, admin_bypass = FALSE))
		. += span_info("This player has been vetted by staff.")

/mob/living/carbon/human/examine(mob/user)
	. = ..()
	if(SSplayer_ranks.is_vetted(client, admin_bypass = FALSE))
		. += span_info("This player has been vetted by staff.")
