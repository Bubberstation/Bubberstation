/datum/trigger_type/use_item
	var/required_item_type
	var/use_time = 0
	var/consume_item = FALSE
	var/balloon_text = "used"

/datum/trigger_type/use_item/parse_extra_args(required_item_type, use_time = 0, consume = FALSE, balloon = null)
	src.required_item_type = required_item_type
	src.use_time = use_time
	src.consume_item = consume
	if(balloon)
		balloon_text = balloon

/datum/trigger_type/use_item/subscribe_to_parent()
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(on_item_interact))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/trigger_type/use_item/unsubscribe_from_parent()
	. = ..()
	UnregisterSignal(parent, list(COMSIG_ATOM_ITEM_INTERACTION, COMSIG_ATOM_EXAMINE))

/datum/trigger_type/use_item/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	var/obj/item/I = required_item_type
	if(!ispath(I))
		return
	examine_list += span_boldnotice("[initial(I.name)] can be used on this.")

/datum/trigger_type/use_item/proc/on_item_interact(datum/source, mob/living/user, obj/item/tool, list/modifiers)
	SIGNAL_HANDLER

	if(!istype(user) || user.stat)
		return

	if(required_item_type && !istype(tool, required_item_type))
		parent.balloon_alert_to_viewers("Wrong item!")
		return

	if(use_time > 0)
		INVOKE_ASYNC(src, PROC_REF(use_item_async), user, tool)
	else
		do_use_item(user, tool)

	return ITEM_INTERACT_SUCCESS

/datum/trigger_type/use_item/proc/use_item_async(mob/living/user, obj/item/item)
	playsound(parent, item.usesound, 30)

	if(!do_after(user, use_time, parent, extra_checks = CALLBACK(src, PROC_REF(still_holding), user, item)))
		parent.balloon_alert_to_viewers("Interrupted!")
		return
	playsound(parent, item.usesound, 30)
	do_use_item(user, item)

/datum/trigger_type/use_item/proc/still_holding(mob/living/user, obj/item/item)
	return user.is_holding(item)

/datum/trigger_type/use_item/proc/do_use_item(mob/living/user, obj/item/item)
	if(consume_item)
		if(istype(item, /obj/item/stack))
			var/obj/item/stack/stack_item = item
			if(stack_item.use(1))
				parent.balloon_alert_to_viewers("[balloon_text] [item.name]!")
				trigger(user)
		else
			parent.balloon_alert_to_viewers("[balloon_text] [item.name]!")
			trigger(user)
			qdel(item)


/datum/trigger_type/tool_act
	var/required_tool
	var/use_time = 0

/datum/trigger_type/tool_act/parse_extra_args(required_tool = TOOL_SCREWDRIVER, use_time = 0)
	src.required_tool = required_tool
	src.use_time = use_time

/datum/trigger_type/tool_act/subscribe_to_parent()
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(on_tool_interact))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/trigger_type/tool_act/unsubscribe_from_parent()
	. = ..()
	UnregisterSignal(parent, list(COMSIG_ATOM_ITEM_INTERACTION, COMSIG_ATOM_EXAMINE))

/datum/trigger_type/tool_act/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_boldnotice("[required_tool] can be used on this.")


/datum/trigger_type/tool_act/proc/on_tool_interact(datum/source, mob/living/user, obj/item/tool, list/modifiers)
	SIGNAL_HANDLER

	if(!isliving(user) || user.stat)
		return


	if(required_tool && !(tool.tool_behaviour == required_tool))
		parent.balloon_alert_to_viewers("Wrong tool!")
		return

	if(use_time > 0)
		INVOKE_ASYNC(src, PROC_REF(use_tool), user, tool)
	else
		parent.balloon_alert_to_viewers("Used [tool.name]!")
		INVOKE_ASYNC(src, PROC_REF(trigger), user)
	return ITEM_INTERACT_SUCCESS

/datum/trigger_type/tool_act/proc/use_tool(mob/user, obj/item/tool)
	playsound(parent, tool.usesound, 30)
	if(!do_after(user, use_time, parent))
		parent.balloon_alert_to_viewers("Interupted!")
		return
	parent.balloon_alert_to_viewers("Used [tool.name]!")
	playsound(parent, tool.usesound, 30)
	trigger(user)



/obj/effect/mapping_helpers/trigger_helper/use_item
	name = "Use Item Trigger Helper"
	icon_state = "trigger_key"
	trigger_type = /datum/trigger_type/use_item

	var/EDITOR_item_type = /obj/item/key
	var/EDITOR_use_time = 0
	var/EDITOR_consume = FALSE
	var/EDITOR_balloon_text = "used"

/obj/effect/mapping_helpers/trigger_helper/use_item/Initialize(mapload)
	extra_params = list(
		"required_item_type" = EDITOR_item_type,
		"use_time" = EDITOR_use_time,
		"consume" = EDITOR_consume,
		"balloon" = EDITOR_balloon_text
	)
	return ..()

/obj/effect/mapping_helpers/trigger_helper/tool_act
	name = "Tool Act Trigger Helper"
	icon_state = "trigger_tool"
	trigger_type = /datum/trigger_type/tool_act

	var/EDITOR_tool_behaviour = TOOL_SCREWDRIVER
	var/EDITOR_use_time = 3 SECONDS

/obj/effect/mapping_helpers/trigger_helper/tool_act/Initialize(mapload)
	extra_params = list(
		"required_tool" = EDITOR_tool_behaviour,
		"use_time"     = EDITOR_use_time
	)
	return ..()

/obj/effect/mapping_helpers/trigger_helper/tool_act/screwdriver
	name = "Screwdriver Trigger"
	icon_state = "trigger_screw"
	EDITOR_tool_behaviour = TOOL_SCREWDRIVER

/obj/effect/mapping_helpers/trigger_helper/tool_act/wrench
	name = "Wrench Trigger"
	icon_state = "trigger_wrench"
	EDITOR_tool_behaviour = TOOL_WRENCH

/obj/effect/mapping_helpers/trigger_helper/tool_act/crowbar
	name = "Crowbar Trigger"
	icon_state = "trigger_crowbar"
	EDITOR_tool_behaviour = TOOL_CROWBAR

/obj/effect/mapping_helpers/trigger_helper/tool_act/welder
	name = "Welder Trigger"
	icon_state = "trigger_welder"
	EDITOR_tool_behaviour = TOOL_WELDER
	EDITOR_use_time = 4 SECONDS

/obj/effect/mapping_helpers/trigger_helper/tool_act/wirecutter
	name = "Wirecutter Trigger"
	icon_state = "trigger_wirecutter"
	EDITOR_tool_behaviour = TOOL_WIRECUTTER
