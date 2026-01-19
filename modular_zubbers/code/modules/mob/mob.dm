/// Player Panel Proc calling for new player panel creation
/mob/proc/create_player_panel()
	if(mob_panel)
		QDEL_NULL(mob_panel)

	mob_panel = new(src)

/mob/Initialize()
	. = ..()
	create_player_panel()

/mob/Destroy()
	QDEL_NULL(mob_panel)
	return ..()
