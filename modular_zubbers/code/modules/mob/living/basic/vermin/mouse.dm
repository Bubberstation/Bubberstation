//Bubber Edit Addition: MICE WADDLE NOW.
/mob/living/basic/mouse/Initialize(mapload, tame = FALSE, new_body_color)
	. = ..()
	AddElement(/datum/element/waddling)
