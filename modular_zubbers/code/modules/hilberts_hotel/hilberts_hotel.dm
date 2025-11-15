/obj/item/hilbertshotel
	name = "Hilbert's Hotel"
	desc = "A sphere of what appears to be an intricate network of bluespace. Observing it in detail seems to give you a headache as you try to comprehend the infinite amount of infinitesimally distinct points on its surface."
	icon = 'icons/obj/structures.dmi'
	icon_state = "hilbertshotel"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/is_ghost_cafe = FALSE

/obj/item/hilbertshotel/New()
	. = ..()

#ifndef UNIT_TESTS // This is a hack to prevent the storage turf from being loaded in unit tests and causing errors
	if(!SShilbertshotel.storageTurf && CONFIG_GET(flag/hilbertshotel_enabled)) // setting up a storage for the room objects
		SShilbertshotel.setup_storage_turf()
#endif

/obj/item/hilbertshotel/Initialize(mapload)
	. = ..()

	light_system = OVERLAY_LIGHT
	light_color = "#5692d6"
	light_range = 5
	light_power = 3
	light_on = TRUE

	update_appearance()

	if(!length(SShilbertshotel.hotel_map_list) && CONFIG_GET(flag/hilbertshotel_enabled))
		INVOKE_ASYNC(SShilbertshotel, TYPE_PROC_REF(/datum/controller/subsystem/hilbertshotel, prepare_rooms))

	var/area/currentArea = get_area(src)
	if(currentArea.type == /area/ruin/space/has_grav/powered/hilbertresearchfacility/secretroom)
		SShilbertshotel.lore_room_spawned = TRUE

	SShilbertshotel.all_hilbert_spheres += src

/obj/item/hilbertshotel/update_overlays()
	. = ..()
	. += emissive_appearance(icon, "hilbertshotel", src)

/obj/item/hilbertshotel/attack(mob/living/target_mob, mob/living/user, params)
	if(!target_mob.mind)
		to_chat(user, span_warning("[target_mob] is not intelligent enough to understand how to use this device!"))
		return ..()

	to_chat(user, span_notice("You invite [target_mob] to the hotel."))
	ui_interact(target_mob)

/obj/item/hilbertshotel/ghostdojo/examine(mob/user)
	. = ..()
	. += span_notice("It's slightly trembling.")

/obj/item/hilbertshotel/Destroy()
	SShilbertshotel.all_hilbert_spheres -= src
	if(!length(SShilbertshotel.all_hilbert_spheres))
		SShilbertshotel.eject_all_rooms()
	return ..()

/obj/item/hilbertshotel/attack_tk(mob/user)
	to_chat(user, span_notice("\The [src] actively rejects your mind as the bluespace energies surrounding it disrupt your telekinesis."))
	return COMPONENT_CANCEL_ATTACK_CHAIN

/// Runs all necessary checks before allowing a user to be moved to a room (or not). Requires `room_number` and `template` to be set.
/obj/item/hilbertshotel/proc/prompt_check_in(mob/user, mob/target, room_number, template)
	var/max_rooms = CONFIG_GET(number/hilbertshotel_max_rooms)
	var/hilbertshotel_enabled = CONFIG_GET(flag/hilbertshotel_enabled)

	if(!hilbertshotel_enabled)
		to_chat(target, span_warning("Hilbert's Hotel is currently disabled!"))
		return
	if((length(SShilbertshotel.room_data) + 1) >= max_rooms)
		to_chat(target, span_warning("Hilbert's Hotel is currently at maximum capacity!"))
		return
	if(room_number > SHORT_REAL_LIMIT)
		to_chat(target, span_warning("You have to check out the first [SHORT_REAL_LIMIT] rooms before you can go to a higher numbered one!"))
		return

	if(!template || !(template in SShilbertshotel.hotel_map_list))
		template = SShilbertshotel.default_template

	if(!template)
		return

	if(SShilbertshotel.conservated_rooms["[room_number]"]) // check 1 - conservated rooms
		if(SShilbertshotel.conservated_rooms["[room_number]"]["is_ghost_cafe"] != is_ghost_cafe && CONFIG_GET(flag/hilbertshotel_ghost_cafe_restricted))
			to_chat(target, span_warning("You can't enter this room!"))
			return
		to_chat(target, span_notice(pick(SShilbertshotel.vanity_strings))) // we're lucky - a conservated room exists which means we don't have to check for other stuff here
		if(SShilbertshotel.try_join_conservated_room(room_number, target, src))
			return
		return
	else if(SShilbertshotel.room_data["[room_number]"]) // check 2 - active rooms
		if(SShilbertshotel.room_data["[room_number]"]["is_ghost_cafe"] != is_ghost_cafe && CONFIG_GET(flag/hilbertshotel_ghost_cafe_restricted))
			to_chat(target, span_warning("You can't enter this room!"))
			return
		var/list/room = SShilbertshotel.room_data["[room_number]"]
		if(room["room_preferences"]["status"] == ROOM_CLOSED)
			to_chat(target, span_warning("This room is occupied!"))
			return
		// try to enter if room is open
		if(SShilbertshotel.try_join_active_room(room_number, target, src))
			to_chat(target, span_notice(pick(SShilbertshotel.vanity_strings)))
			do_sparks(3, FALSE, src)
			return
	// some vanity stuff I guess? also kudos to the dev for HL reference lol
	if(src.type == /obj/item/hilbertshotel)
		if(!(get_atom_on_turf(src, /mob) == user || loc == user))
			to_chat(user, span_warning("\The [src] is no longer in your possession!"))
			return
		if(user == target)
			if(!user.get_held_index_of_item(src))
				to_chat(user, span_warning("You try to drop \the [src], but it's too late! It's no longer in your hands! Prepare for unforeseen consequences..."))
			else if(!user.dropItemToGround(src))
				to_chat(user, span_warning("You can't seem to drop \the [src]! It must be stuck to your hand somehow! Prepare for unforeseen consequences..."))

	to_chat(target, span_notice(pick(SShilbertshotel.vanity_strings)))
	SShilbertshotel.send_to_new_room(room_number, target, template, src)

/obj/item/hilbertshotel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HilbertsHotelCheckout")
		ui.set_autoupdate(TRUE)
		ui.open()

/obj/item/hilbertshotel/ui_static_data(mob/user)
	. = ..()

	// Shouldn't change during the round so we may as well cache it
	.["hotel_map_list"] = list()
	for(var/template in SShilbertshotel.hotel_map_list)
		var/datum/map_template/ghost_cafe_rooms/room_template = SShilbertshotel.hotel_map_list[template]
		.["hotel_map_list"] += list(list(
			"name" = room_template.name,
			"category" = room_template.category || "Misc"
		))

/obj/item/hilbertshotel/ui_data(mob/user)
	var/list/data = list()

	if(!SShilbertshotel.user_data[user.ckey])
		SShilbertshotel.user_data[user.ckey] = list(
			"room_number" = 1,
			"template" = SShilbertshotel.default_template
		)

	data["current_room"] = SShilbertshotel.user_data[user.ckey]["room_number"]
	data["selected_template"] = SShilbertshotel.user_data[user.ckey]["template"]

	data["active_rooms"] = list()
	for(var/room_number in SShilbertshotel.room_data)
		var/list/room = SShilbertshotel.room_data["[room_number]"]
		if(room["room_preferences"]["visibility"] == ROOM_VISIBLE && (room["is_ghost_cafe"] == is_ghost_cafe || !CONFIG_GET(flag/hilbertshotel_ghost_cafe_restricted)))
			data["active_rooms"] += list(list(
				"number" = room_number,
				"occupants" = SShilbertshotel.generate_occupant_list(room_number),
				"room_preferences" = room["room_preferences"]
			))
	data["conservated_rooms"] = list()
	for(var/room_number in SShilbertshotel.conservated_rooms)
		var/list/room = SShilbertshotel.conservated_rooms[room_number]
		var/visibility = room["room_preferences"]["visibility"]
		if(room["is_ghost_cafe"] != is_ghost_cafe && CONFIG_GET(flag/hilbertshotel_ghost_cafe_restricted))
			continue
		switch(visibility)
			if(ROOM_VISIBLE)
				data["conservated_rooms"] += list(list(
					"number" = room_number,
					"room_preferences" = room["room_preferences"]
					))
			if(ROOM_GUESTS_ONLY)
				if((user.mind in room["access_restrictions"]["trusted_guests"]) || (user.mind == room["access_restrictions"]["room_owner"]))
					data["conservated_rooms"] += list(list(
						"number" = room_number,
						"room_preferences" = room["room_preferences"]
					))
			if(ROOM_CLOSED)
				if((user.mind == room["access_restrictions"]["room_owner"]))
					data["conservated_rooms"] += list(list(
						"number" = room_number,
						"room_preferences" = room["room_preferences"]
					))
	return data

/obj/item/hilbertshotel/ui_act(action, params)
	. = ..()
	if(.) // Orange eye; updates but is not interactive
		return

	if(!usr.ckey)
		return

	if(!SShilbertshotel.user_data[usr.ckey])
		SShilbertshotel.user_data[usr.ckey] = list(
			"room_number" = 1,
			"template" = SShilbertshotel.default_template
		)

	switch(action)
		if("update_room")
			var/new_room = params["room"]
			if(!new_room)
				return FALSE
			if(new_room < 1)
				return FALSE
			SShilbertshotel.user_data[usr.ckey]["room_number"] = new_room
			return TRUE

		if("select_room")
			var/template_name = params["room"]
			if(!(template_name in SShilbertshotel.hotel_map_list))
				return FALSE
			SShilbertshotel.user_data[usr.ckey]["template"] = template_name
			return TRUE

		if("checkin")
			var/template = SShilbertshotel.user_data[usr.ckey]["template"] || SShilbertshotel.default_template
			var/room_number = params["room"] || SShilbertshotel.user_data[usr.ckey]["room_number"] || 1
			if(!room_number || !(template in SShilbertshotel.hotel_map_list))
				return FALSE
			var/mob/living/user = usr
			if(type == /obj/item/hilbertshotel)
				user = istype(loc, /mob/living) ? loc : usr
			prompt_check_in(user, usr, room_number, template)
			return TRUE

// Template Stuff
/datum/map_template/hilbertshotel
	name = "Hilbert's Hotel Room"
	mappath = "_maps/templates/hilbertshotel.dmm"
	var/landingZoneRelativeX = 2
	var/landingZoneRelativeY = 8
	var/category = "Misc"

/datum/map_template/hilbertshotel/empty
	name = "Empty Hilbert's Hotel Room"
	mappath = "_maps/templates/hilbertshotelempty.dmm"

/datum/map_template/hilbertshotel/lore
	name = "Doctor Hilbert's Deathbed"
	mappath = "_maps/templates/hilbertshotellore.dmm"

/datum/map_template/hilbertshotelstorage
	name = "Hilbert's Hotel Storage"
	mappath = "_maps/templates/hilbertshotelstorage.dmm"


//Turfs and Areas
/turf/closed/indestructible/hotelwall
	name = "hotel wall"
	desc = "A wall designed to protect the security of the hotel's guests."
	icon_state = "hotelwall"
	smoothing_groups = SMOOTH_GROUP_CLOSED_TURFS + SMOOTH_GROUP_HOTEL_WALLS
	canSmoothWith = SMOOTH_GROUP_HOTEL_WALLS
	explosive_resistance = INFINITY

/turf/open/indestructible/hotelwood
	desc = "Stylish dark wood with extra reinforcement. Secured firmly to the floor to prevent tampering."
	icon_state = "wood"
	footstep = FOOTSTEP_WOOD
	tiled_turf = FALSE

/turf/open/indestructible/hoteltile
	desc = "Smooth tile with extra reinforcement. Secured firmly to the floor to prevent tampering."
	icon_state = "showroomfloor"
	footstep = FOOTSTEP_FLOOR
	tiled_turf = FALSE

/turf/open/space/bluespace
	name = "\proper bluespace hyperzone"
	icon_state = "bluespace"
	base_icon_state = "bluespace"
	baseturfs = /turf/open/space/bluespace
	turf_flags = NOJAUNT
	explosive_resistance = INFINITY
	var/obj/item/hilbertshotel/parentSphere

/turf/open/space/bluespace/Initialize(mapload)
	. = ..()
	update_icon_state()

/turf/open/space/bluespace/update_icon_state()
	icon_state = base_icon_state
	return ..()

/turf/open/space/bluespace/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(parentSphere && arrived.forceMove(get_turf(parentSphere)))
		do_sparks(3, FALSE, get_turf(arrived))

/turf/closed/indestructible/hoteldoor
	name = "Hotel Door"
	icon_state = "hoteldoor"
	explosive_resistance = INFINITY
	var/obj/item/hilbertshotel/parentSphere
	// Stores the list of users entry points by ckey, so that they can be returned to the sphere they interacted with
	var/list/entry_points = list()

/turf/closed/indestructible/hoteldoor/Initialize(mapload)
	. = ..()
	register_context()

/turf/closed/indestructible/hoteldoor/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_LMB] = "Peek through"
	return CONTEXTUAL_SCREENTIP_SET

/turf/closed/indestructible/hoteldoor/proc/promptExit(mob/living/user)
	var/destination = parentSphere
	if(!isliving(user))
		return
	if(!user.mind)
		return
	playsound(user, 'sound/machines/terminal/terminal_prompt.ogg', 100, TRUE)
	if(tgui_alert(user, "Hilbert's Hotel would like to remind you that while we will do everything we can to protect the belongings you leave behind, we make no guarantees of their safety while you're gone, especially that of the health of any living creatures. With that in mind, are you ready to leave?", "You sure?", list("Leave", "Stay")) == "Stay")
		return
	if(!(user.mind in entry_points)) // no valid entry point for this mind - reverting to the parent sphere
		to_chat(user, span_warning("The door seems to be malfunctioning!"))
		var/choice = tgui_alert(user, "Attention: the outside controller is malfunctioning. Hilbert's Hotel will not be responsible for any damage to your belongings or health. Are you sure you still want to leave?", "ATTENTION!", list("Yes", "No"))
		if(choice != "Yes")
			return
	else if(!parentSphere)
		to_chat(user, span_warning("The door seems to be malfunctioning and refuses to operate!"))
		return
	else
		destination = entry_points[user.mind] // user's entry point
	if(HAS_TRAIT(user, TRAIT_IMMOBILIZED) || (get_dist(get_turf(src), get_turf(user)) > 1)) // no teleporting around if they're dead or moved away during the prompt
		return
	user.forceMove(get_turf(destination))
	do_sparks(3, FALSE, get_turf(user))

/turf/closed/indestructible/hoteldoor/attack_ghost(mob/dead/observer/user)
	if(!isobserver(user) || !parentSphere)
		return ..()
	user.forceMove(get_turf(parentSphere))

//If only this could be simplified...
/turf/closed/indestructible/hoteldoor/attack_tk(mob/user)
	return //need to be close.

/turf/closed/indestructible/hoteldoor/attack_hand(mob/user, list/modifiers)
	promptExit(user)

/turf/closed/indestructible/hoteldoor/attack_animal(mob/user, list/modifiers)
	promptExit(user)

/turf/closed/indestructible/hoteldoor/attack_paw(mob/user, list/modifiers)
	promptExit(user)

/turf/closed/indestructible/hoteldoor/attack_hulk(mob/living/carbon/human/user)
	promptExit(user)

/turf/closed/indestructible/hoteldoor/attack_larva(mob/user, list/modifiers)
	promptExit(user)

/turf/closed/indestructible/hoteldoor/attack_robot(mob/user)
	if(get_dist(get_turf(src), get_turf(user)) <= 1)
		promptExit(user)

/turf/closed/indestructible/hoteldoor/click_alt(mob/user)
	if(user.is_blind())
		to_chat(user, span_warning("Drats! Your vision is too poor to use this!"))
		return CLICK_ACTION_BLOCKING

	to_chat(user, span_notice("You peek through the door's bluespace peephole..."))
	user.reset_perspective(parentSphere)
	var/datum/action/peephole_cancel/PHC = new
	user.overlay_fullscreen("remote_view", /atom/movable/screen/fullscreen/impaired, 1)
	PHC.Grant(user)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(check_eye))
	return CLICK_ACTION_SUCCESS

/turf/closed/indestructible/hoteldoor/proc/check_eye(mob/user, atom/oldloc, direction)
	SIGNAL_HANDLER
	if(get_dist(get_turf(src), get_turf(user)) < 2)
		return
	for(var/datum/action/peephole_cancel/PHC in user.actions)
		INVOKE_ASYNC(PHC, TYPE_PROC_REF(/datum/action/peephole_cancel, Trigger))

/datum/action/peephole_cancel
	name = "Cancel View"
	desc = "Stop looking through the bluespace peephole."
	button_icon_state = "cancel_peephole"

/datum/action/peephole_cancel/Trigger(trigger_flags)
	. = ..()
	to_chat(owner, span_warning("You move away from the peephole."))
	owner.reset_perspective()
	owner.clear_fullscreen("remote_view", 0)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	qdel(src)

// Despite using the ruins.dmi, hilbertshotel is not a ruin
/area/misc/hilbertshotel
	name = "Hilbert's Hotel Room"
	icon = 'icons/area/areas_ruins.dmi'
	icon_state = "hilbertshotel"
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	area_flags = NOTELEPORT | HIDDEN_AREA
	static_lighting = TRUE
	var/room_number = 0
	var/obj/item/hilbertshotel/parentSphere
	var/datum/turf_reservation/reservation
	var/turf/storageTurf

/area/misc/hilbertshotel/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(istype(arrived, /obj/item/hilbertshotel))
		relocate(arrived)
	var/list/obj/item/hilbertshotel/hotels = arrived.get_all_contents_type(/obj/item/hilbertshotel)
	for(var/obj/item/hilbertshotel/H in hotels)
		if(parentSphere == H)
			relocate(H)

/area/misc/hilbertshotel/proc/relocate(obj/item/hilbertshotel/H)
	if(prob(0.135685)) //Because screw you
		qdel(H)
		return

	// Prepare for...
	var/mob/living/unforeseen_consequences = get_atom_on_turf(H, /mob/living)

	// Turns out giving anyone who grabs a Hilbert's Hotel a free, complementary warp whistle is probably bad.
	// Let's gib the last person to have selected a room number in it.
	if(unforeseen_consequences)
		to_chat(unforeseen_consequences, span_warning("\The [H] starts to resonate. Forcing it to enter itself induces a bluespace paradox, violently tearing your body apart."))
		unforeseen_consequences.investigate_log("has been gibbed by using [H] while inside of it.", INVESTIGATE_DEATHS)
		unforeseen_consequences.gib(DROP_ALL_REMAINS)

	var/turf/targetturf = find_safe_turf()
	if(!targetturf)
		if(GLOB.blobstart.len > 0)
			targetturf = get_turf(pick(GLOB.blobstart))
		else
			CRASH("Unable to find a blobstart landmark")

	log_game("[H] entered itself. Moving it to [loc_name(targetturf)].")
	message_admins("[H] entered itself. Moving it to [ADMIN_VERBOSEJMP(targetturf)].")
	H.visible_message(span_danger("[H] almost implodes in upon itself, but quickly rebounds, shooting off into a random point in space!"))
	H.forceMove(targetturf)

/area/misc/hilbertshotel/Exited(atom/movable/gone, direction)
	. = ..()
	if(ismob(gone))
		var/mob/this_mob = gone
		if(this_mob.mind)
			var/stillPopulated = FALSE
			var/list/currentLivingMobs = get_all_contents_type(/mob/living) // gotta catch anyone hiding in anything
			for(var/mob/living/this_living in currentLivingMobs) // check to see if theres any *sentient* mobs left
				if(this_living.mind)
					stillPopulated = TRUE
					break
			if(!stillPopulated)
				SShilbertshotel.conservate_room(src)

/area/misc/hilbertshotelstorage
	name = "Hilbert's Hotel Storage Room"
	icon = 'icons/area/areas_ruins.dmi'
	icon_state = "hilbertshotel"
	requires_power = FALSE
	area_flags = HIDDEN_AREA | NOTELEPORT | UNIQUE_AREA
	default_gravity = STANDARD_GRAVITY

/obj/item/abstracthotelstorage
	anchored = TRUE
	invisibility = INVISIBILITY_ABSTRACT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	item_flags = ABSTRACT
	var/room_number
	var/obj/item/hilbertshotel/parentSphere

/obj/item/abstracthotelstorage/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(istype(arrived, /obj/machinery/light))
		var/obj/machinery/light/entered_light = arrived
		entered_light.end_processing()
	. = ..()
	if(ismob(arrived))
		var/mob/target = arrived
		ADD_TRAIT(target, TRAIT_NO_TRANSFORM, REF(src))
	arrived.resistance_flags |= INDESTRUCTIBLE

/obj/item/abstracthotelstorage/Exited(atom/movable/gone, direction)
	. = ..()
	if(ismob(gone))
		var/mob/target = gone
		REMOVE_TRAIT(target, TRAIT_NO_TRANSFORM, REF(src))
	if(istype(gone, /obj/machinery/light))
		var/obj/machinery/light/exited_light = gone
		exited_light.begin_processing()
	gone.resistance_flags &= ~INDESTRUCTIBLE
