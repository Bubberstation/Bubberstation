//Addition: MICE WADDLE NOW.
/mob/living/basic/mouse/Initialize(mapload, tame = FALSE, new_body_color)
	. = ..()
	AddElementTrait(TRAIT_WADDLING, "innate", /datum/element/waddling)
