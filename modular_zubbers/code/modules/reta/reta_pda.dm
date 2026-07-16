/**
 * RETA PDA App
 *
 * Allows authorized Medical, Engineering, and Security responders to declare validated
 * departmental emergencies through the existing RETA grant/announcement flow.
 */

#define RETA_PDA_MEDICAL "medical"
#define RETA_PDA_ENGINEERING "engineering"
#define RETA_PDA_SECURITY "security"
#define RETA_PDA_DISPATCH_DENIED 0
#define RETA_PDA_DISPATCH_SENT 1
#define RETA_PDA_DISPATCH_COOLDOWN 2
#define RETA_PDA_DISPATCH_NO_GRANT 3

GLOBAL_LIST_EMPTY(reta_supplemental_area_grants)

/datum/computer_file/program/reta
	filename = "reta"
	filedesc = "R.E.T.A"
	downloader_category = PROGRAM_CATEGORY_EQUIPMENT
	program_open_overlay = "alert-red"
	extended_desc = "Request Emergency Temporary Access for validated medical, security, and engineering emergencies."
	download_access = list(ACCESS_MEDICAL, ACCESS_ENGINEERING, ACCESS_SECURITY)
	program_flags = PROGRAM_ON_NTNET_STORE | PROGRAM_REQUIRES_NTNET
	size = 2
	tgui_id = "NtosReta"
	program_icon = "id-card"

/datum/computer_file/program/reta/ui_data(mob/user)
	var/list/data = list()
	var/obj/item/card/id/id_card = computer?.GetID()

	data["departments"] = reta_pda_department_data(id_card)
	return data

/datum/computer_file/program/reta/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(action != "declare")
		return FALSE

	var/origin_dept = params["department"]
	var/emergency_type = params["emergencyType"]
	var/obj/item/card/id/id_card = computer?.GetID()
	var/denial_reason = reta_pda_declare_denial_reason(id_card, origin_dept, emergency_type)
	if(denial_reason)
		computer?.say(denial_reason)
		return TRUE

	var/caller_info = reta_pda_caller_info(usr)
	var/dispatch_result = reta_dispatch_emergency_request(origin_dept, reta_pda_target_department(emergency_type), caller_info, computer)
	switch(dispatch_result)
		if(RETA_PDA_DISPATCH_DENIED)
			computer?.say("RETA is currently disabled, or this emergency request is invalid.")
			return TRUE
		if(RETA_PDA_DISPATCH_COOLDOWN)
			computer?.say("Emergency calls to [reta_pda_target_department(emergency_type)] are on cooldown.")
			return TRUE
		if(RETA_PDA_DISPATCH_NO_GRANT)
			computer?.say("No eligible [reta_pda_target_department(emergency_type)] responders needed RETA access.")
			return TRUE

	computer?.say("RETA [capitalize(emergency_type)] emergency declared for [origin_dept].")
	playsound(computer, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)
	return TRUE

/datum/computer_file/program/reta/proc/reta_pda_can_declare(obj/item/card/id/id_card, origin_dept, emergency_type)
	return !reta_pda_declare_denial_reason(id_card, origin_dept, emergency_type)

/datum/computer_file/program/reta/proc/reta_pda_declare_denial_reason(obj/item/card/id/id_card, origin_dept, emergency_type)
	if(!id_card?.trim)
		return "A job ID is required to declare a R.E.T.A emergency."
	if(!(origin_dept in reta_pda_department_names()))
		return "Invalid R.E.T.A department selected."

	var/same_department_reason = reta_pda_same_department_disabled_reason(origin_dept, emergency_type)
	if(same_department_reason)
		return same_department_reason

	switch(emergency_type)
		if(RETA_PDA_MEDICAL)
			if(!reta_pda_id_has_reta_trim(id_card, "Medical"))
				return "A medical ID trim is required to declare a medical emergency."
			if(!LAZYLEN(reta_department_sensor_critical_areas(origin_dept)))
				return "No critical suit sensor signal found in [origin_dept]."
			return null
		if(RETA_PDA_ENGINEERING)
			if(!reta_pda_id_has_reta_trim(id_card, "Engineering"))
				return "An engineering ID trim is required to declare an engineering emergency."
			if(!LAZYLEN(reta_department_engineering_alarm_areas(origin_dept)))
				return "No active fire or air alarm found in [origin_dept]."
			return null
		if(RETA_PDA_SECURITY)
			if(!reta_pda_id_has_security_or_guard_trim(id_card))
				return "A security or guard ID trim is required to declare a security emergency."
			if(SSsecurity_level.get_current_level_as_number() < SEC_LEVEL_AMBER)
				return "Security emergencies require amber alert or higher."
			return null

	return "Invalid RETA emergency type selected."

/proc/reta_pda_target_department(emergency_type)
	switch(emergency_type)
		if(RETA_PDA_MEDICAL)
			return "Medical"
		if(RETA_PDA_ENGINEERING)
			return "Engineering"
		if(RETA_PDA_SECURITY)
			return "Security"

/proc/reta_pda_same_department_disabled_reason(origin_dept, emergency_type)
	var/target_dept = reta_pda_target_department(emergency_type)
	if(origin_dept != target_dept)
		return null

	return "You cannot declare [LOWER_TEXT(target_dept)] emergencies for [target_dept]."

/datum/computer_file/program/reta/proc/reta_pda_caller_info(mob/user)
	if(!isliving(user))
		return ""

	var/mob/living/caller_mob = user
	var/obj/item/card/id/id_card = caller_mob.get_idcard()
	if(id_card)
		return "(Called by [id_card.registered_name], [id_card.assignment])"
	if(issilicon(caller_mob))
		if(iscyborg(caller_mob) && caller_mob?.mind?.assigned_role)
			return "(Called by [caller_mob.name], [caller_mob.mind.assigned_role.title])"
		return "(Called by [caller_mob.name], [caller_mob.job])"

	return "(Identification not provided)"

/proc/reta_pda_department_data(obj/item/card/id/id_card)
	. = list()
	for(var/dept in reta_pda_department_names())
		var/list/actions = reta_pda_department_actions(id_card, dept)
		if(!LAZYLEN(actions))
			continue

		. += list(list(
			"name" = dept,
			"actions" = actions,
		))

/proc/reta_pda_department_actions(obj/item/card/id/id_card, dept)
	. = list()
	if(reta_pda_id_has_reta_trim(id_card, "Medical"))
		. += list(list(
			"type" = RETA_PDA_MEDICAL,
			"label" = "Medical",
			"icon" = "briefcase-medical",
			"cooldown" = reta_on_cooldown(dept, "Medical"),
			"disabledReason" = reta_pda_same_department_disabled_reason(dept, RETA_PDA_MEDICAL),
		))
	if(reta_pda_id_has_reta_trim(id_card, "Engineering"))
		. += list(list(
			"type" = RETA_PDA_ENGINEERING,
			"label" = "Engineering",
			"icon" = "fire",
			"cooldown" = reta_on_cooldown(dept, "Engineering"),
			"disabledReason" = reta_pda_same_department_disabled_reason(dept, RETA_PDA_ENGINEERING),
		))
	if(reta_pda_id_has_security_or_guard_trim(id_card))
		var/security_disabled_reason = reta_pda_same_department_disabled_reason(dept, RETA_PDA_SECURITY)
		if(!security_disabled_reason && SSsecurity_level.get_current_level_as_number() < SEC_LEVEL_AMBER)
			security_disabled_reason = "You can only remotely declare security emergencies on amber or higher!"
		. += list(list(
			"type" = RETA_PDA_SECURITY,
			"label" = "Security",
			"icon" = "shield-halved",
			"cooldown" = reta_on_cooldown(dept, "Security"),
			"disabledReason" = security_disabled_reason,
		))

/proc/reta_pda_id_has_reta_trim(obj/item/card/id/id_card, dept)
	if(!id_card?.trim)
		return FALSE
	var/list/job_trims = GLOB.reta_job_trims[dept]
	return LAZYLEN(job_trims) && is_type_in_list(id_card.trim, job_trims)

/proc/reta_pda_id_has_security_or_guard_trim(obj/item/card/id/id_card)
	if(reta_pda_id_has_reta_trim(id_card, "Security"))
		return TRUE
	if(!id_card?.trim)
		return FALSE
	return istype(id_card.trim, /datum/id_trim/job/science_guard) \
		|| istype(id_card.trim, /datum/id_trim/job/orderly) \
		|| istype(id_card.trim, /datum/id_trim/job/engineering_guard) \
		|| istype(id_card.trim, /datum/id_trim/job/customs_agent) \
		|| istype(id_card.trim, /datum/id_trim/job/bouncer)

/proc/reta_pda_department_names()
	var/list/departments = list()
	for(var/dept in GLOB.reta_dept_grants)
		if(dept == "Command")
			continue
		departments += dept
	return sort_list(departments)

/proc/reta_department_has_sensor_critical(dept)
	return LAZYLEN(reta_department_sensor_critical_areas(dept))

/proc/reta_department_sensor_critical_areas(dept)
	. = list()
	for(var/mob/living/carbon/human/tracked_human as anything in GLOB.suit_sensors_list)
		if(!istype(tracked_human))
			continue

		var/obj/item/clothing/under/uniform = tracked_human.w_uniform
		if(!istype(uniform) || uniform.has_sensor < HAS_SENSORS || uniform.sensor_mode < SENSOR_LIVING)
			continue

		if(tracked_human.health > tracked_human.crit_threshold)
			continue

		var/area/emergency_area = get_area(tracked_human)
		if(reta_area_matches_department(emergency_area, dept) && !(emergency_area in .))
			. += emergency_area

/proc/reta_department_has_fire_alarm(dept)
	return LAZYLEN(reta_department_fire_alarm_areas(dept))

/proc/reta_department_has_engineering_alarm(dept)
	return LAZYLEN(reta_department_engineering_alarm_areas(dept))

/proc/reta_department_engineering_alarm_areas(dept)
	. = reta_department_fire_alarm_areas(dept)
	for(var/area/air_alarm_area as anything in reta_department_air_alarm_areas(dept))
		. |= air_alarm_area

/proc/reta_department_fire_alarm_areas(dept)
	. = list()
	for(var/area/area_to_check as anything in GLOB.areas)
		if(!area_to_check.active_alarms[ALARM_FIRE])
			continue
		if(reta_area_matches_department(area_to_check, dept))
			. += area_to_check

/proc/reta_department_air_alarm_areas(dept)
	. = list()
	for(var/area/area_to_check as anything in GLOB.areas)
		if(!area_to_check.active_alarms[ALARM_ATMOS])
			continue
		if(reta_area_matches_department(area_to_check, dept))
			. += area_to_check

/proc/reta_area_matches_department(area/area_to_check, dept)
	if(!area_to_check || !dept)
		return FALSE
	if(reta_get_user_department_by_name(area_to_check.name) == dept)
		return TRUE
	return reta_get_user_department_by_name(area_to_check.get_original_area_name()) == dept

/proc/reta_dispatch_emergency_request(origin_dept, target_dept, caller_info, atom/source)
	if(!origin_dept || !target_dept || !CONFIG_GET(flag/reta_enabled))
		return RETA_PDA_DISPATCH_DENIED
	if(reta_on_cooldown(origin_dept, target_dept))
		return RETA_PDA_DISPATCH_COOLDOWN

	var/duration_ds = CONFIG_GET(number/reta_duration_ds)
	var/granted_count = reta_find_and_grant_access(target_dept, origin_dept, duration_ds)
	var/list/emergency_areas = reta_emergency_areas(origin_dept, target_dept)
	var/extra_granted_count = reta_grant_emergency_area_access(target_dept, origin_dept, emergency_areas, duration_ds)
	if(!granted_count && !extra_granted_count)
		return RETA_PDA_DISPATCH_NO_GRANT

	var/cooldown_ds = CONFIG_GET(number/reta_dept_cooldown_ds)
	reta_set_cooldown(origin_dept, target_dept, cooldown_ds)

	reta_track_call(origin_dept, target_dept)
	reta_announce_emergency(origin_dept, target_dept, caller_info, source, granted_count || extra_granted_count)

	var/list/origin_channels = reta_department_radio_channels(origin_dept)
	aas_config_announce(/datum/aas_config_entry/rc_reta_announcement, list("GRANTEE" = target_dept, "CALLER" = caller_info), source, origin_channels)

	log_game("RETA: [origin_dept] called [target_dept] emergency by PDA, granted department access to [granted_count] responder IDs and extra area access to [extra_granted_count] responder IDs for [duration_ds/10] seconds")
	reta_push_ui_updates(origin_dept, target_dept)
	update_all_doors_reta_lights()
	return RETA_PDA_DISPATCH_SENT

/proc/reta_emergency_areas(origin_dept, target_dept)
	switch(target_dept)
		if("Medical")
			return reta_department_sensor_critical_areas(origin_dept)
		if("Engineering")
			return reta_department_engineering_alarm_areas(origin_dept)
	return list()

/proc/reta_grant_emergency_area_access(target_dept, origin_dept, list/emergency_areas, duration_ds)
	. = 0
	if(!LAZYLEN(emergency_areas))
		return

	var/list/extra_access = reta_emergency_area_access(origin_dept, emergency_areas)
	if(!LAZYLEN(extra_access))
		return

	var/list/job_trims = GLOB.reta_job_trims[target_dept]
	if(!LAZYLEN(job_trims))
		return

	var/grant_key = "[origin_dept] emergency area"
	for(var/mob/living/carbon/human/human_player as anything in GLOB.human_list)
		if(!human_player.client || human_player.stat == DEAD)
			continue

		var/obj/item/card/id/id_card = human_player.get_idcard(hand_first = FALSE)
		if(!id_card || !id_card.trim)
			continue

		if(!is_type_in_list(id_card.trim, job_trims))
			continue

		if(id_card.grant_reta_additional_access(grant_key, extra_access, duration_ds))
			.++

	if(.)
		reta_track_supplemental_area_grant(target_dept, grant_key, extra_access, emergency_areas, duration_ds)

/proc/reta_emergency_area_access(origin_dept, list/emergency_areas)
	. = list()
	var/list/origin_dept_access = GLOB.reta_dept_grants[origin_dept] || list()
	for(var/obj/machinery/door/door as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door))
		var/area/door_area = get_area(door)
		if(!(door_area in emergency_areas))
			continue

		for(var/required_access in door.req_access)
			if(!(required_access in origin_dept_access))
				. |= required_access

		if(LAZYLEN(door.req_one_access) == 1)
			var/required_one_access = door.req_one_access[1]
			if(!(required_one_access in origin_dept_access))
				. |= required_one_access

/proc/reta_track_supplemental_area_grant(target_dept, grant_key, list/access_flags, list/emergency_areas, duration_ds)
	if(!target_dept || !grant_key || !LAZYLEN(access_flags) || !LAZYLEN(emergency_areas))
		return

	if(!GLOB.reta_supplemental_area_grants[target_dept])
		GLOB.reta_supplemental_area_grants[target_dept] = list()

	var/expires_at = world.time + duration_ds
	GLOB.reta_supplemental_area_grants[target_dept][grant_key] = list(
		"access" = access_flags.Copy(),
		"areas" = emergency_areas.Copy(),
		"expires" = expires_at,
	)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(cleanup_reta_supplemental_area_grant), target_dept, grant_key, expires_at), duration_ds)

/proc/cleanup_reta_supplemental_area_grant(target_dept, grant_key, expected_expiry)
	if(!GLOB.reta_supplemental_area_grants[target_dept])
		return
	var/list/grant_data = GLOB.reta_supplemental_area_grants[target_dept][grant_key]
	if(grant_data && grant_data["expires"] != expected_expiry)
		return
	GLOB.reta_supplemental_area_grants[target_dept] -= grant_key
	if(!LAZYLEN(GLOB.reta_supplemental_area_grants[target_dept]))
		GLOB.reta_supplemental_area_grants -= target_dept
	update_all_doors_reta_lights()

/proc/reta_supplemental_area_access_for_door(obj/machinery/door/airlock/door)
	if(!door || !CONFIG_GET(flag/reta_enabled))
		return FALSE
	if(!LAZYLEN(GLOB.reta_supplemental_area_grants))
		return FALSE

	var/area/door_area = get_area(door)
	if(!door_area)
		return FALSE

	for(var/target_dept in GLOB.reta_supplemental_area_grants)
		var/list/target_grants = GLOB.reta_supplemental_area_grants[target_dept]
		for(var/grant_key in target_grants)
			var/list/grant_data = target_grants[grant_key]
			if(world.time >= grant_data["expires"])
				continue

			var/list/grant_areas = grant_data["areas"]
			if(!(door_area in grant_areas))
				continue

			var/list/grant_access = grant_data["access"]
			for(var/required_access in door.req_access)
				if(required_access in grant_access)
					return LOWER_TEXT(target_dept)

			for(var/required_one_access in door.req_one_access)
				if(required_one_access in grant_access)
					return LOWER_TEXT(target_dept)

	return FALSE

/obj/item/card/id/proc/grant_reta_additional_access(grant_key, list/access_flags, duration_ds)
	if(!grant_key || !LAZYLEN(access_flags))
		return FALSE

	if(!reta_temp_access[grant_key])
		reta_temp_access[grant_key] = list()

	var/list/new_access = list()
	for(var/flag in access_flags)
		if(!(flag in access))
			reta_temp_access[grant_key] |= flag
			access += flag
			new_access += flag

	if(LAZYLEN(reta_temp_access[grant_key]))
		if(reta_timers[grant_key] && reta_timers[grant_key] != -1)
			deltimer(reta_timers[grant_key])
			reta_timers[grant_key] = null
		reta_timers[grant_key] = addtimer(CALLBACK(src, PROC_REF(clear_reta_access_for_dept), grant_key), duration_ds, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)
		GLOB.reta_active_cards |= src

	if(!LAZYLEN(new_access))
		return LAZYLEN(reta_temp_access[grant_key])

	var/mob/living/carbon/human/holder = get_id_holder()
	if(holder)
		playsound(holder, 'sound/machines/cryo_warning.ogg', 25, TRUE)
		holder.balloon_alert(holder, "emergency access: local area")

	var/list/access_names = list()
	for(var/flag in new_access)
		access_names += SSid_access.get_access_desc(flag)

	var/holder_info = holder ? "held by [holder]" : "not being held"
	log_reta("Granted supplemental RETA access ([english_list(access_names)]) to ID '[registered_name || "Unknown"]' ([holder_info]) for [duration_ds/10] seconds")
	investigate_log("RETA: Granted supplemental access ([english_list(access_names)]) to ID '[registered_name || "Unknown"]' ([holder_info])", INVESTIGATE_ACCESSCHANGES)
	return TRUE

/proc/reta_announce_emergency(origin_dept, target_dept, caller_info, atom/source, granted_count)
	var/list/target_channels = reta_department_radio_channels(target_dept)
	if(!LAZYLEN(target_channels))
		return

	var/announcement_line = target_dept
	switch(target_dept)
		if("Security")
			announcement_line = "Security"
		if("Engineering")
			announcement_line = "Engineering"
		if("Medical")
			announcement_line = "Medical"

	aas_config_announce(/datum/aas_config_entry/rc_emergency, list("LOCATION" = origin_dept, "CALLER" = caller_info, "RETARESPONDERS" = granted_count), source, target_channels, announcement_line)

/proc/reta_department_radio_channels(dept)
	var/list/channels = list()
	switch(dept)
		if("Security")
			channels += RADIO_CHANNEL_SECURITY
		if("Engineering")
			channels += RADIO_CHANNEL_ENGINEERING
		if("Medical")
			channels += RADIO_CHANNEL_MEDICAL
		if("Science")
			channels += RADIO_CHANNEL_SCIENCE
		if("Service")
			channels += RADIO_CHANNEL_SERVICE
		if("Command")
			channels += RADIO_CHANNEL_COMMAND
		if("Cargo")
			channels += RADIO_CHANNEL_SUPPLY
		if("Mining")
			channels += RADIO_CHANNEL_SUPPLY
	return channels

/obj/item/modular_computer/pda/atmos
	starting_programs = list(
		/datum/computer_file/program/alarm_monitor,
		/datum/computer_file/program/atmosscan,
		/datum/computer_file/program/supermatter_monitor,
		/datum/computer_file/program/reta,
	)

/obj/item/modular_computer/pda/medical/paramedic
	starting_programs = list(
		/datum/computer_file/program/records/medical,
		/datum/computer_file/program/radar/lifeline,
		/datum/computer_file/program/reta,
	)

#undef RETA_PDA_MEDICAL
#undef RETA_PDA_ENGINEERING
#undef RETA_PDA_SECURITY
#undef RETA_PDA_DISPATCH_DENIED
#undef RETA_PDA_DISPATCH_SENT
#undef RETA_PDA_DISPATCH_COOLDOWN
#undef RETA_PDA_DISPATCH_NO_GRANT
