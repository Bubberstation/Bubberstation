/mob/living/silicon/robot/model/centcom
	icon = CYBORG_ICON_CENTCOM_WIDE_BUBBER
	icon_state = "valecc"
	faction = list(ROLE_DEATHSQUAD)
	req_access = list(ACCESS_CENT_GENERAL)
	lawupdate = FALSE
	scrambledcodes = TRUE // These are not station borgs.
	ionpulse = TRUE
	var/playstyle_string = "<span class='big bold'>You are a Central Command cyborg!</span><br>"
	set_model = /obj/item/robot_model/centcom
	cell = /obj/item/stock_parts/cell/bluespace

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

//Small cyborg traits
/mob/living/silicon/robot/buckle_mob(mob/living/M, force = FALSE, check_loc = TRUE, buckle_mob_flags= NONE)
	if(TRAIT_R_SMALL in model.model_features)
		M.visible_message(span_warning("[M] is too heavy for [src]'s chassie!"))
		return
	return ..()
