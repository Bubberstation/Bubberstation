/datum/mood/proc/update_oblong()
	if(!current_oblong)
		current_oblong = new()

	current_oblong.filters = filter(type="color",color=mood_colour(),space=FILTER_COLOR_RGB)
//	mob_parent.vis_contents |= current_oblong
	if(mob_parent.mind)
		current_oblong.icon_state = "spinnew"
		return
	if(mob_parent.stat)
		current_oblong.icon_state = "new"
		return
	else
		current_oblong.icon_state = "stillfloat"
		return

/datum/mood
	var/obj/effect/overlay/oblong/current_oblong

/datum/mood_event/proc/update_oblong()

	owner.mob_mood?.update_oblong() // moods are not guaranteeds to exist

/obj/effect/overlay/oblong
	icon = 'modular_zubbers/icons/oblong.dmi'
	pixel_z = 36
	plane = BALLOON_CHAT_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 164


/datum/mood/proc/mood_colour() // change to new version
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

/datum/mood_event/New(mob/living/emotional_mob, ...)
	. = ..()
	update_oblong()
