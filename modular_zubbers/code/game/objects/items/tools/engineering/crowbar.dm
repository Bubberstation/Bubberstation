// Power Tools Belt Overlays
/obj/item/crowbar/power/get_belt_overlay()
	if(tool_behaviour != TOOL_WIRECUTTER)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "jaws")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "jaws_on")

/obj/item/crowbar/power/science/get_belt_overlay()
	if(tool_behaviour != TOOL_WIRECUTTER)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "sci_jaws")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "sci_jaws_on")

/obj/item/crowbar/power/paramedic
	toolspeed = 0.7

/obj/item/crowbar/power/bluespace
	name = "bluespace jaws"
	desc = "The jaws that you shouldn't have. Powered by bullshit- I mean bluespace. Cuts and prys really fast."
	icon = 'modular_zubbers/icons/obj/tools.dmi'
	icon_state = "bst_jaws"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/tools_righthand.dmi'
	inhand_icon_state = "bst_jaws"
	inside_belt_icon_state = null
	toolspeed = 0.05
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = INDESTRUCTIBLE|LAVA_PROOF|FIRE_PROOF|UNACIDABLE|ACID_PROOF
	custom_materials = null

/obj/item/crowbar/power/protonitrate
	name = "proto nitrate jaws of life"
	desc = "Hydraulic tool combined with Proto Nitrate Crystal for increased efficiency."
	icon = 'modular_zubbers/icons/obj/equipment/equipment.dmi'
	icon_state = "pn_jaws"
	toolspeed = 0.5

/obj/item/crowbar/power/protonitrate/Initialize(mapload)
	. = ..()
	UnregisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform_toolspeed))

/obj/item/crowbar/power/protonitrate/proc/on_transform_toolspeed(obj/item/source, mob/user, active) //Toolspeed affects how fast you can force open doors, this is so ONLY the prying mode has speed 0.5 while cutting mode is 0.25
	SIGNAL_HANDLER

	tool_behaviour = (active ? second_tool_behavior : first_tool_behavior)
	if(user)
		balloon_alert(user, "attached [tool_behaviour == first_tool_behavior ? inactive_text : active_text]")
	playsound(src, 'sound/items/tools/change_jaws.ogg', 50, TRUE)
	if(tool_behaviour != TOOL_WIRECUTTER)
		RemoveElement(/datum/element/cuffsnapping, snap_time_weak_handcuffs, snap_time_strong_handcuffs)
		toolspeed = 0.5
	else
		AddElement(/datum/element/cuffsnapping, snap_time_weak_handcuffs, snap_time_strong_handcuffs)
		toolspeed = 0.25
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/crowbar/power/protonitrate/get_belt_overlay()
	if(tool_behaviour != TOOL_WIRECUTTER)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_jaws")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_jaws_on")

/obj/item/crowbar/power/protonitrate/science
	name = "proto nitrate hybrid cutters" // hybrid between crowbar and wirecutters
	desc = "Hybrid cutters combined with Proto Nitrate Crystal for increased efficeincy but without the hydraulic force required to pry open doors."
	icon_state = "pn_jaws_sci"
	inhand_icon_state = "jaws_sci"
	force_opens = FALSE

/obj/item/crowbar/power/protonitrate/science/get_belt_overlay()
	if(tool_behaviour != TOOL_WIRECUTTER)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_sci_jaws")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "pn_sci_jaws_on")

/obj/item/crowbar/large/heavy/science
	name = "physicist's crowbar"
	desc = "It's a big crowbar for a scientist who is clearly compensating for something. It doesn't fit in your pockets, because it's big. Feels oddly light..."
	force = 4 // ~3 times less
	throwforce = 12
	attack_speed = CLICK_CD_RAPID //4 times faster.

	toolspeed = 0.25
	demolition_mod = 2
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT,
		)
