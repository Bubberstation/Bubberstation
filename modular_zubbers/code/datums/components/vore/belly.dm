/obj/vore_belly
	// name = ""
	name = "Default Belly"
	desc = "It's very bland!"
	// desc = ""
	var/datum/component/vore/owner
	var/datum/digest_mode/digest_mode

/obj/vore_belly/Initialize(mapload, datum/component/vore/new_owner)
	. = ..()
	if(!istype(new_owner))
		return INITIALIZE_HINT_QDEL
	owner = new_owner
	LAZYADD(owner.vore_bellies, src)
	digest_mode = GLOB.digest_modes["None"]
	START_PROCESSING(SSvore, src)

/obj/vore_belly/Destroy(force)
	STOP_PROCESSING(SSvore, src)
	if(owner)
		LAZYREMOVE(owner.vore_bellies, src)
	owner = null
	digest_mode = null
	// Safely yeet everything out
	var/turf/T = get_turf(src)
	for(var/atom/movable/A as anything in contents)
		A.forceMove(T)
	. = ..()

/obj/vore_belly/ui_data(mob/user)
	var/list/data = list()

	data["name"] = name
	data["desc"] = desc
	data["ref"] = REF(src)

	var/list/contents_data = list()
	for(var/atom/A as anything in contents)
		UNTYPED_LIST_ADD(contents_data, list(
			"name" = A.name,
			"ref" = REF(A),
			"appearance" = REF(A.appearance),
		))
	data["contents"] = contents_data

	return data

// Bellies always just make mobs inside them breath whatever is on the turf
/obj/vore_belly/assume_air(datum/gas_mixture/giver)
	var/turf/T = get_turf(src)
	return T.assume_air(giver)

/obj/vore_belly/remove_air(amount)
	var/turf/T = get_turf(src)
	return T.remove_air(amount)

/obj/vore_belly/return_air()
	var/turf/T = get_turf(src)
	return T.return_air()

/obj/vore_belly/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	owner.appearance_holder.vis_contents += arrived
	if(ismob(arrived))
		// TODO: Noises
		// TODO: Insertion Verb
		to_chat(arrived, examine_block("You slide into [span_notice("[owner.parent]")]'s [span_green(name)]!\n[desc]"))

/obj/vore_belly/Exited(atom/movable/gone, direction)
	. = ..()
	owner.appearance_holder.vis_contents -= gone

/obj/vore_belly/relaymove(mob/living/user, direction)
	// Do not call parent, hides the "you can't move while buckled" message
	// TODO: Squelchy!
	return

/obj/vore_belly/proc/serialize()
	return list(
		"name" = name,
		"desc" = desc
	)

/obj/vore_belly/proc/deserialize(list/data)
	name = data["name"]
	desc = data["desc"]
