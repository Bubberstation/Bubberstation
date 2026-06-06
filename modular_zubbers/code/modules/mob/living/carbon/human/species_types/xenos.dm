/obj/item/organ/brain/xeno_hybrid/Initialize(mapload) //speech bubble addition
	. = ..()
	AddComponent(/datum/component/bubble_icon_override, "alien", BUBBLE_ICON_PRIORITY_ORGAN)
