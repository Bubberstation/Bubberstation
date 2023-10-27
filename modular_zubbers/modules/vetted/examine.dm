/mob/living/silicon/get_silicon_flavortext()
	. = ..()
	if(client && SSplayer_ranks.is_vetted(client, admin_bypass = FALSE))
		. += span_greenannounce("This player has been vetted as 18+ by staff.")

/mob/living/carbon/human/examine(mob/user)
	. = ..()
	if(client && SSplayer_ranks.is_vetted(client, admin_bypass = FALSE))
		. += span_greenannounce("This player has been vetted as 18+ by staff.")
