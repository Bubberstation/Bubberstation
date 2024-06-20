/datum/computer_file/program/crew_self_serve
	filename = "plexagonselfserve"
	filedesc = "Plexagon Crew Self Serve"
	downloader_category = PROGRAM_CATEGORY_SECURITY
	program_open_overlay = "generic"
	extended_desc = "Lets crew manage their own HR, giving the impression they have a semblance of control over their employment."
	program_flags = PROGRAM_ON_NTNET_STORE
	size = 4
	tgui_id = "NtosSelfServe"
	program_icon = "id-card"
	/// The ID card used to authenticate.
	var/obj/item/card/id/authenticated_card
	/// The name of the registered user, related to `authenticated_card`.
	var/authenticated_user
	///What trim is applied to inserted IDs?
	var/target_trim = /datum/id_trim/job/assistant


/**
 * Authenticates the program based on the specific ID card.
 *
 * Arguments:
 * * user - Program's user.
 * * auth_card - The ID card to attempt to authenticate under.
 */
/datum/computer_file/program/crew_self_serve/proc/authenticate(mob/user, obj/item/card/id/id_card)
	if(isnull(id_card))
		return FALSE

	authenticated_card = id_card
	authenticated_user = "[authenticated_card.name]"
	return TRUE

/datum/computer_file/program/crew_self_serve/on_start(mob/living/user)
	. = ..()
	if(!.)
		return FALSE
	computer.crew_manifest_update = TRUE

	if(!computer || !computer.computer_id_slot)
		to_chat(user, span_warning("Plexagon: Login failed, no ID card found!"))
		playsound(computer, 'sound/machines/buzz-sigh.ogg', 50, FALSE)
		return FALSE
	else if(authenticate(user, computer.computer_id_slot))
		return TRUE
	else
		return FALSE

/// Clocks out the currently inserted ID Card
/datum/computer_file/program/crew_self_serve/proc/clock_out()
	if(!authenticated_card)
		return FALSE

	var/datum/component/off_duty_timer/timer_component = authenticated_card.AddComponent(/datum/component/off_duty_timer, TIMECLOCK_COOLDOWN)
	if(important_job_check())
		timer_component.hop_locked = TRUE
		log_admin("[authenticated_card.registered_name] clocked out as a head of staff and/or command")

	var/current_assignment = authenticated_card.assignment
	var/datum/id_trim/job/current_trim = authenticated_card.trim
	var/datum/job/clocked_out_job = current_trim.job
	SSjob.FreeRole(clocked_out_job.title)

	var/obj/machinery/announcement_system/system = pick(GLOB.announcement_systems)
	system.broadcast("[authenticated_card.registered_name], [current_assignment] has gone off-duty.", list(RADIO_CHANNEL_COMMON))
	computer.update_static_data_for_all_viewers()

	SSid_access.apply_trim_to_card(authenticated_card, target_trim, TRUE)
	authenticated_card.assignment = "Off-Duty " + current_assignment
	authenticated_card.update_label()

	GLOB.manifest.modify(authenticated_card.registered_name, authenticated_card.assignment, authenticated_card.get_trim_assignment())
	return TRUE

/// Clocks the currently inserted ID Card back in
/datum/computer_file/program/crew_self_serve/proc/clock_in()
	if(!authenticated_card)
		return FALSE

	if(id_cooldown_check())
		return FALSE

	var/datum/component/off_duty_timer/id_component = authenticated_card.GetComponent(/datum/component/off_duty_timer)
	if(!id_component)
		return FALSE

	var/datum/job/clocked_in_job = id_component.stored_trim.job
	if(!SSjob.OccupyRole(clocked_in_job.title))
		computer.say("[capitalize(clocked_in_job.title)] has no free slots available, unable to clock in!")
		return FALSE


	SSid_access.apply_trim_to_card(authenticated_card, id_component.stored_trim.type, TRUE)
	authenticated_card.assignment = id_component.stored_assignment

	var/obj/machinery/announcement_system/system = pick(GLOB.announcement_systems)
	system.broadcast("[authenticated_card.registered_name], [authenticated_card.assignment] has returned to duty.", list(RADIO_CHANNEL_COMMON))
	GLOB.manifest.modify(authenticated_card.registered_name, authenticated_card.assignment, authenticated_card.get_trim_assignment())

	qdel(id_component)
	authenticated_card.update_label()
	computer.update_static_data_for_all_viewers()

	return TRUE

/// Is the job of the inserted ID being worked by a job that in an important department? If so, this proc will return TRUE.
/datum/computer_file/program/crew_self_serve/proc/important_job_check()
	if(!authenticated_card)
		return FALSE

	var/datum/id_trim/job/current_trim = authenticated_card.trim
	var/datum/job/clocked_in_job = current_trim.job
	if((/datum/job_department/command in clocked_in_job.departments_list) || (/datum/job_department/security in clocked_in_job.departments_list))
		return TRUE

	return FALSE

/// Is the inserted ID on cooldown? returns TRUE if the ID has a cooldown
/datum/computer_file/program/crew_self_serve/proc/id_cooldown_check()
	if(!authenticated_card)
		return FALSE

	var/datum/component/off_duty_timer/id_component = authenticated_card.GetComponent(/datum/component/off_duty_timer)
	if(!id_component)
		return FALSE

	if(!id_component.on_cooldown)
		return FALSE

	return TRUE

/// Is the inserted ID on cooldown? returns TRUE if the ID has a cooldown
/datum/computer_file/program/crew_self_serve/proc/id_locked_check()
	if(!authenticated_card)
		return FALSE

	var/datum/component/off_duty_timer/id_component = authenticated_card.GetComponent(/datum/component/off_duty_timer)
	if(!id_component)
		return FALSE

	if(id_component.hop_locked)
		return TRUE

	return FALSE

/// Is the inserted ID off-duty? Returns true if the ID is off-duty
/datum/computer_file/program/crew_self_serve/proc/off_duty_check()
	if(!authenticated_card)
		return FALSE

	var/datum/component/off_duty_timer/id_component = authenticated_card.GetComponent(/datum/component/off_duty_timer)
	if(!id_component)
		return FALSE

	return TRUE

/datum/computer_file/program/crew_self_serve/kill_program(mob/user)
	computer.crew_manifest_update = FALSE
	if(!isnull(authenticated_card))
		authenticated_card = null

	return ..()

/datum/computer_file/program/crew_self_serve/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	switch(action)
		if("PRG_change_status")
			if(off_duty_check())
				if(!(clock_in()))
					return
				log_admin("[key_name(usr)] clocked in as \an [authenticated_card.assignment].")

				var/datum/mind/user_mind = usr.mind
				if(user_mind)
					user_mind.clocked_out_of_job = FALSE

			else
				log_admin("[key_name(usr)] clocked out as \an [authenticated_card.assignment].")
				clock_out()
				var/mob/living/carbon/human/human_user = usr
				if(human_user)
					var/obj/item/storage/lockbox/timeclock/shame_box = new /obj/item/storage/lockbox/timeclock(src, authenticated_card)
					human_user.secure_items(eligible_items = SELF_SERVE_RETURN_ITEMS, incoming_box = shame_box)

				var/datum/mind/user_mind = usr.mind
				if(user_mind)
					user_mind.clocked_out_of_job = TRUE

				if(important_job_check())
					message_admins("[key_name(usr)] has clocked out as a head of staff. [ADMIN_JMP(authenticated_card)]")

			computer.update_static_data_for_all_viewers()
			playsound(computer, 'sound/machines/ping.ogg', 50, FALSE)
			return TRUE

/datum/computer_file/program/crew_self_serve/ui_data(mob/user)
	var/list/data = list()
	data["authCard"] = authenticated_card ? authenticated_card.name : "-----"
	data["authCardTimeLocked"] = id_cooldown_check()

	return data

/datum/computer_file/program/crew_self_serve/ui_static_data(mob/user)
	var/list/data = list()
	if(authenticated_card)
		data["authIDName"] = authenticated_card.registered_name ? authenticated_card.registered_name : "-----"
		data["authIDRank"] = authenticated_card.assignment ? authenticated_card.assignment : "Unassigned"
		data["authCardHOPLocked"] = id_locked_check()
		data["stationAlertLevel"] = SSsecurity_level.get_current_level_as_text()
		data["trimClockedOut"] = off_duty_check()
		if(authenticated_card.trim)
			var/datum/id_trim/card_trim = authenticated_card.trim
			data["trimAssignment"] = card_trim.assignment ? card_trim.assignment : ""
		else
			data["trimAssignment"] = ""

	return data

/// Places any items inside of the `eligible_items` list to a lockbox, to be opened by the player when they clock back in.
/mob/living/carbon/human/proc/secure_items(list/eligible_items, obj/incoming_box)
	var/obj/item/storage/lockbox/timeclock/shame_box = incoming_box
	if(isnull(shame_box) || !istype(shame_box))
		stack_trace("Failed to create lockbox for [name] trim clock-out.")
		return FALSE

	var/list/held_contents = get_contents()
	if(!held_contents)
		CRASH("Lockbox secure items: no items found on [name]. that's probably incorrect!")

	for(var/obj/item/found_item in held_contents)
		if(!is_type_in_list(found_item, eligible_items))
			continue
		transferItemToLoc(found_item, shame_box, force = TRUE, silent = TRUE)

	if(!length(shame_box.contents))
		qdel(shame_box)
	else
		put_in_hands(shame_box)

	return TRUE
