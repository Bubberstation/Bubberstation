/datum/dynamic_ruleset/midround/from_living/
	var/offer_name = "Evildoer"
/datum/dynamic_ruleset/midround/from_living/autotraitor
	offer_name = "Syndicate Agent"
/datum/dynamic_ruleset/midround/from_living/execute()
	var/mob/living/M = pick(candidates)
	var/list/tracked_messengers = list()
	if(M)
		var/obj/item/modular_computer/pda/pda = locate() in M.contents
		var/datum/computer_file/program/messenger/target_app = locate() in pda.stored_files
		message_admins("Prompting [ADMIN_LOOKUPFLW(M)] for [name].")
		target_app.send_recruiter_message(sender = M,  \
			 offer = offer_name
		)
		tracked_messengers |= target_app
	// This technically goes two seconds after they click yes. Or 62 seconds after the initial offer.
	addtimer(CALLBACK(src, PROC_REF(follow_up_on_job_offers), tracked_messengers, M), 2 SECONDS)
/datum/dynamic_ruleset/midround/from_living/autotraitor/execute() // We have to do this because supercalling may run the wrong code.
	var/mob/living/M = pick(candidates)
	var/list/tracked_messengers = list()
	if(M)
		var/obj/item/modular_computer/pda/pda = locate() in M.contents
		var/datum/computer_file/program/messenger/target_app = locate() in pda.stored_files
		message_admins("Prompting [ADMIN_LOOKUPFLW(M)] for [name].")
		target_app.send_recruiter_message(sender = M,  \
			 offer = offer_name
		)
		tracked_messengers |= target_app
	// This technically goes two seconds after they click yes. Or 62 seconds after the initial offer.
	addtimer(CALLBACK(src, PROC_REF(follow_up_on_job_offers), tracked_messengers, M), 2 SECONDS)

/datum/dynamic_ruleset/midround/from_living/proc/follow_up_on_job_offers(list/tracked_messengers, mob/living/M)


/datum/dynamic_ruleset/midround/from_living/autotraitor/follow_up_on_job_offers(list/tracked_messengers, mob/living/M)
	for(var/datum/computer_file/program/messenger/i in tracked_messengers)
		if(i.recruiter_call == "ACCEPT")
			assigned += M
			candidates -= M
			var/datum/antagonist/traitor/infiltrator/sleeper_agent/newTraitor = new
			M.mind.add_antag_datum(newTraitor)
			message_admins("[ADMIN_LOOKUPFLW(M)] was selected by the [name] ruleset and has been made into a midround traitor.")
			log_dynamic("[key_name(M)] was selected by the [name] ruleset and has been made into a midround traitor.")
			. = TRUE

/datum/antagonist/traitor/infiltrator/sleeper_agent

/datum/computer_file/program/messenger
	var/recruiter_call
	var/response_timer_id

/datum/computer_file/program/messenger/proc/send_recruiter_message(mob/sender, offer)
	to_chat(sender, span_userdanger("Your PDA beeps ominously."))
	recruiter_call = tgui_alert(user = sender, message = "Your job application to become a [offer] has been accepted. \n Please respond if you are still interested in this position.", title = "Job Offer", buttons = list("ACCEPT"), timeout = 60 SECONDS)
	message_admins("[ADMIN_LOOKUPFLW(sender)] has accepted their offer of [offer].")
	. = recruiter_call

