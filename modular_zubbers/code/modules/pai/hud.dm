/atom/movable/screen/pai/shell/holo_leashed
	name = "Toggle Leash"
	icon_state = "template"

/atom/movable/screen/pai/shell/holo_leashed/Click()
	if(!..())
		return
	var/mob/living/silicon/pai/pAI = usr
	if(pAI.holo_leash)
		pAI.holo_leash = FALSE
	else
		pAI.holo_leash = TRUE

/datum/hud/pai/New(mob/living/silicon/pai/owner)
	..()
	var/atom/movable/screen/using
// Hololeash
	using = new /atom/movable/screen/pai/holo_leashed(null, src)
	using.screen_loc = "SOUTH:6,WEST+14"
	static_inventory += using
