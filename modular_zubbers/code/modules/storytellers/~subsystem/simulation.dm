#define STORY_TRAIT_IM_SIMULATION "simulation_mob"

ADMIN_VERB(storyteller_simulation, R_ADMIN, "Storyteller - Simulation", "Simulate round", ADMIN_CATEGORY_STORYTELLER)
	var/ask = tgui_alert(usr, "Do you want to perform simulation?", "Storyteller - simulation", list("Process", "Nevermind"))
	if(ask != "Process")
		return


	var/list/variants = list(
		"simulate manifest",
		"simulate antagonist",
		"simulate influence",
		"abort",
	)
	var/chosen = tgui_input_list(usr, "Pick variant of simulation.", "Storyteller - simulation", variants)
	if(chosen == "abort")
		return

	SSstorytellers.hard_debug = TRUE
	SSstorytellers.simulation = TRUE

	message_admins("[key_name_admin(user)]is starting storyteller round simulation with: [chosen] mode.")
	if(chosen == "simulate manifest")
		var/gear_ask = tgui_alert(usr, "Should we add some gear to crew?", "Storyteller - simulation", list("Yes", "Nevermind"))
		SSstorytellers.simulate_crew_activity(gear_ask == "Yes")

/datum/controller/subsystem/storytellers/proc/generate_random_key(length = 16)
	var/static/list/to_pick = list(
		"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
		"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
		"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
	)
	var/key = ""
	for(var/i = 0 to length)
		key += pick(to_pick)
	key += num2text(rand(16, 1024))
	return key


/datum/controller/subsystem/storytellers/proc/simulate_crew_activity(add_gear)
	if(!usr)
		return
	var/obj/effect/landmark/observer_start/observer_point = locate(/obj/effect/landmark/observer_start) in GLOB.landmarks_list
	var/turf/destination = get_turf(observer_point)
	if(!destination)
		to_chat(usr, "Failed to find the observer spawn to send the dummies.")
		return

	var/list/possible_species = list(
		/datum/species/human = 70,
		/datum/species/teshari = 20,
		/datum/species/moth = 10,
	)
	var/number_made = 0
	for(var/rank in SSjob.name_occupations)
		var/datum/job/job = SSjob.get_job(rank)
		if(!(job.job_flags & JOB_CREW_MEMBER))
			continue

		var/mob/dead/new_player/new_guy = new()
		new_guy.mind_initialize()
		new_guy.mind.name = "[rank] Dummy"

		if(!SSjob.assign_role(new_guy, job, do_eligibility_checks = FALSE))
			qdel(new_guy)
			to_chat(usr, "[rank] wasn't able to be spawned.")
			continue
		var/mob/living/carbon/human/character = new(destination)
		character.name = new_guy.mind.name
		new_guy.mind.transfer_to(character)
		qdel(new_guy)

		character.set_species(pick_weight(possible_species))
		SSjob.equip_rank(character, job)
		job.after_latejoin_spawn(character)

		SSticker.minds += character.mind
		if(ishuman(character))
			GLOB.manifest.inject(character)

		number_made++
		CHECK_TICK
		LAZYADD(simulated_atoms, WEAKREF(character))

	to_chat(usr, "[number_made] crewmembers have been created.")


#undef STORY_TRAIT_IM_SIMULATION "simulation_mob"
