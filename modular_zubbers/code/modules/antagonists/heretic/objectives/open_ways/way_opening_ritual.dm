/datum/heretic_knowledge/open_way
	name = "Knock of the Twin-Finger"
	desc = "Allows you to open Ways towards the Mansus, breaching the thin veil between dawn and dusk and allowing you a glimpse of Light. \
	Ways tend to form in high-traffic and high-importance areas, and require a number of items to open. You can use this ritual to open a way (provided the transmutation rune is under the way), \
	or list all ways and their requirements."
	research_tree_icon_path = 'icons/effects/eldritch.dmi'
	research_tree_icon_state = "emark7"
	is_starting_knowledge = TRUE
	required_atoms = list()
	priority = MAX_KNOWLEDGE_PRIORITY - 1.2 // core part of your objs

/datum/heretic_knowledge/open_way/can_be_invoked(datum/antagonist/heretic/invoker)
	return TRUE

/datum/heretic_knowledge/open_way/proc/get_nearest_way(atom/loc, max_dist)
	RETURN_TYPE(/obj/effect/unopened_way)

	var/dist = INFINITY
	var/obj/effect/unopened_way/closest
	for (var/obj/effect/unopened_way/iter_way in GLOB.reality_smash_track.ways)
		if (iter_way.z != loc.z)
			continue
		var/iter_dist = get_dist(iter_way, loc)
		if (iter_dist > max_dist)
			continue

		if (iter_dist < dist)
			dist = iter_dist
			closest = iter_way

	return closest

/datum/heretic_knowledge/open_way/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)

	if(heretic_datum.has_living_heart() != HERETIC_HAS_LIVING_HEART)
		loc.balloon_alert(user, "ritual failed, no living heart!")
		return FALSE

	// TODO - if no ways are unopened, generate more (up to a point)

	var/obj/effect/unopened_way/way = get_nearest_way(loc, 1)
	if (isnull(way))
		return TRUE // we just tell them the nearest and its reqs

	var/list/stack_reqs = list()
	var/list/requirements_list = way.open_requirements.Copy()
	var/list/banned_atom_types = way.banned_atom_types.Copy()
	// had to copy and paste this bc all this code is directly in the do_ritual proc :(
	// JUST PUT MORE THINGS IN PROCS ITS OK GUYS

	// Now go through all our nearby atoms and see which are good for our ritual.
	for(var/atom/nearby_atom as anything in atoms)
		// Go through all of our required atoms
		for(var/req_type in requirements_list)
			// We already have enough of this type, skip
			if(requirements_list[req_type] <= 0)
				continue
			// If req_type is a list of types, check all of them for one match.
			if(islist(req_type))
				if(!is_type_in_list(nearby_atom, req_type))
					continue
			else if(!istype(nearby_atom, req_type))
				continue
			if (istype(nearby_atom, /obj/item/organ))
				var/obj/item/organ/organ = nearby_atom
				if (organ.organ_flags & ORGAN_ROBOTIC)
					continue
			// if list has items, check if the strict type is banned.
			if(length(banned_atom_types))
				if(nearby_atom.type in banned_atom_types)
					continue
			// If it's a stack, we gotta see if it has more than one inside,
			// as our requirements may want more than one item of a stack
			// It's also important that we split the required amount from the stack and add that
			// to the selected_atoms AFTERWARD so we don't change anything if the reqs aren't met.
			if(isstack(nearby_atom))
				var/obj/item/stack/picked_stack = nearby_atom
				if(!stack_reqs[req_type])
					stack_reqs[req_type] = requirements_list[req_type]
				requirements_list[req_type] -= min(picked_stack.amount || requirements_list[req_type])

			// Otherwise, just add the mark down the item as fulfilled x1
			else
				requirements_list[req_type]--
				if (requirements_list[req_type] <= 0)
					requirements_list -= req_type
				// This item is a valid type. Add it to our selected atoms list.
				selected_atoms |= nearby_atom

	// All of the atoms have been checked, let's see if the ritual was successful
	var/list/what_are_we_missing = list()
	for(var/req_type in requirements_list)
		var/number_of_things = requirements_list[req_type]
		// <= 0 means it's fulfilled, skip
		if(number_of_things <= 0)
			continue

		// > 0 means it's unfilfilled - the ritual has failed, we should tell them why
		// Lets format the thing they're missing and put it into our list
		var/formatted_thing = "[number_of_things] "
		if(islist(req_type))
			var/list/req_type_list = req_type
			var/list/req_text_list = list()
			for(var/atom/possible_type as anything in req_type_list)
				req_text_list += parse_required_item(possible_type)
			formatted_thing += english_list(req_text_list, and_text = "or")

		else
			formatted_thing = parse_required_item(req_type)

		what_are_we_missing += formatted_thing

	if (what_are_we_missing.len)
		// Let them know it screwed up
		loc.balloon_alert(user, "ritual failed, missing components!")
		// Then let them know what they're missing
		to_chat(user, span_hierophant_warning("You are missing [english_list(what_are_we_missing)] in order to open the way."))
		return FALSE

	return TRUE

/datum/heretic_knowledge/open_way/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/obj/effect/unopened_way/way = get_nearest_way(loc, 1)
	if (isnull(way))
		for (var/obj/effect/unopened_way/far_away_way in GLOB.reality_smash_track.ways)
			var/list/what_are_we_missing = list()
			var/list/requirements_list = far_away_way.open_requirements
			for(var/req_type in requirements_list)
				var/number_of_things = requirements_list[req_type]
				// <= 0 means it's fulfilled, skip
				if(number_of_things <= 0)
					continue

				// > 0 means it's unfilfilled - the ritual has failed, we should tell them why
				// Lets format the thing they're missing and put it into our list
				var/formatted_thing = "[number_of_things] "
				if(islist(req_type))
					var/list/req_type_list = req_type
					var/list/req_text_list = list()
					for(var/atom/possible_type as anything in req_type_list)
						req_text_list += parse_required_item(possible_type)
					formatted_thing += english_list(req_text_list, and_text = "or")
				else
					formatted_thing = parse_required_item(req_type)

				what_are_we_missing += formatted_thing

			var/area/target_area = get_area(far_away_way)
			to_chat(user, span_notice("There is a way in [target_area.name], and will require [english_list(what_are_we_missing)]."))

		return TRUE

	for (var/mob/living/iter_living in get_hearers_in_range(20, user))
		if (iter_living == user)
			continue
		to_chat(iter_living, span_warning("Reality shimmers around you. Someone in close proxmity is about to unleash a catastrophy...!"))
	to_chat(user, span_warning("You begin to open the way..."))
	if (!do_after(user, 30 SECONDS, user, IGNORE_HELD_ITEM))
		to_chat(user, span_boldwarning("Failure! The way remain closed."))
		return FALSE

	way.open(user)
	return TRUE
