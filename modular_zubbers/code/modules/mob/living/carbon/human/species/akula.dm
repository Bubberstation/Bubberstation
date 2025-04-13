/obj/item/organ/tongue/akula
	say_mod = "bubbles"

/obj/item/organ/tongue/akula/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/bubble_icon_override, "fish", BUBBLE_ICON_PRIORITY_ORGAN)
