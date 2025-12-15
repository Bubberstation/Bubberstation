SUBSYSTEM_DEF(hilbertshotel)
	name = "Hilbert's Hotel"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_HILBERTSHOTEL

	var/list/obj/item/hilbertshotel/all_hilbert_spheres = list()

	// Some placeholder templates
	var/datum/map_template/hilbertshotel/hotel_room_template
	var/datum/map_template/hilbertshotel/empty/hotel_room_template_empty
	var/datum/map_template/hilbertshotel/lore/hotel_room_template_lore

	/// List of active rooms with their data.
	var/list/room_data = list()
	/// List of "frozen" rooms.
	var/list/conservated_rooms = list()
	var/storageTurf
	// Lore stuff
	var/lore_room_spawned = FALSE

	var/list/datum/map_template/ghost_cafe_rooms/hotel_map_list = list()
	/// Name of the first template in the list - used as default
	var/default_template

	// List of strings used for the prompt check-in message
	var/static/list/vanity_strings = list(
		"You feel a strange sense of déjà vu.",
		"You feel chills rolling down your spine.",
		"You suddenly feel like you're being watched from behind.",
		"You feel like a gust of bone-chilling cold is passing through you.",
		"Your vision gets a little blurry for a moment.",
		"Your heart sinks as you feel a strange sense of dread.",
		"Your mouth goes dry.",
		"You feel uneasy.",
	)

	/// List of ckey-based user preferences
	var/list/user_data = list()

	var/hhMysteryroom_number

/datum/controller/subsystem/hilbertshotel/Initialize()
	. = ..()
	if(!CONFIG_GET(flag/hilbertshotel_enabled))
		return SS_INIT_NO_NEED
	RegisterSignal(src, COMSIG_HILBERT_ROOM_UPDATED, PROC_REF(on_room_updated))
	hhMysteryroom_number = hhMysteryroom_number || rand(1, 999999)
	prepare_rooms()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/hilbertshotel/proc/setup_storage_turf()
	if(storageTurf) // setting up a storage for the room objects
		return
	var/datum/map_template/hilbertshotelstorage/storageTemp = new()
	var/datum/turf_reservation/storageReservation = SSmapping.request_turf_block_reservation(3, 3)
	var/turf/bottom_left = get_turf(storageReservation.bottom_left_turfs[1])
	storageTemp.load(bottom_left)
	storageTurf = locate(bottom_left.x + 1, bottom_left.y + 1, bottom_left.z)

/datum/controller/subsystem/hilbertshotel/proc/prepare_rooms()
	if(length(hotel_map_list))
		return
	var/list/hotel_map_templates = typecacheof(list(
		/datum/map_template/ghost_cafe_rooms,
	), ignore_root_path = TRUE)

	hotel_room_template = new()
	hotel_room_template_empty = new()
	hotel_room_template_lore = new()

	hotel_map_list[hotel_room_template.name] = hotel_room_template

	for(var/template_type in hotel_map_templates)
		var/datum/map_template/this_template = new template_type()
		hotel_map_list[this_template.name] = this_template

	default_template = hotel_map_list[1]

/// Attempts to join an existing active room. Returns TRUE if successful, FALSE otherwise. Requires `room_number` to be set.
/datum/controller/subsystem/hilbertshotel/proc/try_join_active_room(room_number, mob/user, parentSphere)
	if(!room_data["[room_number]"])
		return FALSE

	var/list/room = room_data["[room_number]"]
	var/room_status = room["room_preferences"]["status"]
	var/list/access_restrictions = room["access_restrictions"]
	var/is_owner = FALSE
	var/is_trusted = FALSE

	if(user?.mind)
		is_owner = (access_restrictions["room_owner"] == user.mind)
		is_trusted = (user.mind in access_restrictions["trusted_guests"])

	if(room_status == ROOM_CLOSED && !is_owner)
		to_chat(user, span_warning("This room is closed!"))
		return FALSE

	if(room_status == ROOM_GUESTS_ONLY && !is_owner && !is_trusted)
		to_chat(user, span_warning("Access denied. This room is only available to invited guests."))
		return FALSE

	var/datum/turf_reservation/roomReservation = room["reservation"]
	do_sparks(3, FALSE, get_turf(user))
	var/turf/room_bottom_left = roomReservation.bottom_left_turfs[1]

	var/turf/door_turf = room_data["[room_number]"]["door_reference"]
	if(istype(door_turf, /turf/closed/indestructible/hoteldoor))
		var/turf/closed/indestructible/hoteldoor/door = door_turf
		if(user?.mind && parentSphere)
			door.entry_points[user.mind] = parentSphere

	// Get the landing coords for the room
	var/datum/map_template/ghost_cafe_rooms/room_template = hotel_map_list[room["template"]]
	var/relative_x = istype(room_template) && room_template.landing_coords?[1] ? room_template.landing_coords[1] : hotel_room_template.landingZoneRelativeX
	var/relative_y = istype(room_template) && room_template.landing_coords?[2] ? room_template.landing_coords[2] : hotel_room_template.landingZoneRelativeY

	user.forceMove(locate(
		room_bottom_left.x + relative_x,
		room_bottom_left.y + relative_y,
		room_bottom_left.z,
	))
	return TRUE

/// Attempts to recreate and join an existing stored room. Returns TRUE if successful, FALSE otherwise. Requires `room_number` to be set.
/datum/controller/subsystem/hilbertshotel/proc/try_join_conservated_room(room_number, mob/user, obj/item/hilbertshotel/parentSphere)
	if(!conservated_rooms["[room_number]"])
		return FALSE

	var/list/conservated_room_data = conservated_rooms["[room_number]"]
	if(!conservated_room_data)
		return FALSE

	var/list/room_preferences = conservated_room_data["room_preferences"]
	var/list/access_restrictions = conservated_room_data["access_restrictions"]
	var/room_status = room_preferences["status"]

	if(room_status != ROOM_OPEN)
		var/datum/mind/owner_mind = access_restrictions["room_owner"]
		var/list/trusted_guests = access_restrictions["trusted_guests"]
		var/is_owner = FALSE
		var/is_trusted = FALSE

		if(owner_mind == user.mind)
			is_owner = TRUE
		else
			for(var/datum/mind/guest_mind in trusted_guests)
				if(istype(guest_mind) && guest_mind == user.mind)
					is_trusted = TRUE
					break

		if(room_status == ROOM_CLOSED && !is_owner)
			to_chat(user, span_warning("Access denied. This room is locked by the owner."))
			return FALSE

		if(room_status == ROOM_GUESTS_ONLY && !is_owner && !is_trusted)
			to_chat(user, span_warning("Access denied. This room is only available to invited guests."))
			return FALSE

	var/list/storage = conservated_room_data["storage"]
	if(!storage)
		return FALSE

	var/template_name = conservated_room_data["template"]
	var/datum/map_template/template_to_load = hotel_map_list[template_name]
	var/datum/turf_reservation/roomReservation = SSmapping.request_turf_block_reservation(template_to_load.width, template_to_load.height, 1)
	var/turf/room_turf = roomReservation.bottom_left_turfs[1]
	template_to_load.load(room_turf)

	// clearing default objects
	for(var/x in 0 to template_to_load.width - 1)
		for(var/y in 0 to template_to_load.height - 1)
			var/turf/T = locate(room_turf.x + x, room_turf.y + y, room_turf.z)
			for(var/atom/movable/A in T)
				if(ismachinery(A))
					var/obj/machinery/M = A
					M.obj_flags += NO_DEBRIS_AFTER_DECONSTRUCTION
				if(ismob(A) && !isliving(A))
					continue
				if(istype(A, /obj/effect))
					continue
				QDEL_LIST(A.contents)
				qdel(A)

	// restoring saved objects
	var/turfNumber = 1
	for(var/x in 0 to template_to_load.width - 1)
		for(var/y in 0 to template_to_load.height - 1)
			var/turf/target_turf = locate(room_turf.x + x, room_turf.y + y, room_turf.z)
			for(var/atom/movable/A in storage["[turfNumber]"])
				if(istype(A.loc, /obj/item/abstracthotelstorage))
					var/old_resist = A.resistance_flags
					A.resistance_flags |= INDESTRUCTIBLE
					A.forceMove(target_turf)
					A.resistance_flags = old_resist
					if(istype(A, /obj/machinery/room_controller))
						var/obj/machinery/room_controller/controller = A
						controller.bluespace_box.in_hotel_room = TRUE
						controller.bluespace_box.creation_area = get_area(A.loc)
			turfNumber++

	// clearing the storage
	for(var/obj/item/abstracthotelstorage/this_item in storageTurf)
		if((this_item.room_number == room_number))
			qdel(this_item)

	// updating the room data
	room_data["[room_number]"] = list(
		"reservation" = roomReservation,
		"door_reference" = room_turf,
		"template" = conservated_room_data["template"],
		"room_preferences" = room_preferences.Copy(),
		"access_restrictions" = access_restrictions.Copy(),
		"is_ghost_cafe" = conservated_room_data["is_ghost_cafe"],
	)
	conservated_rooms -= "[room_number]"

	link_turfs(roomReservation, room_number, parentSphere)
	var/turf/door_turf = room_data["[room_number]"]["door_reference"]
	if(istype(door_turf, /turf/closed/indestructible/hoteldoor))
		var/turf/closed/indestructible/hoteldoor/door = door_turf
		if(user?.mind && parentSphere)
			door.entry_points[user.mind] = parentSphere

	do_sparks(3, FALSE, get_turf(user))

	// Get the landing coords for the room
	var/datum/map_template/ghost_cafe_rooms/room_template = hotel_map_list[template_name]
	var/relative_x = istype(room_template) && room_template.landing_coords?[1] ? room_template.landing_coords[1] : hotel_room_template.landingZoneRelativeX
	var/relative_y = istype(room_template) && room_template.landing_coords?[2] ? room_template.landing_coords[2] : hotel_room_template.landingZoneRelativeY

	user.forceMove(locate(
		room_turf.x + relative_x,
		room_turf.y + relative_y,
		room_turf.z,
	))
	return TRUE

/// Creates a new room. Loads the room template and sends the user there. Requires `room_number` and `chosen_room` to be set.
/datum/controller/subsystem/hilbertshotel/proc/send_to_new_room(room_number, mob/user, template, obj/item/hilbertshotel/parentSphere)
	var/mysteryRoom = hhMysteryroom_number
	var/datum/map_template/load_from = hotel_room_template
	if(lore_room_spawned && room_number == mysteryRoom)
		load_from = hotel_room_template_lore
	else if(template in hotel_map_list)
		var/datum/map_template/ghost_cafe_rooms/room_template = hotel_map_list[template]
		if(!istype(room_template)) // Default hilbert's hotel room
			load_from = room_template
		else
			load_from = room_template
	else
		to_chat(user, span_warning("You are washed over by a wave of heat as the sphere violently wiggles. You wonder if you did something wrong..."))
		return

	var/datum/turf_reservation/roomReservation = SSmapping.request_turf_block_reservation(load_from.width, load_from.height, 1)
	var/turf/bottom_left = roomReservation.bottom_left_turfs[1]
	load_from.load(bottom_left)

	var/area/misc/hilbertshotel/current_area = get_area(locate(bottom_left.x, bottom_left.y, bottom_left.z))

	for(var/obj/machinery/vending/this_vending in current_area)
		this_vending.onstation = ROOM_ONSTATION_OVERRIDE
		this_vending.onstation_override = ROOM_ONSTATION_OVERRIDE

	LAZYSET(room_data, "[room_number]", list(
		"reservation" = roomReservation,
		"door_reference" = null,
		"template" = template,
		"room_preferences" = list(
			"status" = ROOM_OPEN,
			"visibility" = ROOM_VISIBLE,
			"privacy" = ROOM_GUESTS_HIDDEN,
			"description" = null,
			"name" = template,
			"icon" = "door-open",
		),
		"access_restrictions" = list(
			"room_owner" = user.mind,
			"trusted_guests" = list(),
		),
		"is_ghost_cafe" = parentSphere.is_ghost_cafe,
	))

	link_turfs(roomReservation, room_number, parentSphere)
	var/turf/closed/indestructible/hoteldoor/door = room_data["[room_number]"]["door_reference"]
	door.entry_points[user.mind] = parentSphere // adding the sphere to the entry points list

	do_sparks(3, FALSE, get_turf(user))

	// Get the landing coords for the room
	var/datum/map_template/ghost_cafe_rooms/room_template = hotel_map_list[template]
	var/relative_x = istype(room_template) && room_template.landing_coords?[1] ? room_template.landing_coords[1] : hotel_room_template.landingZoneRelativeX
	var/relative_y = istype(room_template) && room_template.landing_coords?[2] ? room_template.landing_coords[2] : hotel_room_template.landingZoneRelativeY

	user.forceMove(locate(
		bottom_left.x + relative_x,
		bottom_left.y + relative_y,
		bottom_left.z,
	))

/datum/controller/subsystem/hilbertshotel/proc/link_turfs(datum/turf_reservation/currentReservation, currentroom_number, obj/item/hilbertshotel/parentSphere)
	var/turf/room_bottom_left = currentReservation.bottom_left_turfs[1]
	var/area/misc/hilbertshotel/currentArea = get_area(room_bottom_left)

	currentArea.name = "Hilbert's Hotel Room [currentroom_number]"
	currentArea.parentSphere = parentSphere
	currentArea.storageTurf = storageTurf
	currentArea.room_number = currentroom_number
	currentArea.reservation = currentReservation

	for(var/turf/closed/indestructible/hoteldoor/door in currentReservation.reserved_turfs)
		door.parentSphere = parentSphere
		door.desc = "The door to this hotel room. \
			The placard reads 'Room [currentroom_number]'. \
			Strangely, this door doesn't even seem openable. \
			The doorknob, however, seems to buzz with unusual energy...<br/>\
			[span_info("Alt-Click to look through the peephole.")]"
		room_data["[currentroom_number]"]["door_reference"] = door // easier door referencing to keep track of entry points
	for(var/turf/T in currentReservation.reserved_turfs)
		for(var/obj/machinery/room_controller/controller in T.contents)
			controller.room_number = currentroom_number
			if(controller.bluespace_box)
				controller.bluespace_box.in_hotel_room = TRUE
				controller.bluespace_box.creation_area = currentArea
			controller.update_appearance()
	for(var/turf/open/space/bluespace/BSturf in currentReservation.reserved_turfs)
		BSturf.parentSphere = parentSphere

/datum/controller/subsystem/hilbertshotel/proc/generate_occupant_list(room_number)
	var/datum/map_template/template = hotel_map_list[room_data["[room_number]"]["template"]]
	var/list/occupants = list()
	if(room_data["[room_number]"])
		var/datum/turf_reservation/room = room_data["[room_number]"]["reservation"]
		var/turf/room_bottom_left = room.bottom_left_turfs[1]
		for(var/i in 0 to template.width-1)
			for(var/j in 0 to template.height-1)
				for(var/atom/movable/movable_atom in locate(room_bottom_left.x + i, room_bottom_left.y + j, room_bottom_left.z))
					if(ismob(movable_atom))
						var/mob/this_mob = movable_atom
						if(isliving(this_mob))
							if(this_mob.mind)
								occupants += this_mob.mind.name
	return occupants

/// "Reserves" the room when the last guest leaves it. Creates an abstract storage object and forceMoves all the contents into it, deleting the reservation afterwards.
/datum/controller/subsystem/hilbertshotel/proc/conservate_room(area/misc/hilbertshotel/current_area)
	if(!storageTurf)
		setup_storage_turf()
	var/datum/map_template/template = hotel_map_list[room_data["[current_area.room_number]"]["template"]]
	var/turf/room_bottom_left = current_area.reservation.bottom_left_turfs[1]
	var/list/storage = list()
	var/turfNumber = 1
	var/obj/item/abstracthotelstorage/storageObj = new(current_area.storageTurf)
	storageObj.room_number = current_area.room_number
	storageObj.parentSphere = current_area.parentSphere
	storageObj.name = "Room [current_area.room_number] Storage"

	// saving room contents
	for(var/x in 0 to template.width - 1)
		for(var/y in 0 to template.height - 1)
			var/turf/T = locate(room_bottom_left.x + x, room_bottom_left.y + y, room_bottom_left.z)
			var/list/turfContents = list()

			for(var/atom/movable/movable_atom in T)
				if(istype(movable_atom, /obj/effect))
					continue
				if(ismob(movable_atom) && !isliving(movable_atom))
					continue
				if(movable_atom.loc != T)
					continue
				if(istype(movable_atom, /obj/machinery/room_controller))
					var/obj/machinery/room_controller/controller = movable_atom
					controller.bluespace_box?.in_hotel_room = FALSE
					controller.bluespace_box?.creation_area = null

				turfContents += movable_atom
				var/old_resist = movable_atom.resistance_flags
				var/old_smoothing = movable_atom.smoothing_flags
				movable_atom.resistance_flags |= INDESTRUCTIBLE
				movable_atom.smoothing_flags = NONE
				movable_atom.forceMove(storageObj)
				movable_atom.resistance_flags = old_resist
				movable_atom.smoothing_flags = old_smoothing
			storage["[turfNumber]"] = turfContents
			turfNumber++

	var/room_template = room_data["[current_area.room_number]"]["template"]
	var/list/room_preferences = room_data["[current_area.room_number]"]["room_preferences"]
	var/list/access_restrictions = room_data["[current_area.room_number]"]["access_restrictions"]
	var/is_ghost_cafe = room_data["[current_area.room_number]"]["is_ghost_cafe"]
	conservated_rooms["[current_area.room_number]"] = list(
		"storage" = storage,
		"template" = room_template,
		"room_preferences" = room_preferences.Copy(),
		"access_restrictions" = access_restrictions.Copy(),
		"is_ghost_cafe" = is_ghost_cafe,
	)
	room_data -= "[current_area.room_number]"
	qdel(current_area.reservation)

/datum/controller/subsystem/hilbertshotel/proc/eject_all_rooms()
	if(room_data.len)
		for(var/number in room_data)
			var/datum/turf_reservation/room = room_data[number]["reservation"]
			var/datum/map_template/template = hotel_map_list[room_data[number]["template"]]
			var/turf/room_bottom_left = room.bottom_left_turfs[1]
			for(var/i in 0 to template.width-1)
				for(var/j in 0 to template.height-1)
					for(var/atom/movable/A in locate(room_bottom_left.x + i, room_bottom_left.y + j, room_bottom_left.z))
						if(ismob(A))
							var/mob/M = A
							if(M.mind)
								to_chat(M, span_warning("As the sphere breaks apart, you're suddenly ejected into the depths of space!"))
						var/max = world.maxx-TRANSITIONEDGE
						var/min = 1+TRANSITIONEDGE
						var/list/possible_transtitons = list()
						for(var/AZ in SSmapping.z_list)
							var/datum/space_level/D = AZ
							possible_transtitons += D.z_value
						var/_z = pick(possible_transtitons)
						var/_x = rand(min,max)
						var/_y = rand(min,max)
						var/turf/T = locate(_x, _y, _z)
						A.forceMove(T)
			qdel(room)

	if(conservated_rooms.len)
		for(var/x in conservated_rooms)
			var/list/atomList = conservated_rooms[x]
			for(var/atom/movable/A in atomList)
				var/max = world.maxx-TRANSITIONEDGE
				var/min = 1+TRANSITIONEDGE
				var/list/possible_transtitons = list()
				for(var/AZ in SSmapping.z_list)
					var/datum/space_level/D = AZ
					possible_transtitons += D.z_value
				var/_z = pick(possible_transtitons)
				var/_x = rand(min,max)
				var/_y = rand(min,max)
				var/turf/T = locate(_x, _y, _z)
				A.forceMove(T)

/datum/controller/subsystem/hilbertshotel/proc/on_room_updated(datum/source, list/data)
	SIGNAL_HANDLER

	for(var/obj/item/hilbertshotel/sphere in all_hilbert_spheres)
		SStgui.update_uis(sphere)
	return

/datum/controller/subsystem/hilbertshotel/proc/modify_trusted_guests(room_number, mob/user, action, target_name)
	if(!room_data["[room_number]"])
		return FALSE
	var/list/local_room_data = room_data["[room_number]"]
	switch(action)
		if("add")
			if(!user.mind)
				return FALSE
			if(user.mind in local_room_data["access_restrictions"]["trusted_guests"])
				return FALSE
			if(user.mind == local_room_data["access_restrictions"]["room_owner"])
				return FALSE
			local_room_data["access_restrictions"]["trusted_guests"] += user.mind
		if("remove")
			var/list/trusted_guests = local_room_data["access_restrictions"]["trusted_guests"]
			for(var/datum/mind/guest_mind in trusted_guests)
				if(guest_mind.name == target_name)
					trusted_guests -= guest_mind
					break
		if("clear")
			local_room_data["access_restrictions"]["trusted_guests"] = list()
		if("transfer")
			local_room_data["access_restrictions"]["room_owner"] = user.mind
	return TRUE
