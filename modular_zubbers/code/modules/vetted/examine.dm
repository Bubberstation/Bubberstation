/mob/living/silicon/get_silicon_flavortext()
	. = ..()
	if(!CONFIG_GET(flag/check_vetted))
		return
	if(client && SSplayer_ranks.is_vetted(client, admin_bypass = FALSE))
		. += span_greenannounce("This player has been vetted as 18+ by staff.")

/mob/living/carbon/human/examine(mob/user)
	. = ..()
	if(!CONFIG_GET(flag/check_vetted))
		return
	if(client && SSplayer_ranks.is_vetted(client, admin_bypass = FALSE))
		. += span_greenannounce("This player has been vetted as 18+ by staff.")
