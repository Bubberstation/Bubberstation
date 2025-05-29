/obj/item/transformation_item
	name = "Handheld Transmogrifier"
	desc = "a handheld device that is mysteriously able to turn people into objects. It can also be used to remove said transformations."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "gizmo_scan"
	item_state = "silencer"
	lefthand_file = 'icons/mob/inhands/antag/abductor_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/abductor_righthand.dmi'

	/// What item are we wanting to TF people into?
	var/obj/item/target_item
	/// Do we want our transformed person to be able to speak as the object?
	var/able_to_speak = TRUE
	/// Do we want our transformed person to be able to emote as the object?
	var/able_to_emote = TRUE
	/// Do we want the item to scale?
	var/scale_object = FALSE
	/// Do we want to show that the object was once a person?
	var/show_that_object_is_tf = TRUE
	/// Is our captured person able to struggle out?
	var/able_to_struggle_out = TRUE
	/// Do we have any items we can't turn people into?
	var/list/object_blacklist = list()

/obj/item/transformation_item/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	var/obj/item/attacked_item = target
	if(!proximity_flag || !istype(attacked_item))
		return FALSE

	var/datum/component/transformation_item/transformation_component = attacked_item.GetComponent(/datum/component/transformation_item)
	if(istype(transformation_component) && !transformation_component.stuck_on_item)
		qdel(transformation_component)
		to_chat(user, span_notice("You dispel the current transformation for [attacked_item]."))
		return

	target_item = attacked_item
	to_chat(user, span_notice("The next time someone is transformed, they will be transformed into [attacked_item]."))
	return

/obj/item/transformation_item/attack(mob/living/M, mob/living/user)
	if(!target_item)
		to_chat(user, span_warning("You need to have an item linked to transform someone."))
		return

	perform_transfomration(M, user)
	return

/obj/item/transformation_item/proc/perform_transfomration(mob/living/target_mob, mob/living/user)
	if(!istype(target_mob))
		return FALSE

	if(!target_item.Adjacent(target_mob))
		to_chat(user, span_warning("The [target_item] isn't close enough to [target_mob]"))
		return FALSE

	if(target_item in target_mob.get_contents())
		return FALSE // Don't TF someone into something they are holding.

	if(!target_mob?.client?.prefs?.object_tf)
		to_chat(user, span_warning("It seems like [target_mob] does not want to be transformed."))
		return FALSE

	var/datum/component/transformation_item/transformation_component = target_item.AddComponent(/datum/component/transformation_item)
	// Make sure that we apply our variables before we actually put the mob in the item.
	transformation_component.able_to_speak = able_to_speak
	transformation_component.able_to_emote = able_to_emote
	transformation_component.scale_object = scale_object
	transformation_component.show_that_object_is_tf = show_that_object_is_tf
	transformation_component.able_to_struggle_out = able_to_struggle_out

	transformation_component.register_mob(target_mob)
	target_item = null
	return TRUE

/obj/item/transformation_item/ui_data(mob/user)
	var/list/data = list()
	data["able_to_speak"] = able_to_speak
	data["able_to_emote"] = able_to_emote
	data["scale_object"] = scale_object
	data["show_that_object_is_tf"] = show_that_object_is_tf
	data["linked_item_name"] = target_item
	data["able_to_struggle_out"] = able_to_struggle_out

	return data

/obj/item/transformation_item/ui_act(action, params)
	if(..())
		return

	switch(action)
		if("set_speaking")
			able_to_speak = !able_to_speak
			. = TRUE

		if("set_emote")
			able_to_emote = !able_to_emote
			. = TRUE

		if("set_scale")
			scale_object = !scale_object
			. = TRUE

		if("toggle_struggle")
			able_to_struggle_out = !able_to_struggle_out
			. = TRUE

		if("set_show_desc")
			show_that_object_is_tf = !show_that_object_is_tf
			. = TRUE

/obj/item/transformation_item/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TransformTool", name)
		ui.open()
