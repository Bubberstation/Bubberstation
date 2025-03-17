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

//Research cyborgs
/mob/living/silicon/robot/model/sci
	icon_state = "research"
