/mob/living/carbon/human
	/// Quad eyes offset in pixels. Positive is up, negative is down. (Suggested to not go above 2 or below -2)
	var/quad_eyes_offset = 0
	/// Used for footstep type pref, to apply to any new legs that get added to this mob. Uses a var instead of checking prefs because there are a lot of clientless mob situations.
	var/footstep_type


/mob/living/carbon/human/species/shadekin
	race = /datum/species/shadekin

// Just blanket apply the footstep pref on limb addition, it gets far too complicated otherwise as limbs are getting replaced more often than you'd think
/obj/item/bodypart/leg/on_adding(mob/living/carbon/new_owner)
	. = ..()
	var/mob/living/carbon/human/human_owner = new_owner
	if(istype(human_owner) && human_owner.footstep_type)
		if(islist(human_owner.footstep_type))
			special_footstep_sounds = human_owner.footstep_type
		else
			footstep_type = human_owner.footstep_type

// This is expected to be called or used in situations where you already know the mob is dead
/mob/living/carbon/human/proc/get_dnr()
	return stat ? ((HAS_TRAIT(src, TRAIT_DNR) && !((src.mind?.get_ghost(FALSE, TRUE)) ? 1 : 0))) : 0

/mob/living/carbon/human/Move(NewLoc, direct)
	. = ..()
	if(wear_neck && body_position == STANDING_UP && loc == NewLoc && has_gravity(loc))
		SEND_SIGNAL(wear_neck, COMSIG_NECK_STEP_ACTION)

#define HIDING_RADIAL_DMI 'modular_zubbers/icons/hud/radial.dmi'

/mob/living/carbon/human/mutant_part_visibility(quick_toggle, re_do)
	// The parts our particular user can choose
	var/list/available_selection
	// The total list of parts choosable
	var/static/list/total_selection = list(
		ORGAN_SLOT_EXTERNAL_HORNS = "horns",
		ORGAN_SLOT_EARS = "ears",
		ORGAN_SLOT_EXTERNAL_WINGS = "wings",
		ORGAN_SLOT_EXTERNAL_TAIL = "tail",
		ORGAN_SLOT_EXTERNAL_SYNTH_ANTENNA = "ipc_antenna",
		ORGAN_SLOT_EXTERNAL_ANTENNAE = "moth_antennae",
		ORGAN_SLOT_EXTERNAL_XENODORSAL = "xenodorsal",
		ORGAN_SLOT_EXTERNAL_SPINES = "spines",
		ORGAN_SLOT_EXTERNAL_FRILLS = "frills",
	)

	// Stat check
	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't do this right now..."))
		return

	// Only show the 'reveal all' button if we are already hiding something
	if(try_hide_mutant_parts)
		LAZYOR(available_selection, "reveal all")
	// Lets build our parts list
	for(var/organ_slot in total_selection)
		if(get_organ_slot(organ_slot))
			LAZYOR(available_selection, total_selection[organ_slot])

	// If this proc is called with the 'quick_toggle' flag, we skip the rest
	if(quick_toggle)
		if("reveal all" in available_selection)
			LAZYNULL(try_hide_mutant_parts)
		else
			for(var/part in available_selection)
				LAZYOR(try_hide_mutant_parts, part)
		update_body_parts()
		return

	// Dont open the radial automatically just for one button
	if(re_do && (length(available_selection) == 1))
		return
	// If 'reveal all' is our only option just do it
	if(!re_do && (("reveal all" in available_selection) && (length(available_selection) == 1)))
		LAZYNULL(try_hide_mutant_parts)
		update_body_parts()
		return

	// Radial rendering
	var/list/choices = list()
	for(var/choice in available_selection)
		var/datum/radial_menu_choice/option = new
		var/image/part_image = image(icon = HIDING_RADIAL_DMI, icon_state = choice)

		option.image = part_image
		if(choice in try_hide_mutant_parts)
			part_image.underlays += image(icon = HIDING_RADIAL_DMI, icon_state = "module_unable")
		choices[choice] = option
	// Radial choices
	sort_list(choices)
	var/pick = show_radial_menu(usr, src, choices, custom_check = FALSE, tooltips = TRUE)
	if(!pick)
		return

	// Choice to action
	if(pick == "reveal all")
		to_chat(usr, span_notice("You are no longer trying to hide your mutant parts."))
		LAZYNULL(try_hide_mutant_parts)
		update_body_parts()
		return

	else if(pick in try_hide_mutant_parts)
		to_chat(usr, span_notice("You are no longer trying to hide your [pick]."))
		LAZYREMOVE(try_hide_mutant_parts, pick)
	else
		to_chat(usr, span_notice("You are now trying to hide your [pick]."))
		LAZYOR(try_hide_mutant_parts, pick)
	update_body_parts()
	// automatically re-do the menu after making a selection
	mutant_part_visibility(re_do = TRUE)

#undef HIDING_RADIAL_DMI
