// ALTERNATIVE_JOB_TITLES

/datum/job/proc/get_chosen_alt_title(client/player_client)
	return player_client?.prefs.alt_job_titles?[title] || title

/datum/job/proc/format_chosen_alt_title(chosen_title)
	return chosen_title

/datum/job/security_officer
	/// If set, shared security officer alt titles display as "Title (Department)".
	var/alt_title_department_suffix

/datum/job/security_officer/format_chosen_alt_title(chosen_title)
	if(isnull(alt_title_department_suffix))
		return ..()

	if(chosen_title == title)
		return ..()

	var/datum/job/security_officer/security_officer = SSjob.get_job(JOB_SECURITY_OFFICER)
	if(chosen_title in security_officer?.alt_titles)
		return "[chosen_title] ([alt_title_department_suffix])"

	return ..()

/**
 * Shows a list of all current and future polls and buttons to edit or delete them or create a new poll.
 *
 * All extra functionality to run on new player mobs, in a place where we actually have the client,
 * and haven't called COMSIG_GLOB_JOB_AFTER_SPAWN yet, so we are running before the wallet trait,
 * and other things that rely on items already being settled.
 */
/datum/controller/subsystem/job/proc/setup_alt_job_items(mob/living/carbon/human/equipping, datum/job/job, client/player_client)
	if(!player_client)
		return

	if(!ishuman(equipping))
		return

	var/chosen_title = job.format_chosen_alt_title(job.get_chosen_alt_title(player_client))

	var/obj/item/card/id/card = equipping.wear_id
	if(istype(card))
		card.assignment = chosen_title
		card.update_label()

	// Look for PDA in belt or L pocket
	var/obj/item/modular_computer/pda/pda = equipping.belt
	if(!istype(pda))
		pda = equipping.l_store
	if(istype(pda))
		pda.saved_job = chosen_title
		pda.UpdateDisplay()
