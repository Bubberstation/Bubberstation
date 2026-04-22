// Power Tools Belt Overlays
/obj/item/crowbar/power/get_belt_overlay()
	if(tool_behaviour != TOOL_WIRECUTTER)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "jaws")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "jaws_on")

/obj/item/crowbar/power/science/get_belt_overlay()
	if(tool_behaviour != TOOL_WIRECUTTER)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "sci_jaws")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "sci_jaws_on")

/obj/item/screwdriver/power/get_belt_overlay()
	if(tool_behaviour != TOOL_WRENCH)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "drill")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "drill_on")

/obj/item/screwdriver/power/science/get_belt_overlay()
	if(tool_behaviour != TOOL_WRENCH)
		return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "sci_drill")
	return mutable_appearance('modular_zubbers/icons/obj/clothing/belt_overlays.dmi', "sci_drill_on")


// Proto Nitrate Tools
/obj/item/crowbar/power/protonitrate
	name = "proto nitrate jaws of life"
	desc = "Hydraulic tool combined with Proto Nitrate Crystal for increased efficeincy."
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

/obj/item/weldingtool/experimental/protonitrate
	name = "proto nitrate welding tool"
	desc = "An experimental welder further enchanced by combining it with Proto Nitrate Crystal."
	icon = 'modular_zubbers/icons/obj/equipment/equipment.dmi'
	icon_state = "pn_welder"
	toolspeed = 0.25

