/datum/mind
	/// Is our mind currently clocked out of their job?
	var/clocked_out_of_job = FALSE

/datum/computer_file/program/crew_self_serve
	filename = "plexagonselfserve"
	filedesc = "Plexagon Punch Clock"
	downloader_category = PROGRAM_CATEGORY_SECURITY
	program_open_overlay = "id"
	extended_desc = "Allows crew members to remotely punch in or out of their job assignment, giving the impression they have a semblance of control over their lives."
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

/datum/computer_file/program/crew_self_serve/on_start(mob/living/user)
	. = ..()
	if(!.)
		return FALSE

	if(!computer)
		stack_trace("[src] is running on a null computer!")
		return FALSE

	computer.crew_manifest_update = TRUE
	register_signals()
	if(computer.stored_id)
		authenticate(id_card = computer.stored_id)

	return TRUE

/datum/computer_file/program/crew_self_serve/kill_program(mob/user)
	UnregisterSignal(computer, COMSIG_MODULAR_COMPUTER_INSERTED_ID)
	UnregisterSignal(computer, COMSIG_MODULAR_COMPUTER_REMOVED_ID)
	return ..()

/datum/computer_file/program/crew_self_serve/proc/register_signals()
	RegisterSignal(computer, COMSIG_MODULAR_COMPUTER_INSERTED_ID, PROC_REF(id_changed))
	RegisterSignal(computer, COMSIG_MODULAR_COMPUTER_REMOVED_ID, PROC_REF(id_changed))

/datum/computer_file/program/crew_self_serve/proc/id_changed(source, obj/item/card/id/id_card, mob/user)
	SIGNAL_HANDLER
	authenticate(id_card = computer.stored_id)

/**
 * Authenticates the program based on the specific ID card.
 *
 * Arguments:
 * * auth_card - The ID card to attempt to authenticate under.
 */
/datum/computer_file/program/crew_self_serve/proc/authenticate(source, obj/item/card/id/id_card)
	if(!id_card)
		authenticated_card = null
		authenticated_user = null
	else
		authenticated_card = id_card
		authenticated_user = "[authenticated_card.name]"

	computer.update_static_data_for_all_viewers()

/// Clocks out the currently inserted ID Card
/datum/computer_file/program/crew_self_serve/proc/clock_out()
	if(!authenticated_card)
		return FALSE

	var/important = job_is_CMD_or_SEC()
	if(important)
		if(tgui_alert(usr, "You are a member of security and/or command, make sure that you ahelp before punching out! If you decide to punch back in later, you will need to go to the Head of Personnel or Head of Security. Do you wish to continue?", "[src]", list("No", "Yes")) != "Yes")
			return FALSE

	if(istype(authenticated_card.trim, /datum/id_trim/job/prisoner))
		tgui_alert(usr, "You cannot clock out of prison. Nice try, inmate.")
		return TRUE

	log_econ("[authenticated_card.registered_name] clocked out from role [authenticated_card.get_trim_assignment()]")
	var/datum/component/off_duty_timer/timer_component = authenticated_card.AddComponent(/datum/component/off_duty_timer, TIMECLOCK_COOLDOWN)
	if(important)
		timer_component.hop_locked = TRUE
		log_econ("[authenticated_card.registered_name] job slot [authenticated_card.get_trim_assignment()] has been locked from clocking back in")
		message_admins("[ADMIN_LOOKUPFLW(usr)] clocked out from [span_comradio("restricted role")]: [authenticated_card.get_trim_assignment()].")
	else
		message_admins("[ADMIN_LOOKUPFLW(usr)] clocked out from role: [authenticated_card.get_trim_assignment()].")

	var/current_assignment = authenticated_card.assignment
	var/datum/id_trim/job/current_trim = authenticated_card.trim
	var/datum/job/clocked_out_job = current_trim.job
	SSjob.FreeRole(clocked_out_job.title)

	var/obj/machinery/announcement_system/system = pick(GLOB.announcement_systems)
	system.broadcast("[authenticated_card.registered_name], [current_assignment] has gone off-duty.", list())
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
		computer.say("[capitalize(clocked_in_job.title)] has no free slots available, unable to punch in!")
		return FALSE


	SSid_access.apply_trim_to_card(authenticated_card, id_component.stored_trim.type, TRUE)
	authenticated_card.assignment = id_component.stored_assignment

	log_econ("[authenticated_card.registered_name] clocked in to role [authenticated_card.get_trim_assignment()]")
	message_admins("[ADMIN_LOOKUPFLW(usr)] clocked in to role: [authenticated_card.get_trim_assignment()].")

	var/obj/machinery/announcement_system/system = pick(GLOB.announcement_systems)
	system.broadcast("[authenticated_card.registered_name] has returned to assignment [authenticated_card.assignment].", list())
	GLOB.manifest.modify(authenticated_card.registered_name, authenticated_card.assignment, authenticated_card.get_trim_assignment())

	qdel(id_component)
	authenticated_card.update_label()
	computer.update_static_data_for_all_viewers()

	return TRUE

/// Is the job of the inserted ID being worked by a job that in an important department? If so, this proc will return TRUE.
/datum/computer_file/program/crew_self_serve/proc/job_is_CMD_or_SEC()
	if(!authenticated_card)
		return FALSE

	var/datum/id_trim/job/current_trim = authenticated_card.trim
	var/datum/job/clocked_in_job = current_trim.job
	if((/datum/job_department/command in clocked_in_job.departments_list) || (/datum/job_department/security in clocked_in_job.departments_list))
		return TRUE

	return FALSE

/// Is the inserted ID on cooldown? return -1 if invalid ID, 0 if ID is not on cooldown, and remaining time until cooldown ends otherwise.
/datum/computer_file/program/crew_self_serve/proc/id_cooldown_check()
	if(!authenticated_card)
		return -1

	var/datum/component/off_duty_timer/id_component = authenticated_card.GetComponent(/datum/component/off_duty_timer)
	if(!id_component)
		return -1

	if(!id_component.on_cooldown)
		return 0

	return max(TIMECLOCK_COOLDOWN - (world.time - id_component.init_time), 0)

/// Returns the remaining time left for the ID, as a minutes:seconds string.
/datum/computer_file/program/crew_self_serve/proc/id_cooldown_minutes_seconds()
	var/cooldownTics = id_cooldown_check()
	if (cooldownTics == -1)
		return "--:--"

	var/cooldownMinutes = num2text(floor(cooldownTics / (1 MINUTES)))
	if (length(cooldownMinutes) == 1)
		cooldownMinutes = addtext("0", cooldownMinutes)
	var/cooldownSeconds = num2text(floor(cooldownTics / (1 SECONDS)) % (60))
	if (length(cooldownSeconds) == 1)
		cooldownSeconds = addtext("0", cooldownSeconds)

	return addtext(cooldownMinutes, ":", cooldownSeconds)

/// Is the inserted ID locked from clocking in? returns TRUE if the ID is locked
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

/// Places any items inside of the `eligible_items` list to a lockbox, to be opened by the player when they clock back in.
/datum/computer_file/program/crew_self_serve/proc/secure_items(mob/living/carbon/human/human_user, list/eligible_items)
	var/obj/item/storage/lockbox/timeclock/shame_box = new /obj/item/storage/lockbox/timeclock(get_turf(authenticated_card), authenticated_card)
	if(isnull(shame_box) || !istype(shame_box))
		stack_trace("Failed to create lockbox for [authenticated_card.registered_name] trim clock-out.")
		return FALSE

	var/list/held_contents = human_user.get_contents()
	if(!held_contents)
		CRASH("Lockbox secure items: no items found on [authenticated_card.registered_name]. that's probably incorrect!")

	var/list/shamebox_items = list()
	for(var/obj/item/found_item in held_contents)
		if(!is_type_in_list(found_item, eligible_items))
			continue
		human_user.transferItemToLoc(found_item, shame_box, force = TRUE, silent = TRUE)
		LAZYADD(shamebox_items, "[found_item.name]")

	if(!length(shame_box.contents))
		qdel(shame_box)
		return TRUE

	shame_box.locked_contents = english_list(shamebox_items)
	do_harmless_sparks(number = 4, source = shame_box)
	to_chat(human_user, span_warning("You feel weight lifted off your shoulders as items are teleported off your body!"))
	to_chat(human_user, span_notice("Items moved to lockbox: [shame_box.locked_contents]."))
	computer.say(
		message = "A service contract between Nanotrasen and Lustwish stipulates that company issued batons, masks, restraints, and other equipment are not to be used for recreational purposes. Employees may purchase recreational provisions from an approved vendor. Your restricted items have been placed in a lockbox to be retrieved after punch in.",
		forced = TRUE,
	)
	return TRUE

/datum/computer_file/program/crew_self_serve/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	switch(action)
		if("PRG_change_status")
			if(!authenticated_card)
				return

			if(off_duty_check())
				if(!authenticated_card)
					return

				if(!clock_in())
					return

				var/datum/mind/user_mind = usr.mind
				if(user_mind)
					user_mind.clocked_out_of_job = FALSE

				computer.update_static_data_for_all_viewers()
				playsound(computer, 'sound/machines/ping.ogg', 50, FALSE)

			else
				if(!clock_out())
					return

				var/mob/living/carbon/human/human_user = usr
				if(human_user)
					secure_items(human_user, eligible_items = SELF_SERVE_RETURN_ITEMS)

				var/datum/mind/user_mind = usr.mind
				if(user_mind)
					user_mind.clocked_out_of_job = TRUE

				computer.update_static_data_for_all_viewers()
				playsound(computer, 'sound/machines/ping.ogg', 50, FALSE)
				computer.remove_id(human_user, silent = TRUE)
				authenticate(id_card = computer.stored_id)

			return TRUE

		if("PRG_eject_id")
			var/mob/living/carbon/human/human_user = usr
			if(human_user)
				computer.remove_id(human_user, silent = TRUE)
				authenticate(id_card = computer.stored_id)

			return TRUE

/datum/computer_file/program/crew_self_serve/ui_data(mob/user)
	var/list/data = list()
	data["authCard"] = authenticated_card ? authenticated_card.name : "-----"
	data["authCardHOPLocked"] = id_locked_check()
	data["authCardTimeLocked"] = id_cooldown_check() > 0
	data["authCardTimeRemaining"] = id_cooldown_minutes_seconds()

	return data

/datum/computer_file/program/crew_self_serve/ui_static_data(mob/user)
	var/list/data = list()
	data["stationAlertLevel"] = SSsecurity_level.get_current_level_as_text()
	if(authenticated_card)
		data["authIDName"] = authenticated_card.registered_name ? authenticated_card.registered_name : "-----"
		data["authIDRank"] = authenticated_card.assignment ? authenticated_card.assignment : "Unassigned"
		data["authCardHOPLocked"] = id_locked_check()
		data["trimClockedOut"] = off_duty_check()
		if(authenticated_card.trim)
			var/datum/id_trim/card_trim = authenticated_card.trim
			data["trimAssignment"] = card_trim.assignment ? card_trim.assignment : ""
		else
			data["trimAssignment"] = ""
	else
		data["authIDName"] = ""
		data["authIDRank"] = ""
		data["trimClockedOut"] = FALSE
		data["trimAssignment"] = ""

	return data
