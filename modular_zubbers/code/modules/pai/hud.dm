/atom/movable/screen/pai/leash
	name = "Toggle Leash"
	icon = 'modular_zubbers/icons/hud/screen_pai.dmi'
	icon_state = "pai_leash"

/atom/movable/screen/pai/leash/Click()
	if(!..())
		return
	var/mob/living/silicon/pai/pAI = usr
	if(!pAI.holoform)
		if(pAI.holo_leash)
			pAI.balloon_alert(usr, "emitters set to Move")
			pAI.holo_leash = FALSE
		else
			pAI.balloon_alert(usr, "emitters set to Project")
			pAI.holo_leash = TRUE
	else
		pAI.balloon_alert(usr, "your emitters are active!")

/datum/hud/pai/New(mob/living/silicon/pai/owner)
	..()
	var/atom/movable/screen/using
// Hololeash
	using = new /atom/movable/screen/pai/leash(null, src)
	using.screen_loc = "SOUTH:6,WEST+14"
	static_inventory += using
