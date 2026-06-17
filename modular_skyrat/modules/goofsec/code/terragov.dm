#define EMERGENCY_RESPONSE_EMAG "AYO THE PIZZA HERE"

GLOBAL_VAR(pizza_order)
GLOBAL_LIST_INIT(pizza_names, list(
	"Dixon Buttes",
	"I. C. Weiner",
	"Seymour Butz",
	"I. P. Freely",
	"Pat Myaz",
	"Vye Agra",
	"Harry Balsack",
	"Lee Nover",
	"Maya Buttreeks",
	"Amanda Hugginkiss",
	"Bwight K. Brute", // Github Copilot suggested dwight from the office like 10 times
	"John Nanotrasen",
	"Mike Rotch",
	"Hugh Jass",
	"Oliver Closeoff",
	"Hugh G. Recktion",
	"Phil McCrevis",
	"Willie Lickerbush",
	"Ben Dover",
	"Steve", // REST IN PEACE MAN
	"Avery Goodlay",
	"Anne Fetamine",
	"Amanda Peon",
	"Tara Newhole",
	"Penny Tration",
	"Joe Mama"
))
GLOBAL_LIST_INIT(emergency_responders, list())

/// Internal. Polls ghosts and sends in a team of space cops according to the alert level, accompanied by an announcement.
/obj/machinery/computer/communications/proc/call_911(ordered_team)
	var/team_size
	var/cops_to_send
	var/announcement_message = "sussus amogus"
	var/announcer = "Terran Government Marshal Department"
	var/poll_question = "fuck you leatherman"
	var/cell_phone_number = "911"
	var/list_to_use = "911_responders"
	switch(ordered_team)
		if(EMERGENCY_RESPONSE_EMAG)
			team_size = 8
			cops_to_send = /datum/antagonist/ert/pizza/false_call
			announcement_message = "Thank you for ordering from Dogginos, [GLOB.pizza_order]! We're sending you that extra-large party package pizza delivery \
				right away!\n\n\
				Thank you for choosing our premium Fifteen Minutes or Less delivery option! Our pizza will be at your doorstep at [station_name()] as soon as possible thanks \
				to our lightning-fast warp drives installed on all Dogginos delivery shuttles!\n\
				Distance from your chosen Dogginos: 70,000 Lightyears"
			announcer = "Dogginos"
			poll_question = "The station has ordered $35,000 in pizza. Will you deliver?"
			cell_phone_number = "Dogginos"
			list_to_use = "dogginos"
		else
			stack_trace("[ordered_team] was called for invalidly!")
	priority_announce(announcement_message, announcer, 'sound/effects/families_police.ogg', has_important_message=TRUE, color_override = "yellow")
	var/list/candidates = SSpolling.poll_ghost_candidates(poll_question, check_jobban = "deathsquad", alert_pic = /obj/item/card/id/advanced/terragov, role_name_text = "Terran Government response team")

	if(candidates.len)
		//Pick the (un)lucky players
		var/agents_number = min(team_size, candidates.len)

		var/list/spawnpoints = GLOB.emergencyresponseteamspawn
		var/index = 0
		GLOB.terragov_responder_info[list_to_use][TERRAGOV_AMT] = agents_number
		while(agents_number && candidates.len)
			var/spawn_loc = spawnpoints[index + 1]
			//loop through spawnpoints one at a time
			index = (index + 1) % spawnpoints.len
			var/mob/dead/observer/chosen_candidate = pick(candidates)
			candidates -= chosen_candidate
			if(!chosen_candidate.key)
				continue

			//Spawn the body
			var/mob/living/carbon/human/cop = new(spawn_loc)
			chosen_candidate.client.prefs.safe_transfer_prefs_to(cop, is_antag = TRUE)
			cop.key = chosen_candidate.key

			//Give antag datum
			var/datum/antagonist/ert/request_911/ert_antag = new cops_to_send

			cop.mind.add_antag_datum(ert_antag)
			cop.mind.set_assigned_role(SSjob.get_job_type(ert_antag.ert_job_path))
			SSjob.send_to_late_join(cop)
			cop.grant_language(/datum/language/common, source = LANGUAGE_SPAWNER)

			if(cops_to_send == /datum/antagonist/ert/request_911/atmos) // charge for atmos techs
				var/datum/bank_account/station_balance = SSeconomy.get_dep_account(ACCOUNT_CAR)
				station_balance?.adjust_money(GLOB.terragov_tech_charge)
			else
				var/obj/item/gangster_cellphone/phone = new() // biggest gang in the city
				phone.gang_id = cell_phone_number
				phone.name = "[cell_phone_number] branded cell phone"
				phone.w_class = WEIGHT_CLASS_SMALL	//They get that COMPACT phone hell yea
				var/phone_equipped = phone.equip_to_best_slot(cop)
				if(!phone_equipped)
					to_chat(cop, "Your [phone.name] has been placed at your feet.")
					phone.forceMove(get_turf(cop))

			//Logging and cleanup
			log_game("[key_name(cop)] has been selected as an [ert_antag.name]")
			if(cops_to_send == /datum/antagonist/ert/request_911/atmos)
				log_game("[abs(GLOB.terragov_tech_charge)] has been charged from the station budget for [key_name(cop)]")
			agents_number--
	GLOB.cops_arrived = TRUE
	return TRUE

/obj/machinery/computer/communications/proc/pre_911_check(mob/user)
	if (!authenticated_as_silicon_or_captain(user))
		return FALSE

	if (GLOB.cops_arrived)
		to_chat(user, span_warning("911 has already been called this shift!"))
		playsound(src, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)
		return FALSE

	if (!issilicon(user))
		var/obj/item/held_item = user.get_active_held_item()
		var/obj/item/card/id/id_card = held_item?.GetID()
		if (!istype(id_card))
			to_chat(user, span_warning("You need to swipe your ID!"))
			playsound(src, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)
			return FALSE
		if (!(ACCESS_CAPTAIN in id_card.access))
			to_chat(user, span_warning("You are not authorized to do this!"))
			playsound(src, 'sound/machines/terminal/terminal_prompt_deny.ogg', 50, FALSE)
			return FALSE
	else
		to_chat(user, "The console refuses to let you dial 911 as an AI or Cyborg!")
		return FALSE
	return TRUE

/obj/item/terragov_reporter
	name = "TerraGov reporter"
	desc = "Use this in-hand to vote to call TerraGov backup. If half your team votes for it, SWAT will be dispatched."
	icon = 'modular_skyrat/modules/goofsec/icons/reporter.dmi'
	icon_state = "reporter_off"
	w_class = WEIGHT_CLASS_SMALL
	/// Was the reporter turned on?
	var/activated = FALSE
	/// What antagonist should be required to use the reporter?
	var/type_to_check = /datum/antagonist/ert/request_911
	/// What table should we be incrementing votes in and checking against in the terragov responders global?
	var/type_of_callers = "911_responders"
	/// What source should be supplied for the announcement message?
	var/announcement_source = "Terran Government S.W.A.T."
	/// Should the station be issued a fine when the vote completes?
	var/fine_station = TRUE
	/// What poll message should we show to the ghosts when they are asked to join the squad?
	var/ghost_poll_msg = "example crap"
	/// How many ghosts should we pick from the applicants to become members of the squad?
	var/amount_to_summon = 4
	/// What antagonist type should we give to the ghosts?
	var/type_to_summon = /datum/antagonist/ert/request_911/condom_destroyer
	/// What table should be be incrementing amount in in the terragov responders global?
	var/summoned_type = "swat"
	/// What name and ID should be on the cell phone given to the squad members?
	var/cell_phone_number = "911"
	/// What jobban should we be checking for the ghost polling?
	var/jobban_to_check = ROLE_DEATHSQUAD
	/// What announcement message should be displayed if the vote succeeds?
	var/announcement_message = "Example announcement message"

/obj/item/terragov_reporter/proc/pre_checks(mob/user)
	if(GLOB.terragov_responder_info[type_of_callers][TERRAGOV_AMT] == 0)
		to_chat(user, span_warning("There are no responders. You likely spawned this in as an admin. Please don't do this."))
		return FALSE
	if(!user.mind.has_antag_datum(type_to_check))
		to_chat(user, span_warning("You don't know how to use this!"))
		return FALSE
	return TRUE

/obj/item/terragov_reporter/proc/questions(mob/user)
	return TRUE

/obj/item/terragov_reporter/attack_self(mob/user, modifiers)
	. = ..()
	if(!pre_checks(user))
		return
	if(!activated && !GLOB.terragov_responder_info[type_of_callers][TERRAGOV_DECLARED])
		if(!questions(user))
			return
		activated = TRUE
		icon_state = "reporter_on"
		GLOB.terragov_responder_info[type_of_callers][TERRAGOV_VOTES]++
		var/current_votes = GLOB.terragov_responder_info[type_of_callers][TERRAGOV_VOTES]
		var/amount_of_responders = GLOB.terragov_responder_info[type_of_callers][TERRAGOV_AMT]
		to_chat(user, span_warning("You have activated the device. \
		Current Votes: [current_votes]/[amount_of_responders] votes."))
		if(current_votes >= amount_of_responders * 0.5)
			GLOB.terragov_responder_info[type_of_callers][TERRAGOV_DECLARED] = TRUE
			if(fine_station)
				var/datum/bank_account/station_balance = SSeconomy.get_dep_account(ACCOUNT_CAR)
				station_balance?.adjust_money(TERRAGOV_FINE_AMOUNT) // paying for the gas to drive all the fuckin' way out to the frontier

			priority_announce(announcement_message, announcement_source, 'sound/effects/families_police.ogg', has_important_message = TRUE, color_override = "yellow")
			var/list/candidates = SSpolling.poll_ghost_candidates(ghost_poll_msg, jobban_to_check)

			if(candidates.len)
				//Pick the (un)lucky players
				var/agents_number = min(amount_to_summon, candidates.len)
				GLOB.terragov_responder_info[summoned_type][TERRAGOV_AMT] = agents_number

				var/list/spawnpoints = GLOB.emergencyresponseteamspawn
				var/index = 0
				while(agents_number && candidates.len)
					var/spawn_loc = spawnpoints[index + 1]
					//loop through spawnpoints one at a time
					index = (index + 1) % spawnpoints.len
					var/mob/dead/observer/chosen_candidate = pick(candidates)
					candidates -= chosen_candidate
					if(!chosen_candidate.key)
						continue

					//Spawn the body
					var/mob/living/carbon/human/cop = new(spawn_loc)
					chosen_candidate.client.prefs.safe_transfer_prefs_to(cop, is_antag = TRUE)
					cop.key = chosen_candidate.key

					//Give antag datum
					var/datum/antagonist/ert/request_911/ert_antag = new type_to_summon

					cop.mind.add_antag_datum(ert_antag)
					cop.mind.set_assigned_role(SSjob.get_job_type(ert_antag.ert_job_path))
					SSjob.send_to_late_join(cop)
					cop.grant_language(/datum/language/common, source = LANGUAGE_SPAWNER)

					var/obj/item/gangster_cellphone/phone = new() // biggest gang in the city
					phone.gang_id = cell_phone_number
					phone.name = "[cell_phone_number] branded cell phone"
					var/phone_equipped = phone.equip_to_best_slot(cop)
					if(!phone_equipped)
						to_chat(cop, "Your [phone.name] has been placed at your feet.")
						phone.forceMove(get_turf(cop))

					//Logging and cleanup
					log_game("[key_name(cop)] has been selected as an [ert_antag.name]")
					agents_number--


/obj/item/terragov_reporter/pizza_managers
	name = "Dogginos uncompliant customer reporter"
	desc = "Use this in-hand to vote to call for Dogginos Regional Managers if the station refuses to pay for their pizza. \
		If half your delivery squad votes for it, Dogginos Regional Managers will be dispatched."
	type_to_check = /datum/antagonist/ert/pizza/false_call
	type_of_callers = "dogginos"
	announcement_message = "Hey there, custo-mores! Our delivery drivers have reported that you guys are having some issues with payment for your order that \
		you placed at the Dogginos that's the seventh furthest Dogginos in the galaxy from your station, and we want to ensure maximum customer satisfaction and \
		employee satisfaction as well.\n\
		We've gone ahead and sent some some of our finest regional managers to handle the situation.\n\
		We hope you enjoy your pizzas, and that we'll be able to receive the bill of $35,000 plus the fifteen percent tip for our drivers shortly!"
	announcement_source = "Dogginos"
	fine_station = FALSE
	ghost_poll_msg = "Dogginos is sending regional managers to get the station to pay up the pizza money they owe. Are you ready to do some Customer Relations?"
	amount_to_summon = 8
	type_to_summon = /datum/antagonist/ert/pizza/leader/false_call
	summoned_type = "dogginos_manager"
	cell_phone_number = "Dogginos"

/obj/item/terragov_reporter/pizza_managers/questions(mob/user)
	if(tgui_alert(user, "Is the station refusing to pay their bill of $35,000, including a fifteen percent tip for delivery drivers?", "Dogginos Uncompliant Customer Reporter", list("No", "Yes")) != "Yes")
		to_chat(user, "You decide not to request management assist you with the delivery.")
		return FALSE
	message_admins("[ADMIN_LOOKUPFLW(user)] has voted to summon Dogginos management to resolve the lack of payment.")
	return TRUE

/datum/antagonist/ert/pizza/false_call
	outfit = /datum/outfit/centcom/ert/pizza/false_call

/datum/outfit/centcom/ert/pizza/false_call
	backpack_contents = list(
		/obj/item/storage/box/survival,
		/obj/item/knife,
		/obj/item/storage/box/ingredients/italian,
		/obj/item/terragov_reporter/pizza_managers,
	)
	r_hand = /obj/item/pizzabox/meat
	l_hand = /obj/item/pizzabox/vegetable

/datum/antagonist/ert/pizza/false_call/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for Dogginos as a delivery person.</font></B>"
	missiondesc += "<BR>You are here to deliver some pizzas from Dogginos!\n"
	missiondesc += "<BR>Use the Cell Phone in your backpack to confer with fellow Dogginos employees!\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Deliver the pizzas ordered by [GLOB.pizza_order]."
	missiondesc += "<BR> <B>2.</B> Collect the bill, which totals to $35,000 plus a fifteen percent tip for delivery drivers."
	missiondesc += "<BR> <B>3.</B> If they refuse to pay, you may summon the Dogginos Regional Managers to help resolve the issue."
	to_chat(owner, missiondesc)

/datum/antagonist/ert/pizza/leader/false_call/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for Dogginos as a Regional Manager.</font></B>"
	missiondesc += "<BR>You are here to resolve a dispute with some customers who refuse to pay their bill!\n"
	missiondesc += "<BR>Use the Cell Phone in your backpack to confer with fellow Dogginos employees!\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Collect the money owed by [GLOB.pizza_order], which amounts to $35,000 plus a fifteen percent tip for the delivery drivers."
	missiondesc += "<BR> <B>2.</B> Use any means necessary to collect the owed funds. The thousand degree knife in your backpack will help in this task."
	to_chat(owner, missiondesc)

/obj/item/beamout_tool
	name = "beam-out tool" // TODO, find a way to make this into drop pods cuz that's cooler visually
	desc = "Use this to begin the lengthy beam-out  process to return to Terran Government space. It will bring anyone you are pulling with you."
	icon = 'modular_skyrat/modules/goofsec/icons/reporter.dmi'
	icon_state = "beam_me_up_scotty"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/beamout_tool/attack_self(mob/user, modifiers)
	. = ..()
	if(!user.mind.has_antag_datum(/datum/antagonist/ert))
		to_chat(user, span_warning("You don't understand how to use this device."))
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has begun to beam-out using their beam-out tool.")
	to_chat(user, "You have begun the beam-out process. Please wait for the beam to reach the station.")
	user.balloon_alert(user, "begun beam-out")
	if(do_after(user, 30 SECONDS))
		to_chat(user, "You have completed the beam-out process and are returning to the Terran Government.")
		message_admins("[ADMIN_LOOKUPFLW(user)] has beamed themselves out.")
		if(isliving(user))
			var/mob/living/living_user = user
			if(living_user.pulling)
				if(ishuman(living_user.pulling))
					var/mob/living/carbon/human/beamed_human = living_user.pulling
					message_admins("[ADMIN_LOOKUPFLW(user)] has beamed out [ADMIN_LOOKUPFLW(beamed_human)] alongside them.")
				else
					message_admins("[ADMIN_LOOKUPFLW(user)] has beamed out [living_user.pulling] alongside them.")
				var/turf/pulling_turf = get_turf(living_user.pulling)
				playsound(pulling_turf, 'sound/effects/magic/Repulse.ogg', 100, 1)
				do_sparks(10, 1, pulling_turf)
				qdel(living_user.pulling)
			var/turf/user_turf = get_turf(living_user)
			playsound(user_turf, 'sound/effects/magic/Repulse.ogg', 100, 1)
			do_sparks(10, 1, user_turf)
			qdel(user)
	else
		user.balloon_alert(user, "beam-out cancelled")

#undef TERRAGOV_AMT
#undef TERRAGOV_VOTES
#undef TERRAGOV_DECLARED
#undef TERRAGOV_FINE_AMOUNT

#undef EMERGENCY_RESPONSE_POLICE
#undef EMERGENCY_RESPONSE_ATMOS
#undef EMERGENCY_RESPONSE_EMT
#undef EMERGENCY_RESPONSE_EMAG
