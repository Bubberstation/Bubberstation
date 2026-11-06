/*
* This is basically taking the handheld monitor, but making a security variant.
* I bashed a bit of the blueshield handheld monitor and the newer more up to date code to make this work.
* If you want to figure out how to make it compatible with nanites, go for it.
*/
GLOBAL_DATUM_INIT(secmed_crewmonitor, /datum/crewmonitor/secmed, new)

//list of all Security related jobs
/datum/crewmonitor/secmed
	var/list/jobs_security = list(
		JOB_ERT_COMMANDER = 20,
		JOB_ERT_OFFICER = 22,
		JOB_ERT_ENGINEER = 23,
		JOB_ERT_MEDICAL_DOCTOR = 24,
		JOB_ERT_CLOWN = 25,
		JOB_ERT_CHAPLAIN = 26,
		JOB_ERT_JANITOR = 27,
		JOB_CAPTAIN = 50,
		JOB_VETERAN_ADVISOR = 52,
		JOB_HEAD_OF_SECURITY = 70,
		JOB_WARDEN = 201,
		JOB_CORRECTIONS_OFFICER = 202,
		JOB_SECURITY_MEDIC = 203,
		JOB_DETECTIVE = 204,
		JOB_SECURITY_OFFICER = 205,
		JOB_SECURITY_OFFICER_MEDICAL = 206,
		JOB_SECURITY_OFFICER_ENGINEERING = 207,
		JOB_SECURITY_OFFICER_SCIENCE = 208,
		JOB_SECURITY_OFFICER_SUPPLY = 209,
		JOB_PRISONER = 803,
		JOB_TERRAGOV = 902,
	)

/datum/crewmonitor/secmed/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "CrewConsoleBubbersSec")
		ui.open()

/*
*	Override of crewmonitor/update_data(z)
* 	- "trim_assignment" is now iterated for security related-only jobs
*	- "if (id_card)" now encapsulates all the remaining checks to avoid showing unknowns
*/
/datum/crewmonitor/secmed/update_data(z)
	if(data_by_z["[z]"] && last_update["[z]"] && world.time <= last_update["[z]"] + SENSORS_UPDATE_PERIOD)
		return data_by_z["[z]"]

	var/list/results = list()
	for(var/tracked_mob in GLOB.suit_sensors_list)
		if(!tracked_mob)
			stack_trace("Null entry in suit sensors list.")
			continue

		var/mob/living/tracked_living_mob = tracked_mob

		var/turf/pos = get_turf(tracked_living_mob)

		if(!pos)
			stack_trace("Tracked mob has no loc and is likely in nullspace: [tracked_living_mob] ([tracked_living_mob.type])")
			continue

		if(pos.z != z && (!is_station_level(pos.z) || !is_station_level(z)) && !HAS_TRAIT(tracked_living_mob, TRAIT_MULTIZ_SUIT_SENSORS))
			continue

		var/mob/living/carbon/human/tracked_human = tracked_living_mob

		if(!ishuman(tracked_human))
			stack_trace("Non-human mob is in suit_sensors_list: [tracked_living_mob] ([tracked_living_mob.type])")
			continue

		var/obj/item/clothing/under/uniform = tracked_human.w_uniform
		if (!istype(uniform))
			stack_trace("Human without a suit sensors compatible uniform is in suit_sensors_list: [tracked_human] ([tracked_human.type]) ([uniform?.type])")
			continue

		if((uniform.has_sensor <= NO_SENSORS) || !uniform.sensor_mode)
			stack_trace("Human without active suit sensors is in suit_sensors_list: [tracked_human] ([tracked_human.type]) ([uniform.type])")
			continue

		var/sensor_mode = uniform.sensor_mode
		var/list/entry = list()

		var/obj/item/card/id/id_card = tracked_living_mob.get_idcard(hand_first = FALSE)
		if (id_card)

			entry["name"] = id_card.registered_name
			entry["assignment"] = id_card.assignment
			var/trim_assignment = id_card.get_trim_assignment()

			//Check if they are security
			if (jobs_security[trim_assignment] != null)
				entry["ijob"] = jobs_security[trim_assignment]
			else
				continue

			// BUBBER EDIT BEGIN: Checking for robotic race/Proteans
			if (issynthetic(tracked_human) || isprotean(tracked_human))
				entry["is_robot"] = TRUE
			// BUBBER EDIT END

			// Broken sensors show garbage data
			if (uniform.has_sensor == BROKEN_SENSORS)
				entry["life_status"] = 1 // BUBBER EDIT CHANGE - Original:  rand(0,1) - Mob stays in consistent list position when sensors are broken
				entry["area"] = pick_list (ION_FILE, "ionarea")
				entry["oxydam"] = rand(0,175)
				entry["toxdam"] = rand(0,175)
				entry["burndam"] = rand(0,175)
				entry["brutedam"] = rand(0,175)
				entry["health"] = -50
				results[++results.len] = entry
				continue

			// BUBBERSTATION EDIT BEGIN: Add DNR status, proteans death state.
			// If sensors are above living tracking, set DNR state
			if (sensor_mode >= SENSOR_LIVING)
				entry["is_dnr"] = tracked_human.get_dnr()
				// Current status
				var/obj/item/organ/brain/protean/protean_brain = tracked_human.get_organ_slot(ORGAN_SLOT_BRAIN)
				if(istype(protean_brain))
					if(!isprotean(tracked_human))
						stack_trace("[tracked_human] brain-species mismatch! Species is [tracked_human.dna.species] but brain is Protean")
					entry["life_status"] = protean_brain?.dead ? DEAD : tracked_living_mob.stat // If brain not dead/no brain then handling as usual
				else
					entry["life_status"] = tracked_living_mob.stat
			// BUBBERSTATION EDIT END

			// Damage
			if (sensor_mode >= SENSOR_VITALS)
				entry += list(
					"oxydam" = round(tracked_living_mob.get_oxy_loss(), 1),
					"toxdam" = round(tracked_living_mob.get_tox_loss(), 1),
					"burndam" = round(tracked_living_mob.get_fire_loss(), 1),
					"brutedam" = round(tracked_living_mob.get_brute_loss(), 1),
					"health" = round(tracked_living_mob.health, 1),
				)

			// Location
			if (sensor_mode >= SENSOR_COORDS)
				entry["area"] = get_area_name(tracked_living_mob, format_text = TRUE)

			entry["can_track"] = tracked_living_mob.can_track()

		else
			continue

		results[++results.len] = entry

	data_by_z["[z]"] = results
	last_update["[z]"] = world.time

	return results
