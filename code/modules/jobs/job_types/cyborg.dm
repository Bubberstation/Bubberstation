/datum/job/cyborg
	title = JOB_CYBORG
	description = "Assist the crew, follow your laws, obey your AI."
	auto_deadmin_role_flags = DEADMIN_POSITION_SILICON
	faction = FACTION_STATION
	total_positions = 3	// SKYRAT EDIT: Original value (0)
	spawn_positions = 3
	supervisors = "your laws and the AI" //Nodrak
	spawn_type = /mob/living/silicon/robot
	minimal_player_age = 21
	exp_requirements = 120
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "CYBORG"

	display_order = JOB_DISPLAY_ORDER_CYBORG

	departments_list = list(
		/datum/job_department/silicon,
		)
	random_spawns_possible = FALSE
	job_flags = JOB_NEW_PLAYER_JOINABLE | JOB_EQUIP_RANK | JOB_CANNOT_OPEN_SLOTS


/datum/job/cyborg/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(!iscyborg(spawned))
		return
	var/mob/living/silicon/robot/robot_spawn = spawned
	robot_spawn.notify_ai(AI_NOTIFICATION_NEW_BORG)
	if(player_client)
		robot_spawn.set_gender(player_client)
	//SKYRAT EDIT START
	robot_spawn.set_connected_ai(select_priority_ai())
	if(robot_spawn.connected_ai)
		log_combat(robot_spawn.connected_ai, robot_spawn, "synced cyborg [robot_spawn] to [robot_spawn.connected_ai] (Cyborg spawn syncage)") // BUBBER EDIT - PUBLIC LOGS AND CLEANUP
		if(robot_spawn.shell) //somehow?
			robot_spawn.undeploy()
			robot_spawn.notify_ai(AI_NOTIFICATION_AI_SHELL)
		else
			robot_spawn.notify_ai(TRUE)
		robot_spawn.visible_message(span_notice("[robot_spawn] gently chimes."), span_notice("LawSync protocol engaged."))
		robot_spawn.lawupdate = TRUE
		robot_spawn.lawsync()
		robot_spawn.show_laws()
		if(HAS_TRAIT(SSstation, STATION_TRAIT_HOS_AI))
			robot_spawn.visible_message(self_message = span_alert("Securityborg has been enabled for this shift."))
	//SKYRAT EDIT END
	if(!robot_spawn.connected_ai) // Only log if there's no Master AI
		robot_spawn.log_current_laws()

/datum/job/cyborg/get_radio_information()
	return "<b>Prefix your message with :b to speak with other cyborgs and AI.</b>"
