/obj/item/heretic_map
	name = "heretical map"
	desc = "A strange slab of stone, with a dark concave inner circle. It is blank."

	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_maps.dmi'
	icon_state = "map"

	var/area/assocated_area

/obj/item/heretic_map/proc/set_map(area/desired_area)
	assocated_area = desired_area
	name = "[assocated_area] map"
	desc = "A strange slab of stone, with a dark concave inner circle. Looking in it, you can sort of make out an image of [assocated_area]..."
	return TRUE

/obj/item/heretic_map/attack_self(mob/user)

	if(!isliving(user))
		return

	user.visible_message(
		span_warning("[user] begins to channel the powers from [src]!"),
		span_notice("You begin to channel the powers from [src]!")
	)


	if(!do_after(user, 5 SECONDS, target = src))
		to_chat(user,span_notice("You stop channeling [src]."))
		return

	teleport(user)

	return

/obj/item/heretic_map/proc/teleport(mob/living/user)

	if(!assocated_area)
		to_chat(user,span_warning("Nothing happens..."))
		return FALSE

	var/turf/desired_turf = get_safe_random_station_turf(list(assocated_area))

	if(!desired_turf)
		to_chat(user,span_warning("Nothing happens..."))
		return FALSE

	var/turf/old_turf = get_turf(user)

	user.visible_message(
		span_warning("[user] flickers for a brief moment, then suddenly vanishes!"),
		span_notice("You flicker for a brief moment...")
	)

	//Teleport time.
	do_teleport(
		user,
		desired_turf,
		no_effects = TRUE,
		channel = TELEPORT_CHANNEL_MAGIC,
		asoundin = 'sound/magic/cosmic_energy.ogg',
		asoundout = 'sound/magic/cosmic_energy.ogg',
	)

	user.visible_message(
		span_danger("Phases in, seemingly from out of nowhere!"),
		span_notice("You phase into [assocated_area]!")
	)

	//Bring others with you.
	//Up to 5!
	var/portals_left = 5
	for(var/mob/living/nearby_living in orange(1,old_turf))
		do_teleport(
			nearby_living,
			desired_turf,
			no_effects = TRUE,
			channel = TELEPORT_CHANNEL_MAGIC
		)
		nearby_living.visible_message(
			span_warning("[nearby_living] is dragged along with [user]!"),
			span_danger("You're dragged along with [user]!")
		)
		portals_left--
		if(portals_left <= 0)
			break

	old_turf.audible_message(
		span_notice("You hear a near-silent whisper...")
	)

	old_turf.audible_message(
		span_velvet("...[assocated_area]...")
	)

	qdel(src)

	return TRUE

