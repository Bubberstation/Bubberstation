#define ACTION_ADD "add"
#define ACTION_REMOVE "remove"
#define ACTION_CLEAR "clear"
#define ACTION_TRANSFER "transfer"

/obj/machinery/room_controller
	name = "Hilbert's Hotel Room Controller"
	desc = "A mysterious device."
	icon = 'modular_zzplurt/icons/obj/machines/room_controller.dmi'
	icon_state = "room_controller"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	use_power = NO_POWER_USE
	rad_insulation = RAD_FULL_INSULATION
	integrity_failure = 0
	max_integrity = INFINITY

	/// The number of the hotel room
	var/room_number
	/// Data of the current room as an associative list
	var/list/current_room_data
	/// The ID card inserted into the controller
	var/inserted_id
	/// The bluespace box inside the controller
	var/obj/item/storage/box/bluespace/bluespace_box
	/// List of roles that are disallowed to use the "Depart" feature
	var/static/list/disallowed_roles = list(
		/datum/job/ghostcafe,
		/datum/job/hotel_staff,
		/datum/job/captain,
	)
	/// Vanity desctiption tags
	var/static/list/vanity_tags = list(
		", scribbled all around it",
		". There's a small bloody fingerprint on it",
		". The corner is torn off",
		". It's covered in a thick layer of dust",
		". The writing is smudged, as if someone was in a hurry. You squint your eyes..",
		". The writing is faded",
		". The writing is barely visible",
		". The corner is burnt",
	)


/obj/machinery/room_controller/examine(mob/user)
	. = ..()
	. += span_info("The screen displays [!room_number ? "the word \"Error\". Nothing else." : "some small text and a large number [room_number]."]")

/obj/machinery/room_controller/Initialize()
	. = ..()
	if(!SShilbertshotel.initialized)
		message_admins("Attention: [ADMIN_VERBOSEJMP(src)] at room [room_number] failed to locate the main hotel sphere!")
		return INITIALIZE_HINT_QDEL
	bluespace_box = new /obj/item/storage/box/bluespace(src)
	bluespace_box.origin_controller = WEAKREF(src)
	inserted_id = null
	desc += span_info("There is an old tag on the back of the device[pick(vanity_tags)]. 'Last Serviced: 1025-[pick("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")]-[pick("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "10", "31")]'.")

	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, say), "Welcome to Hilbert's Hotel."), 3 SECONDS)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, say), "Enjoy your stay!"), 5 SECONDS)
	update_appearance()

/obj/machinery/room_controller/update_overlays()
	. = ..()
	var/list/to_display = list()

	if(!room_number)
		var/mutable_appearance/error = mutable_appearance(icon, "n_err")
		error.pixel_x = 9
		error.pixel_y = -11
		. += error
	else
		var/room_text = "[room_number]"
		to_display = list()

		if(length(room_text) > 3)
			to_display = list(room_text[1], room_text[2], "dot")
		else
			for(var/i in 1 to min(length(room_text), 3))
				to_display += room_text[i]

		var/x_offset = 9
		for(var/digit in to_display)
			var/mutable_appearance/digit_overlay = mutable_appearance(icon, "n_[digit]")
			digit_overlay.pixel_x = x_offset
			digit_overlay.pixel_y = -11
			. += digit_overlay
			x_offset += 4

	. += emissive_appearance(icon, "screen_dim", src)
	if(bluespace_box)
		. += mutable_appearance(icon, "box_inserted")

/// Checks if the player's role allows them to depart.
/obj/machinery/room_controller/proc/can_depart(mob/living/carbon/human/this_mob)
	var/datum/job/job = this_mob.mind?.assigned_role
	if(!job)
		return FALSE
	return !(job.type in disallowed_roles)

/obj/machinery/room_controller/interact(mob/user)
	. = ..()
	ui_interact(user)

/obj/machinery/room_controller/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HilbertsHotelRoomControl")
		ui.open()

/obj/machinery/room_controller/ui_data(mob/user)
	var/list/data = list()

	var/obj/item/card/id/this_id = inserted_id
	data["id_card"] = this_id?.registered_name
	data["bluespace_box"] = !isnull(bluespace_box)

	if(!room_number || !SShilbertshotel.room_data["[room_number]"])
		return data

	current_room_data = SShilbertshotel.room_data["[room_number]"]
	data["room_number"] = room_number
	data["room_preferences"] = current_room_data["room_preferences"]
	data["access_restrictions"] = current_room_data["access_restrictions"]
	data["user"] = user
	return data

/obj/machinery/room_controller/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.) // Orange eye; updates but is not interactive
		return

	switch(action)
		if("eject_id")
			if(inserted_id)
				eject_id(inserted_id, usr)
				return TRUE
		if("eject_box")
			if(bluespace_box)
				bluespace_box.forceMove(drop_location())
				bluespace_box = null
				update_appearance()
				return TRUE
		if("depart")
			if(!inserted_id || !can_depart(usr))
				playsound(src, 'sound/machines/terminal/terminal_error.ogg', 50, TRUE)
				say("Access denied.")
				addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, say), "Please contact the hotel staff for further assistance."), 3 SECONDS)
				return FALSE
			depart_user(usr)
			return TRUE

	if(!room_number || !SShilbertshotel.room_data["[room_number]"])
		playsound(src, 'sound/machines/terminal/terminal_error.ogg', 50, TRUE)
		say("Room number out of array range.")
		addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, say), "Please contact the hotel staff for further assistance."), 3 SECONDS)
		return

	var/list/room_data = SShilbertshotel.room_data["[room_number]"]
	switch(action)
		if("toggle_visibility")
			room_data["room_preferences"]["visibility"] = !room_data["room_preferences"]["visibility"]
			. = TRUE
		if("toggle_status")
			var/current_status = room_data["room_preferences"]["status"]
			switch(current_status)
				if(ROOM_OPEN)
					room_data["room_preferences"]["status"] = ROOM_GUESTS_ONLY
				if(ROOM_GUESTS_ONLY)
					room_data["room_preferences"]["status"] = ROOM_CLOSED
				if(ROOM_CLOSED)
					room_data["room_preferences"]["status"] = ROOM_OPEN
			. = TRUE
		if("toggle_privacy")
			room_data["room_preferences"]["privacy"] = !room_data["room_preferences"]["privacy"]
			. = TRUE
		if("update_description")
			room_data["room_preferences"]["description"] = params["description"]
			. = TRUE
		if("update_name")
			room_data["room_preferences"]["name"] = params["name"]
			. = TRUE
		if("set_icon")
			room_data["room_preferences"]["icon"] = params["icon"]
			. = TRUE
		if("modify_trusted_guests")
			modify_trusted_guests(usr, params["action"], params["user"])
			. = TRUE
	if(.)
		SStgui.update_uis(src)
		SEND_SIGNAL(SShilbertshotel, COMSIG_HILBERT_ROOM_UPDATED, list("action" = action, "room" = room_number))

/obj/machinery/room_controller/emp_act(severity)
	return

/obj/machinery/room_controller/proc/eject_id(id, user)
	var/obj/item/card/id/this_id = id
	var/mob/living/carbon/human/this_humanoid = user
	this_id.forceMove(drop_location())
	if(this_humanoid.CanReach(this_id))
		this_humanoid.put_in_hands(this_id)
	inserted_id = null
	update_appearance()
	SStgui.update_uis(src)
	return TRUE

/obj/machinery/room_controller/attackby(obj/item/item, mob/user, params)
	if(istype(item, /obj/item/card/id))
		if(inserted_id)
			to_chat(user, span_warning("There's already an ID card inside!"))
			return
		if(!user.transferItemToLoc(item, src))
			return
		inserted_id = item
		playsound(src, 'sound/machines/terminal/terminal_insert_disc.ogg', 50, TRUE)
		update_appearance()
		SStgui.update_uis(src)
		return TRUE
	if(istype(item, /obj/item/storage/box/bluespace))
		if(bluespace_box)
			return
		if(!user.transferItemToLoc(item, src))
			return
		bluespace_box = item
		update_appearance()
		return TRUE
	return ..()

/obj/machinery/room_controller/click_ctrl(mob/user)
	. = ..()
	if(inserted_id)
		if(!eject_id(inserted_id, usr))
			return
		playsound(src, 'sound/machines/terminal/terminal_eject.ogg', 50, TRUE)
		return TRUE
	return ..()

/obj/machinery/room_controller/directional/north
	pixel_x = 0
	pixel_y = 28
	dir = NORTH

/obj/machinery/room_controller/directional/south
	pixel_x = 0
	pixel_y = -28
	dir = SOUTH

/obj/machinery/room_controller/directional/east
	pixel_x = 28
	pixel_y = 0
	dir = EAST

/obj/machinery/room_controller/directional/west
	pixel_x = -28
	pixel_y = 0
	dir = WEST

/obj/machinery/computer/cryopod/announce(message_type, user, rank)
	if(message_type == "CRYO_DEPART")
		radio.talk_into(src, "[user][rank ? ", [rank]" : ""] has departed from the station.", announcement_channel)
	..()

/obj/machinery/room_controller/proc/depart_user(mob/living/departing_mob)
	var/obj/item/card/id/depart_id = inserted_id
	if(!depart_id || !istype(departing_mob) || departing_mob.stat == DEAD)
		return FALSE

	var/job_name = depart_id.assignment
	var/real_name = departing_mob.real_name

	SSjob.FreeRole(job_name)

	if(!length(GLOB.cryopod_computers))
		message_admins("Attention: [ADMIN_VERBOSEJMP(src)] at room [room_number] failed to locate the station cryopod computer!")
		playsound(src, 'sound/machines/terminal/terminal_error.ogg', 10, TRUE)
		say("No valid destination points specified.")
		addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, say), "Please contact the hotel staff for further assistance."), 2 SECONDS)
		return
	var/obj/machinery/computer/cryopod/control_computer = GLOB.cryopod_computers[1] // locating the station cryopod computer
	if(control_computer)
		control_computer.announce("CRYO_DEPART", real_name, job_name)
		control_computer.frozen_crew += list(list("name" = real_name, "job" = job_name))

	bluespace_box.return_to_station(real_name)
	bluespace_box.forceMove(control_computer)
	control_computer.frozen_item += bluespace_box
	if(departing_mob.mind)
		departing_mob.mind.objectives = list()
		departing_mob.mind.special_role = null
	visible_message(span_notice("[src] whizzes as it swallows the ID card."))
	playsound(src, 'sound/machines/terminal/terminal_success.ogg', 50, TRUE)
	say("Transfer successful.")
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, say), "Thank you for your stay!"), 2 SECONDS)
	message_admins("[departing_mob.ckey]/[departing_mob.real_name] departed from room [room_number] as [departing_mob.job].")

	bluespace_box = new /obj/item/storage/box/bluespace(src)
	bluespace_box.origin_controller = WEAKREF(src)

	if(inserted_id)
		qdel(inserted_id)
		inserted_id = null
		update_appearance()
		SStgui.update_uis(src)
	return TRUE

/obj/machinery/room_controller/proc/modify_trusted_guests(this_user, action, target_name)
	if(!room_number || !SShilbertshotel.room_data["[room_number]"])
		playsound(src, 'sound/machines/terminal/terminal_error.ogg', 50, TRUE)
		return
	SShilbertshotel.modify_trusted_guests(room_number, this_user, action, target_name)
	playsound(src, 'sound/machines/terminal/terminal_processing.ogg', 50, TRUE)
	if(action == ACTION_TRANSFER)
		say("Room ownership transferred.")

#undef ACTION_ADD
#undef ACTION_REMOVE
#undef ACTION_CLEAR
#undef ACTION_TRANSFER
