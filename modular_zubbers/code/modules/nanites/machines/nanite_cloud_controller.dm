/obj/machinery/computer/nanite_cloud_controller
	name = "nanite cloud controller"
	desc = "Stores and controls nanite cloud backups."
	icon = 'modular_zubbers/icons/obj/machines/nanite_machines.dmi'
	icon_state = "nanite_cloud_controller"
	circuit = /obj/item/circuitboard/computer/nanite_cloud_controller
	icon_screen = "nanite_cloud_controller_screen"
	icon_keyboard = null

	var/obj/item/disk/nanite_program/disk
	var/list/datum/nanite_cloud_backup/cloud_backups = list()
	var/datum/techweb/linked_techweb
	var/current_view = 0 //0 is the main menu, any other number is the page of the backup with that ID
	var/new_backup_id = 1

/obj/machinery/computer/nanite_cloud_controller/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	if(!CONFIG_GET(flag/no_default_techweb_link) && !linked_techweb)
		CONNECT_TO_RND_SERVER_ROUNDSTART(linked_techweb, src)
	register_context()

/obj/machinery/computer/nanite_cloud_controller/Destroy()
	QDEL_LIST(cloud_backups) //rip backups
	eject()
	return ..()

/obj/machinery/computer/nanite_cloud_controller/examine(mob/user)
	. = ..()
	. += span_notice("Use with a linked multitool to link to a techweb server.")

/obj/machinery/computer/nanite_cloud_controller/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		return
	if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
		context[SCREENTIP_CONTEXT_LMB] = "Open Panel"
		return CONTEXTUAL_SCREENTIP_SET
	if(held_item.tool_behaviour == TOOL_MULTITOOL)
		context[SCREENTIP_CONTEXT_LMB] = "Upload Techweb"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/computer/nanite_cloud_controller/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(!istype(tool, /obj/item/disk/nanite_program))
		return NONE
	var/obj/item/disk/nanite_program/new_disk = tool
	if(!user.transferItemToLoc(new_disk, src))
		return NONE
	to_chat(user, span_notice("You insert [new_disk] into [src]"))
	playsound(src, 'sound/machines/terminal/terminal_insert_disc.ogg', 50, FALSE)
	if(disk)
		eject(user)
	disk = new_disk
	return ITEM_INTERACT_SUCCESS

/obj/machinery/computer/nanite_cloud_controller/multitool_act(mob/living/user, obj/item/multitool/tool)
	if(!QDELETED(tool.buffer) && istype(tool.buffer, /datum/techweb))
		linked_techweb = tool.buffer
		balloon_alert(user, "linked!")
		update_static_data_for_all_viewers()
	return TRUE

/obj/machinery/computer/nanite_cloud_controller/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(disk && user.can_perform_action(src, !issilicon(user)))
		to_chat(user, span_notice("You take out [disk] from [src]."))
		eject(user)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/computer/nanite_cloud_controller/proc/eject(mob/living/user)
	if(!disk)
		return
	if(!istype(user) || !Adjacent(user) ||!user.put_in_active_hand(disk))
		disk.forceMove(drop_location())
	disk = null

/obj/machinery/computer/nanite_cloud_controller/proc/get_backup(cloud_id)
	for(var/I in cloud_backups)
		var/datum/nanite_cloud_backup/backup = I
		if(backup.cloud_id == cloud_id)
			return backup

/obj/machinery/computer/nanite_cloud_controller/proc/generate_backup(cloud_id, mob/user)
	if(SSnanites.get_cloud_backup(cloud_id, TRUE))
		to_chat(user, span_warning("Cloud ID already registered."))
		return

	var/datum/nanite_cloud_backup/backup = new(src)
	var/datum/component/nanites/cloud_copy = backup.AddComponent(/datum/component/nanites)
	backup.cloud_id = cloud_id
	backup.nanites = cloud_copy
	if(linked_techweb)
		backup.techweb = linked_techweb
	investigate_log("[key_name(user)] created a new nanite cloud backup with id #[cloud_id]", INVESTIGATE_NANITES)

/obj/machinery/computer/nanite_cloud_controller/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NaniteCloudControl", name)
		ui.open()

/obj/machinery/computer/nanite_cloud_controller/ui_static_data(mob/user)
	. = ..()
	var/list/data = .
	if(linked_techweb)
		data["techweb"] = list(
			"name" = linked_techweb.id,
			"organization" = linked_techweb.organization,
		)
	data["min_cloud_id"] = NANITE_MIN_CLOUD_ID
	data["max_cloud_id"] = NANITE_MAX_CLOUD_ID

// a lot of this should be in static data
/obj/machinery/computer/nanite_cloud_controller/ui_data()
	var/list/data = list()
	if(disk)
		data["has_disk"] = TRUE
		var/list/disk_data = list()
		var/datum/nanite_program/P = disk.program
		data["has_program"] = P ? TRUE : FALSE
		if(P)
			disk_data["name"] = P.name
			disk_data["desc"] = P.desc
			disk_data["use_rate"] = P.use_rate
			disk_data["can_trigger"] = P.can_trigger
			disk_data["trigger_cost"] = P.trigger_cost
			disk_data["trigger_cooldown"] = P.trigger_cooldown / 10

			disk_data["activated"] = P.activated
			disk_data["activation_code"] = P.activation_code
			disk_data["deactivation_code"] = P.deactivation_code
			disk_data["kill_code"] = P.kill_code
			disk_data["trigger_code"] = P.trigger_code
			disk_data["timer_restart"] = P.timer_restart / 10
			disk_data["timer_shutdown"] = P.timer_shutdown / 10
			disk_data["timer_trigger"] = P.timer_trigger / 10
			disk_data["timer_trigger_delay"] = P.timer_trigger_delay / 10

			var/list/extra_settings = P.get_extra_settings_frontend()
			disk_data["extra_settings"] = extra_settings
			if(LAZYLEN(extra_settings))
				disk_data["has_extra_settings"] = TRUE
			if(istype(P, /datum/nanite_program/sensor))
				var/datum/nanite_program/sensor/sensor = P
				if(sensor.can_rule)
					disk_data["can_rule"] = TRUE
		data["disk"] = disk_data
	else
		data["has_disk"] = FALSE

	data["new_backup_id"] = new_backup_id

	data["current_view"] = current_view
	if(current_view)
		var/datum/nanite_cloud_backup/backup = get_backup(current_view)
		if(backup)
			var/datum/component/nanites/nanites = backup.nanites
			data["cloud_backup"] = TRUE
			var/list/cloud_programs = list()
			var/id = 1
			for(var/datum/nanite_program/P in nanites.programs)
				var/list/cloud_program = list()
				cloud_program["name"] = P.name
				cloud_program["desc"] = P.desc
				cloud_program["id"] = id
				cloud_program["use_rate"] = P.use_rate
				cloud_program["can_trigger"] = P.can_trigger
				cloud_program["trigger_cost"] = P.trigger_cost
				cloud_program["trigger_cooldown"] = P.trigger_cooldown / 10
				cloud_program["activated"] = P.activated
				cloud_program["timer_restart"] = P.timer_restart / 10
				cloud_program["timer_shutdown"] = P.timer_shutdown / 10
				cloud_program["timer_trigger"] = P.timer_trigger / 10
				cloud_program["timer_trigger_delay"] = P.timer_trigger_delay / 10

				cloud_program["activation_code"] = P.activation_code
				cloud_program["deactivation_code"] = P.deactivation_code
				cloud_program["kill_code"] = P.kill_code
				cloud_program["trigger_code"] = P.trigger_code
				var/list/rules = list()
				var/rule_id = 1
				for(var/X in P.rules)
					var/datum/nanite_rule/nanite_rule = X
					var/list/rule = list()
					rule["display"] = nanite_rule.display()
					rule["program_id"] = id
					rule["id"] = rule_id
					rules += list(rule)
					rule_id++
				cloud_program["rules"] = rules
				if(LAZYLEN(rules))
					cloud_program["has_rules"] = TRUE
				cloud_program["all_rules_required"] = P.all_rules_required

				var/list/extra_settings = P.get_extra_settings_frontend()
				cloud_program["extra_settings"] = extra_settings
				if(LAZYLEN(extra_settings))
					cloud_program["has_extra_settings"] = TRUE
				id++
				cloud_programs += list(cloud_program)
			data["cloud_programs"] = cloud_programs
	else
		var/list/backup_list = list()
		for(var/X in cloud_backups)
			var/datum/nanite_cloud_backup/backup = X
			var/list/cloud_backup = list()
			cloud_backup["cloud_id"] = backup.cloud_id
			backup_list += list(cloud_backup)
		data["cloud_backups"] = backup_list
	return data

/obj/machinery/computer/nanite_cloud_controller/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("eject")
			eject(usr)
			. = TRUE
		if("set_view")
			current_view = text2num(params["view"])
			. = TRUE
		if("update_new_backup_value")
			var/backup_value = text2num(params["value"])
			new_backup_id = backup_value
		if("create_backup")
			var/cloud_id = new_backup_id
			if(!isnull(cloud_id))
				playsound(src, 'sound/machines/terminal/terminal_prompt.ogg', 50, FALSE)
				cloud_id = clamp(round(cloud_id, 1),NANITE_MIN_CLOUD_ID+1,NANITE_MAX_CLOUD_ID)
				generate_backup(cloud_id, usr)
			. = TRUE
		if("delete_backup")
			var/datum/nanite_cloud_backup/backup = get_backup(current_view)
			if(backup)
				playsound(src, 'sound/machines/terminal/terminal_prompt.ogg', 50, FALSE)
				qdel(backup)
				investigate_log("[key_name(usr)] deleted the nanite cloud backup #[current_view]", INVESTIGATE_NANITES)
			. = TRUE
		if("upload_program")
			if(disk?.program)
				var/datum/nanite_cloud_backup/backup = get_backup(current_view)
				if(backup)
					playsound(src, 'sound/machines/terminal/terminal_prompt.ogg', 50, FALSE)
					var/datum/component/nanites/nanites = backup.nanites
					nanites.add_program(null, disk.program.copy())
					investigate_log("[key_name(usr)] uploaded program [disk.program.name] to cloud #[current_view]", INVESTIGATE_NANITES)
			. = TRUE
		if("remove_program")
			var/datum/nanite_cloud_backup/backup = get_backup(current_view)
			if(backup)
				playsound(src, 'sound/machines/terminal/terminal_prompt.ogg', 50, FALSE)
				var/datum/component/nanites/nanites = backup.nanites
				var/datum/nanite_program/P = nanites.programs[text2num(params["program_id"])]
				investigate_log("[key_name(usr)] deleted program [P.name] from cloud #[current_view]", INVESTIGATE_NANITES)
				qdel(P)
			. = TRUE
		if("add_rule")
			if(disk && disk.program && istype(disk.program, /datum/nanite_program/sensor))
				var/datum/nanite_program/sensor/rule_template = disk.program
				if(!rule_template.can_rule)
					return
				var/datum/nanite_cloud_backup/backup = get_backup(current_view)
				if(backup)
					playsound(src, 'sound/machines/terminal/terminal_prompt.ogg', 50, 0)
					var/datum/component/nanites/nanites = backup.nanites
					var/datum/nanite_program/P = nanites.programs[text2num(params["program_id"])]
					var/datum/nanite_rule/rule = rule_template.make_rule(P)

					investigate_log("[key_name(usr)] added rule [rule.display()] to program [P.name] in cloud #[current_view]", INVESTIGATE_NANITES)
			. = TRUE
		if("remove_rule")
			var/datum/nanite_cloud_backup/backup = get_backup(current_view)
			if(backup)
				playsound(src, 'sound/machines/terminal/terminal_prompt.ogg', 50, 0)
				var/datum/component/nanites/nanites = backup.nanites
				var/datum/nanite_program/P = nanites.programs[text2num(params["program_id"])]
				var/datum/nanite_rule/rule = P.rules[text2num(params["rule_id"])]
				rule.remove()

				investigate_log("[key_name(usr)] removed rule [rule.display()] from program [P.name] in cloud #[current_view]", INVESTIGATE_NANITES)
			. = TRUE
		if("toggle_rule_logic")
			var/datum/nanite_cloud_backup/backup = get_backup(current_view)
			if(backup)
				playsound(src, 'sound/machines/terminal/terminal_prompt.ogg', 50, FALSE)
				var/datum/component/nanites/nanites = backup.nanites
				var/datum/nanite_program/P = nanites.programs[text2num(params["program_id"])]
				P.all_rules_required = !P.all_rules_required
				investigate_log("[key_name(usr)] edited rule logic for program [P.name] into [P.all_rules_required ? "All" : "Any"] in cloud #[current_view]", INVESTIGATE_NANITES)
				. = TRUE

/datum/nanite_cloud_backup
	var/cloud_id = 0
	var/datum/component/nanites/nanites
	var/obj/machinery/computer/nanite_cloud_controller/storage
	var/datum/techweb/techweb

/datum/nanite_cloud_backup/New(obj/machinery/computer/nanite_cloud_controller/_storage)
	storage = _storage
	storage.cloud_backups += src
	SSnanites.cloud_backups += src

/datum/nanite_cloud_backup/Destroy()
	storage.cloud_backups -= src
	SSnanites.cloud_backups -= src
	return ..()
