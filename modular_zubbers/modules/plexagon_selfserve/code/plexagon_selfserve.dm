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
	/// The name/assignment combo of the ID card used to authenticate.
	var/authenticated_card
	/// The name of the registered user, related to `authenticated_card`.
	var/authenticated_user

/**
 * Authenticates the program based on the specific ID card.
 *
 * If the card has ACCESS_CHANGE_IDs, it authenticates with all options.
 * Otherwise, it authenticates depending on SSid_access.sub_department_managers_tgui
 * compared to the access on the supplied ID card.
 * Arguments:
 * * user - Program's user.
 * * auth_card - The ID card to attempt to authenticate under.
 */

/datum/computer_file/program/crew_self_serve/proc/authenticate(mob/user, obj/item/card/id/id_card)
	if(isnull(id_card))
		return FALSE

	authenticated_card = "[id_card.name]"
	return TRUE

/datum/computer_file/program/crew_self_serve/on_start(mob/living/user)
	. = ..()
	if(!.)
		return FALSE
	playsound(computer, 'sound/machines/terminal_processing.ogg', 50, FALSE)
	computer.crew_manifest_update = TRUE

	var/obj/item/card/id/inserted_card = computer.computer_id_slot
	if(!computer || !inserted_card)
		to_chat(world, span_yellowteamradio("ERP: failed login. no card found"))
		playsound(computer, 'sound/machines/buzz-sigh.ogg', 50, FALSE)
		return TRUE
	else if(authenticate(user, inserted_card))
		to_chat(world, span_yellowteamradio("ERP: login success [user] [inserted_card.name]"))
		return TRUE

/datum/computer_file/program/crew_self_serve/kill_program(mob/user)
	computer.crew_manifest_update = FALSE
	var/obj/item/card/id/inserted_card = computer.computer_id_slot
	if(!isnull(inserted_card))
		to_chat(world, span_yellowteamradio("ERP: attempting manifest update [inserted_card.registered_name] [inserted_card.assignment]"))
		if(!GLOB.manifest.modify_rank(inserted_card.registered_name, inserted_card.assignment))
			to_chat(world, span_yellowteamradio("ERP: manifest update FAILED"))
		else
			to_chat(world, span_yellowteamradio("ERP: manifest update SUCCESS"))

	return ..()

/datum/computer_file/program/crew_self_serve/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/mob/user = usr
	var/obj/item/card/id/inserted_card = computer.computer_id_slot

	switch(action)
		// Change assignment
		if("PRG_assign")
			if(!computer || !authenticated_card || !inserted_card)
				return TRUE
			var/new_asignment = trim(sanitize(params["assignment"]), MAX_NAME_LEN)
			inserted_card.assignment = new_asignment
			playsound(computer, 'sound/machines/terminal_success.ogg', 50, FALSE)
			inserted_card.update_label()
			return TRUE

/datum/computer_file/program/crew_self_serve/ui_data(mob/user)
	var/list/data = list()

	var/obj/item/card/id/inserted_id = computer.computer_id_slot
	data["authIDName"] = inserted_id ? inserted_id.name : "-----"
	data["authenticatedUser"] = authenticated_card
	data["id_name"] = inserted_id ? inserted_id.name : "-----"
	if(inserted_id)
		data["id_rank"] = inserted_id.assignment ? inserted_id.assignment : "Unassigned"
		data["id_owner"] = inserted_id.registered_name ? inserted_id.registered_name : "-----"
		if(inserted_id.trim)
			var/datum/id_trim/card_trim = inserted_id.trim
			data["hasTrim"] = TRUE
			data["trimAssignment"] = card_trim.assignment ? card_trim.assignment : ""
			data["trimAccess"] = card_trim.access ? card_trim.access : list()
		else
			data["hasTrim"] = FALSE
			data["trimAssignment"] = ""
			data["trimAccess"] = list()

	return data

/// Edits the job title of the found record.
/datum/manifest/proc/modify_rank(name, assignment)
	var/datum/record/crew/target = find_record(name)
	if(!target)
		return FALSE

	target.rank = assignment
	return TRUE
