/*
 * # robot_defines
 *
 * Bubber definitions for /mob/living/silicon/robot
 *
 */

/* Centcom Cyborgs */

/mob/living/silicon/robot/model/centcom
	icon = CYBORG_ICON_CENTCOM
	icon_state = "centcom"
	faction = list(ROLE_DEATHSQUAD)
	req_access = list(ACCESS_CENT_GENERAL)
	lawupdate = FALSE
	scrambledcodes = TRUE // These are not station borgs.
	ionpulse = TRUE
	var/playstyle_string = "<span class='big bold'>You are a Central Command cyborg!</span><br>"
	set_model = /obj/item/robot_model/centcom
	cell = /obj/item/stock_parts/power_store/cell/bluespace

/mob/living/silicon/robot/model/centcom/Initialize(mapload)
	laws = new /datum/ai_laws/central_override()
	laws.associate(src)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(show_playstyle)), 0.5 SECONDS)

/mob/living/silicon/robot/model/centcom/proc/show_playstyle()
	if(playstyle_string)
		to_chat(src, playstyle_string)

/mob/living/silicon/robot/model/centcom/ResetModel()
	return

/* Research cyborgs */
/mob/living/silicon/robot/model/sci
	icon_state = "research"
