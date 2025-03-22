/obj/machinery/nanite_program_hub
	name = "nanite program hub"
	desc = "Compiles nanite programs from the techweb servers and downloads them into disks."
	icon = 'modular_zubbers/icons/obj/machines/nanite_machines.dmi'
	icon_state = "nanite_program_hub"
	use_power = IDLE_POWER_USE
	anchored = TRUE
	density = TRUE
	circuit = /obj/item/circuitboard/machine/nanite_program_hub

	var/obj/item/disk/nanite_program/disk
	var/datum/techweb/linked_techweb
	var/current_category = "Main"
	var/detail_view = TRUE
	var/categories = list(
		list(name = "Utility Nanites"),
		list(name = "Medical Nanites"),
		list(name = "Sensor Nanites"),
		list(name = "Augmentation Nanites"),
		list(name = "Suppression Nanites"),
		list(name = "Weaponized Nanites"),
		list(name = "Protocols"),
	)

/obj/machinery/nanite_program_hub/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	if(!CONFIG_GET(flag/no_default_techweb_link) && !linked_techweb)
		CONNECT_TO_RND_SERVER_ROUNDSTART(linked_techweb, src)
	register_context()

/obj/machinery/nanite_program_hub/examine(mob/user)
	. = ..()
	. += span_notice("Use with a linked multitool to link to a techweb server.")

/obj/machinery/nanite_program_hub/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		return
	if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
		context[SCREENTIP_CONTEXT_LMB] = "Open Panel"
		return CONTEXTUAL_SCREENTIP_SET
	if(held_item.tool_behaviour == TOOL_MULTITOOL)
		context[SCREENTIP_CONTEXT_LMB] = "Upload Techweb"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/nanite_program_hub/update_overlays()
	. = ..()
	if((machine_stat & (NOPOWER|MAINT|BROKEN)) || panel_open)
		return
	. += "nanite_program_hub_on"
	. += emissive_appearance(icon, "nanite_program_hub_on", src, alpha = src.alpha)

/obj/machinery/nanite_program_hub/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
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

/obj/machinery/nanite_program_hub/multitool_act(mob/living/user, obj/item/multitool/tool)
	if(!QDELETED(tool.buffer) && istype(tool.buffer, /datum/techweb))
		linked_techweb = tool.buffer
		balloon_alert(user, "linked!")
		update_static_data_for_all_viewers()
	return TRUE

/obj/machinery/nanite_program_hub/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE

	return default_deconstruction_screwdriver(user, "nanite_program_hub_t", "nanite_program_hub", I)

/obj/machinery/nanite_program_hub/crowbar_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE

	return default_deconstruction_crowbar(I)

/obj/machinery/nanite_program_hub/proc/eject(mob/living/user)
	if(!disk)
		return
	if(!istype(user) || !Adjacent(user) || !user.put_in_active_hand(disk))
		disk.forceMove(drop_location())
	disk = null

/obj/machinery/nanite_program_hub/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(disk && user.can_perform_action(src, !issilicon(user)))
		to_chat(user, span_notice("You take out [disk] from [src]."))
		eject(user)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/nanite_program_hub/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NaniteProgramHub", name)
		ui.open()

/obj/machinery/nanite_program_hub/ui_data()
	var/list/data = list()
	if(disk)
		data["has_disk"] = TRUE
		var/list/disk_data = list()
		var/datum/nanite_program/P = disk.program
		if(P)
			data["has_program"] = TRUE
			disk_data["name"] = P.name
			disk_data["desc"] = P.desc
		data["disk"] = disk_data
	else
		data["has_disk"] = FALSE

	data["detail_view"] = detail_view

	return data

/obj/machinery/nanite_program_hub/ui_static_data(mob/user)
	var/list/data = list()
	if(linked_techweb)
		data["techweb"] = list(
			"name" = linked_techweb.id,
			"organization" = linked_techweb.organization,
		)
	data["programs"] = list()
	for(var/i in linked_techweb.researched_designs)
		var/datum/design/nanites/D = SSresearch.techweb_design_by_id(i)
		if(!istype(D))
			continue
		var/cat_name = D.category[1] //just put them in the first category fuck it
		if(isnull(data["programs"][cat_name]))
			data["programs"][cat_name] = list()
		var/list/program_design = list()
		program_design["id"] = D.id
		program_design["name"] = D.name
		program_design["desc"] = D.desc
		data["programs"][cat_name] += list(program_design)

	if(!length(data["programs"]))
		data["programs"] = null

	return data

/obj/machinery/nanite_program_hub/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("eject")
			eject(usr)
			. = TRUE
		if("download")
			if(!disk)
				return
			var/datum/design/nanites/downloaded = linked_techweb.isDesignResearchedID(params["program_id"]) //check if it's a valid design
			if(!istype(downloaded))
				return
			if(disk.program)
				qdel(disk.program)
			disk.program = new downloaded.program_type
			disk.update_name()
			playsound(src, 'sound/machines/terminal/terminal_prompt.ogg', 25, FALSE)
			. = TRUE
		if("refresh")
			update_static_data(usr)
			. = TRUE
		if("toggle_details")
			detail_view = !detail_view
			. = TRUE
		if("clear")
			if(disk?.program)
				qdel(disk.program)
				disk.program = null
				disk.name = initial(disk.name)
			. = TRUE
