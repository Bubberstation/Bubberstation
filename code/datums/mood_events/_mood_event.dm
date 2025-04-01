/datum/mood_event
	/// Description of the mood event
	var/description
	/// An integer value that affects overall sanity over time
	var/mood_change = 0
	/// How long this mood event should last
	var/timeout = 0
	/// Is this mood event hidden on examine
	var/hidden = FALSE
	/**
	 * A category to put multiple mood events. If one of the mood events in the category
	 * is active while another mood event (from the same category) is triggered it will remove
	 * the effects of the current mood event and replace it with the new one
	 */
	var/category
	/// Icon state of the unique mood event icon, if applicable
	var/special_screen_obj
	/// if false, it will be an overlay instead
	var/special_screen_replace = TRUE
	/// Owner of this mood event
	var/mob/living/owner
	/// List of required jobs for this mood event
	var/list/required_job = list()

/datum/mood
	var/obj/effect/overlay/oblong/current_oblong
/datum/mood/proc/update_oblong()
	if(!current_oblong)
		current_oblong = new()

	current_oblong.filters = filter(type="color",color=mood_colour(),space=FILTER_COLOR_RGB)
	mob_parent.vis_contents |= current_oblong
	if(mob_parent.mind)
		current_oblong.icon_state = "spinfloat"
		return
	if(mob_parent.stat)
		current_oblong.icon_state = "still"
		return
	else
		current_oblong.icon_state = "stillfloat"
		return
/datum/mood_event/New(mob/living/emotional_mob, ...)
	owner = emotional_mob
	var/list/params = args.Copy(2)
	if ((length(required_job) > 0) && owner.mind && !(owner.mind.assigned_role.type in required_job))
		qdel(src)
		return
	add_effects(arglist(params))
	update_oblong()

/datum/mood_event/proc/update_oblong()

	owner.mob_mood.update_oblong()


/obj/effect/overlay/oblong
	icon = 'modular_zubbers/icons/oblong.dmi'
	pixel_y = 36
	plane = BALLOON_CHAT_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 164


/datum/mood/proc/mood_colour()
	switch(mob_parent.mob_mood.sanity_level)
		if (SANITY_LEVEL_GREAT)
			. = color_hex2color_matrix("#2eeb9a")
		if (SANITY_LEVEL_NEUTRAL)
			. = color_hex2color_matrix("#86d656")
		if (SANITY_LEVEL_DISTURBED)
			. = color_hex2color_matrix( "#4b96c4")
		if (SANITY_LEVEL_UNSTABLE)
			. = color_hex2color_matrix( "#dfa65b")
		if (SANITY_LEVEL_CRAZY)
			. = color_hex2color_matrix( "#f38943")
		if (SANITY_LEVEL_INSANE)
			. = color_hex2color_matrix( "#f15d36")

	if(HAS_TRAIT(mob_parent, TRAIT_MOOD_NOEXAMINE))

		. = color_hex2color_matrix( "#4b96c4")
		return
	return



/datum/mood_event/Destroy()
	remove_effects()
	owner = null
	return ..()

/datum/mood_event/proc/add_effects(param)
	var/mob/living/carbon/human/owner_as_human = owner
	ASYNC
		owner_as_human.display_image_in_bubble(owner.mob_mood.mood_screen_object)
	return

/datum/mood_event/proc/remove_effects()
	return
