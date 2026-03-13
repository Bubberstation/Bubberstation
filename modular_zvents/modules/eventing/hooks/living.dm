/obj/effect/landmark/start
	delete_after_roundstart = FALSE


/mob/living/death(gibbed)
	. = ..()

	if(client)
		SSround_events.on_player_dead(src)
