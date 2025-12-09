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

/**
 * Helpful for when a players uplink window gets glitched to above their screen.
 * preventing them from moving the UPLINK window.
 */
/mob/verb/reset_ui_positions_for_mob()
	set name = "Reset UI Positions"
	set category = "OOC"
	SStgui.reset_ui_position(src)
