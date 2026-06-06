/obj/item/organ/tongue/arachnid/Initialize(mapload) //speech bubble addition
	. = ..()
	AddComponent(/datum/component/bubble_icon_override, "spider", BUBBLE_ICON_PRIORITY_ORGAN)
