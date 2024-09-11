//Portal effects/structure

GLOBAL_LIST_INIT(owning_heretic_portals,list()) //owner = portal

/obj/effect/portal/heretic
	name = "heretical portal"

	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_portal.dmi'
	icon_state = "none"

	mech_sized = TRUE
	teleport_channel = TELEPORT_CHANNEL_MAGIC

	var/owner_ckey

/obj/effect/portal/heretic/Initialize(...)

	. = ..()

	var/image/portal_center =  image(src.icon, icon_state = "portal_center", layer = FLOAT_LAYER)
	apply_wibbly_filters(portal_center)
	add_overlay(portal_center)

	var/image/portal_base =  image(src.icon, icon_state = "portal_base", layer = FLOAT_LAYER + 1)
	apply_wibbly_filters(portal_base)
	add_overlay(portal_base)

/obj/effect/portal/heretic/Destroy()
	. = ..()
	if(owner_ckey && GLOB.owning_heretic_portals[owner_ckey] == src)
		GLOB.owning_heretic_portals -= owner_ckey

//Portal item.

/obj/item/heretical_portal_scroll
	name = "heretical scroll of town portal"
	desc = "A magical piece of parchment that allegedly creates a short-lasting two-way portal to a the current station's \"town\". Only one portal pair is allowed to exist per soul!"
	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_portal.dmi'
	icon_state = "scroll"


	var/static/list/possible_areas = list( //Ordered in priority. Just in case a map is snowflake or something.
		/area/station/commons/lounge,
		/area/station/service/cafeteria,
		/area/station/commons/fitness/recreation,
		/area/station/commons/fitness,
		/area/station/commons/storage/primary,
		/area/station/hallway/primary/central,
		/area/station/hallway/secondary/entry,
		/area/station/hallway/secondary/exit,
		/area/station/hallway/secondary/exit/departure_lounge
		//Legitmately if your map doesn't have any of these areas, then holy fuck.
	)

	COOLDOWN_DECLARE(reuse_cooldown) //Just in case.


/obj/item/heretical_portal_scroll/attack_self(mob/user)

	var/user_ckey = user.ckey

	if(!IS_HERETIC(user) || !user_ckey)
		to_chat(user,span_warning("You don't know how to use this!"))
		return

	if(!COOLDOWN_FINISHED(src,reuse_cooldown))
		to_chat(user,span_warning("[src] is not ready to be used yet!"))
		return

	COOLDOWN_START(src, reuse_cooldown, 2 SECONDS) //Prevents spam in case of failures.

	var/turf/current_turf = get_turf(src)
	var/area/current_area = get_area(current_turf)

	if(current_area.area_flags & NOTELEPORT)
		to_chat(user,span_warning("Something in the air prevents you from using [src]!"))
		return

	var/turf/found_turf
	for(var/area/possible_area as anything in possible_areas)

		//Convert from path to type.
		possible_area = get_area_instance_from_text(possible_area)

		//Shouldn't fail, but you never know from future code fuckery.
		if(!possible_area || (possible_area.area_flags & NOTELEPORT))
			continue

		//Get all the open turfs.
		var/list/possible_turfs = list()
		for(var/turf/open/possible_turf in possible_area)
			possible_turfs += possible_turf

		//No open turfs? What is this, THE CUBE?
		if(!length(possible_turfs))
			continue

		//20 attempts maximum. Then we move on.
		for(var/attempt=1,attempt<=min(20,length(possible_turfs)),attempt++)
			var/turf/possible_turf = pick_n_take(possible_turfs)
			if(!is_safe_turf(possible_turf,TRUE,TRUE,TRUE))
				continue
			found_turf = possible_turf
			break

		//No need to continue. We found our turf.
		if(found_turf)
			break

	if(!found_turf)
		//Holy moly how do you not have a valid area?
		//Fuck it. Teleport into the middle of a possible sex scene on station. I don't care.
		found_turf = get_safe_random_station_turf()

	if(!found_turf)
		//Self explanatory
		to_chat(user,span_warning("Haha get fucked lmao report this bug on github."))
		return

	//Remove the existing portal, if one exists.
	if(length(GLOB.owning_heretic_portals) && GLOB.owning_heretic_portals[user_ckey])
		var/obj/effect/portal/existing_portal = GLOB.owning_heretic_portals[user_ckey]
		qdel(existing_portal)

	//Finally, create the ports.
	var/list/found_portals = create_portal_pair(
		current_turf,
		found_turf,
		60 SECONDS,
		0,
		/obj/effect/portal/heretic
	)

	//Assing the portal to the ckey for deletion if they make another portal.
	//The chances of a mob dying as heretic, then rejoining and then becoming another heretic within 60 seconds are slim, so we use basic ckey tracking.
	if(length(found_portals))
		var/obj/effect/portal/heretic/found_portal = found_portals[1]
		found_portal.owner_ckey = user_ckey
		GLOB.owning_heretic_portals[user_ckey] = found_portal

	qdel(src)

	return