// Power Tools Belt Overlays
/obj/item/screwdriver/power/get_belt_overlay()
	if(tool_behaviour != TOOL_WRENCH)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "drill")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "drill_on")

/obj/item/screwdriver/power/science/get_belt_overlay()
	if(tool_behaviour != TOOL_WRENCH)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "sci_drill")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "sci_drill_on")

/obj/item/screwdriver/power/protonitrate
	name = "proto nitrate hand drill"
	desc = "Hand drill combined with Proto Nitrate Crystal for increased efficeincy."
	icon = 'modular_zubbers/icons/obj/equipment/equipment.dmi'
	icon_state = "pn_drill"
	toolspeed = 0.25

/obj/item/screwdriver/power/protonitrate/get_belt_overlay()
	if(tool_behaviour != TOOL_WRENCH)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_drill")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_drill_on")

/obj/item/screwdriver/power/protonitrate/science
	icon_state = "pn_drill_sci"

/obj/item/screwdriver/power/protonitrate/science/get_belt_overlay()
	if(tool_behaviour != TOOL_WRENCH)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_sci_drill")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_sci_drill_on")

/obj/item/screwdriver/power/bluespace
	name = "bluespace driver"
	desc = "The drill you shouldn't have. Tipped and powered with bluespace to strip screws instantly."
	icon = 'modular_zubbers/icons/obj/tools.dmi'
	icon_state = "bst_drill"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/tools_righthand.dmi'
	inhand_icon_state = "bst_drill"
	inside_belt_icon_state = null
	toolspeed = 0.05
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = INDESTRUCTIBLE|LAVA_PROOF|FIRE_PROOF|UNACIDABLE|ACID_PROOF
	custom_materials = null
