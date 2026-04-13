/obj/item/crowbar/power/protonitrate
	name = "proto nitrate jaws of life"
	desc = "Hydraulic tool combined with Proto Nitrate Crystal for increased efficeincy."
	icon = 'modular_zubbers/icons/obj/equipment/equipment.dmi'
	icon_state = "pn_jaws"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/equipment_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/equipment_righthand.dmi'
	inhand_icon_state = "pn_jaws"
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

/obj/item/screwdriver/power/protonitrate
	name = "proto nitrate hand drill"
	desc = "Hand drill combined with Proto Nitrate Crystal for increased efficeincy."
	icon = 'modular_zubbers/icons/obj/equipment/equipment.dmi'
	icon_state = "pn_drill"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/equipment/equipment_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/equipment/equipment_righthand.dmi'
	inhand_icon_state = "pn_drill"
	toolspeed = 0.25

/obj/item/weldingtool/experimental/protonitrate
	name = "proto nitrate welding tool"
	desc = "An experimental welder further enchanced by combining it with Proto Nitrate Crystal."
	icon = 'modular_zubbers/icons/obj/equipment/equipment.dmi'
	icon_state = "pn_welder"
	toolspeed = 0.25
