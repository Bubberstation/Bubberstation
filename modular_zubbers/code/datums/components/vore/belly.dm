/obj/vore_belly
	name = "Default Belly"
	desc = "It's very bland!"

	var/datum/component/vore/owner
	var/datum/digest_mode/digest_mode

	var/brute_damage = 0
	var/burn_damage = 1

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

/obj/vore_belly/process(seconds_per_tick)
	digest_mode?.handle_belly(src, seconds_per_tick)

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

	data["digest_mode"] = digest_mode?.name
	data["brute_damage"] = brute_damage
	data["burn_damage"] = burn_damage

	return data

/obj/vore_belly/proc/ui_modify_var(var_name, value)
	switch(var_name)
		if("name")
			var/new_name = permissive_sanitize_name(value)
			if(new_name)
				name = new_name
		if("desc")
			desc = strip_html_full(value)
		if("digest_mode")
			var/datum/digest_mode/new_digest_mode = GLOB.digest_modes[value]
			if(istype(new_digest_mode))
				digest_mode = new_digest_mode
		if("brute_damage")
			brute_damage = clamp(value, 0, MAX_BRUTE_DAMAGE)
		if("burn_damage")
			burn_damage = clamp(value, 0, MAX_BURN_DAMAGE)

// Bellies always just make mobs inside them breath whatever is on the turf
/obj/vore_belly/assume_air(datum/gas_mixture/giver)
	return null

/obj/vore_belly/remove_air(amount)
	return null

/obj/vore_belly/return_air()
	return null

/obj/vore_belly/handle_internal_lifeform(mob/lifeform_inside_me, breath_request)
	if(breath_request > 0)
		var/breath_percentage = breath_request / GLOB.belly_air.return_volume()
		return GLOB.belly_air.remove(GLOB.belly_air.total_moles() * breath_percentage)
	else
		return null

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

/obj/vore_belly/container_resist_act(mob/living/user)
	// TODO: Pred-customizable chance
	// TODO: Squelchies
	to_chat(user, span_notice("You start to squirm out of [owner.parent]'s [src]..."))
	to_chat(owner.parent, span_warning("[user] starts to squirm out of your [src]..."))
	if(!do_after(user, RESIST_ESCAPE_DELAY, owner.parent, timed_action_flags = IGNORE_TARGET_LOC_CHANGE))
		return
	user.forceMove(get_turf(src))
	user.visible_message(span_danger("[user] squirms out of [owner.parent]'s [src]!"), span_notice("You squirm out of [owner.parent]'s [src]!"))


/obj/vore_belly/proc/serialize()
	return list(
		"name" = name,
		"desc" = desc,
		"brute_damage" = brute_damage,
		"burn_damage" = burn_damage
	)

/obj/vore_belly/proc/deserialize(list/data)
	name = permissive_sanitize_name(data["name"]) || "(Bad Name)"
	desc = strip_html_full(data["desc"]) || "(Bad Desc)"
	brute_damage = sanitize_integer(data["brute_damage"], 0, MAX_BRUTE_DAMAGE, 0)
	burn_damage = sanitize_integer(data["burn_damage"], 0, MAX_BURN_DAMAGE, 1)
