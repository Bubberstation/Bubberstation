/obj/machinery/ammo_workbench
	name = "ammunitions workbench"
	desc = "A machine, somewhat akin to a lathe, made specifically for manufacturing ammunition. It has a slot for magazines, ammo boxes, clips... anything that holds ammo."
	icon = 'modular_zubbers/icons/obj/structures/ammo_workbench.dmi'
	icon_state = "ammobench"
	density = TRUE
	use_power = IDLE_POWER_USE
	circuit = /obj/item/circuitboard/machine/ammo_workbench
	var/busy = FALSE
	/// are we recycling right now (as opposed to printing)
	var/is_recycling = FALSE
	/// if it's hacked it's gonna be able to print lethals. it'll be mad at you for doing so but it'll print basic lethals.
	var/hacked = FALSE
	var/disabled = FALSE
	var/shocked = FALSE
	var/hack_wire
	var/disable_wire
	var/error_message = ""
	var/error_type = ""
	var/disk_error = ""
	var/disk_error_type = ""
	var/shock_wire
	var/timer_id
	var/turbo_boost = FALSE
	var/obj/item/ammo_box/loaded_magazine = null
	var/obj/item/disk/ammo_workbench/loaded_datadisk = null
	/// A list of all possible ammo types.
	var/list/possible_ammo_types = list()
	// hello future codediver. open to suggestions on how to do the following without it sucking so badly
	/// what casings we're able to use
	var/list/valid_casings = list()
	/// parallel to valid_casings: per-round UI tip-dot hex color (or null).
	var/list/casing_tip_colors = list()
	/// can it print ammunition flagged as harmful (e.g. most ammo)?
	var/allowed_harmful = FALSE
	/// can it print advanced ammunition types (e.g. armor-piercing)? see modular_skyrat\modules\modular_weapons\code\modular_projectiles.dm
	var/allowed_advanced = FALSE
	/// what datadisks have been loaded. uh... honestly this doesn't really do much either
	var/list/loaded_datadisks = list()
	/// current multiplier for material cost per round
	var/creation_efficiency = 1.4
	/// current amount of time in deciseconds it takes to assemble a round
	var/time_per_round = 1.8 SECONDS
	/// multiplier for material cost per round (when turbo isn't enabled)
	var/base_efficiency = 1.4
	// deciseconds per round (when turbo isn't enabled)
	var/base_time_per_round = 1.8 SECONDS
	/// deciseconds per round (when turbo is enabled)
	var/turbo_time_per_round = 0.225 SECONDS
	/// multiplier for material cost per round (when turbo is enabled)
	var/turbo_efficiency = 2.8
	/// percent of a round's base materials returned on recycle. set by servo tier in RefreshParts().
	var/recycle_percent = 75
	/// rounded servo tier (1-4), shown as the UI signal bars.
	var/part_tier = 1
	/// magazine-bar label while busy (FABRICATING / RECYCLING / joke).
	var/activity_label = "FABRICATING"
	/// rounds made this run; distinguishes mid-run depletion from never having enough.
	var/rounds_made_this_run = 0
	/// can this print any round of any caliber given a correct ammo_box? (you varedit this at your own risk, especially if used in a player-facing context.)
	/// does not force ammo to load in. just makes it able to print wacky ammotypes e.g. lionhunter 7.62, techshells
	var/adminbus = FALSE
	var/datum/remote_materials/materials
	/// don't touch the silo, just use local storage (for the prefilled mapping variant)
	var/force_local_materials = FALSE
	/// sanitized ID record of whoever started the current print, for silo accountability logging (accesses stripped to avoid the logger choking).
	var/alist/print_log_data

/obj/machinery/ammo_workbench/unlocked
	allowed_harmful = TRUE
	allowed_advanced = TRUE

// mapping variant - comes with decent parts and some materials so you can just plop it down on a ruin/away mission without also placing sheets and a disk
/obj/machinery/ammo_workbench/prefilled
	circuit = /obj/item/circuitboard/machine/ammo_workbench/prefilled
	force_local_materials = TRUE

/obj/machinery/ammo_workbench/prefilled/Initialize(mapload)
	. = ..()
	// Give it a reasonable stock of materials used for bullets
	if(materials?.mat_container)
		materials.mat_container.insert_amount_mat(50 * SHEET_MATERIAL_AMOUNT, /datum/material/iron)
		materials.mat_container.insert_amount_mat(20 * SHEET_MATERIAL_AMOUNT, /datum/material/glass)
		materials.mat_container.insert_amount_mat(20 * SHEET_MATERIAL_AMOUNT, /datum/material/titanium)
		materials.mat_container.insert_amount_mat(15 * SHEET_MATERIAL_AMOUNT, /datum/material/plasma)
		materials.mat_container.insert_amount_mat(15 * SHEET_MATERIAL_AMOUNT, /datum/material/silver)
		materials.mat_container.insert_amount_mat(15 * SHEET_MATERIAL_AMOUNT, /datum/material/gold)

/obj/item/circuitboard/machine/ammo_workbench
	name = "Ammunition Workbench (Machine Board)"
	icon_state = "circuit_map"
	build_path = /obj/machinery/ammo_workbench
	req_components = list(
		/datum/stock_part/servo = 2,
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/micro_laser = 2
	)

/obj/item/circuitboard/machine/ammo_workbench/prefilled
	build_path = /obj/machinery/ammo_workbench/prefilled
	req_components = list(
		/datum/stock_part/servo/tier3 = 2,
		/datum/stock_part/matter_bin/tier3 = 2,
		/datum/stock_part/micro_laser/tier3 = 2
	)

/obj/machinery/ammo_workbench/Initialize(mapload)
	. = ..()
	materials = new(
		src,
		force_local_materials ? FALSE : mapload,
	)
	materials.set_local_size(200000)
	set_wires(new /datum/wires/ammo_workbench(src))

/obj/machinery/ammo_workbench/proc/local_material_insert(obj/machinery/machine, container, obj/item/item_inserted, last_inserted_id, list/mats_consumed, amount_inserted)
	SIGNAL_HANDLER
	SStgui.update_uis(src)

/obj/machinery/ammo_workbench/proc/silo_material_insert(obj/machinery/machine, container, obj/item/item_inserted, last_inserted_id, list/mats_consumed, amount_inserted)
	SIGNAL_HANDLER
	SStgui.update_uis(src)

/obj/machinery/ammo_workbench/examine(mob/user)
	. += ..()
	if(in_range(user, src) || isobserver(user))
		if(materials?.mat_container)
			. += span_notice("The status display reads: Storing up to <b>[materials.mat_container.max_amount]</b> material units.<br>Material consumption at <b>[creation_efficiency*100]%</b>.")
		. += span_notice("Reclaiming <b>[recycle_percent]%</b> of materials when recycling a loaded container.")

/obj/machinery/ammo_workbench/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AmmoWorkbench")
		ui.open()

	if(shocked)
		workbench_shock(user, 80)

/obj/machinery/ammo_workbench/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet_batched/sheetmaterials),
	)

/obj/machinery/ammo_workbench/proc/update_ammotypes()
	LAZYCLEARLIST(valid_casings)
	LAZYCLEARLIST(casing_tip_colors)
	if(!loaded_magazine)
		return
	var/obj/item/ammo_casing/ammo_type = loaded_magazine.ammo_type
	var/ammo_caliber = initial(ammo_type.caliber)
	var/obj/item/ammo_casing/ammo_parent_type = type2parent(ammo_type)

	if(loaded_magazine.multitype)
		if(ammo_caliber == initial(ammo_parent_type.caliber) && ammo_caliber != null)
			ammo_type = ammo_parent_type
		possible_ammo_types = typesof(ammo_type)
	else
		possible_ammo_types = list(ammo_type) // literally just for the niche edgecase of shotgun slug boxes

	for(var/obj/item/ammo_casing/our_casing as anything in possible_ammo_types) // this is a list of TYPES, not INSTANCES
		if(!adminbus)
			if(!(initial(our_casing.can_be_printed))) // if we're not supposed to be printed (looking at you, smartgun rails)
				continue // go home
			if(initial(our_casing.harmful) && (!allowed_harmful && !hacked)) // if you hack it that's on you.
				continue
			if(initial(our_casing.advanced_print_req) && !allowed_advanced) // if it's got a funny function (hello, AP!) and we're not good for it yet,
				continue // no
		if(initial(our_casing.projectile_type) == null) // spent casing subtypes >:(
			continue
		valid_casings += our_casing // adding the valid typepath
		valid_casings[our_casing] = initial(our_casing.name)
		casing_tip_colors += initial(our_casing.workbench_tip_color)
		// we pray to god these indexes stay consistent.

// builds the "0.24 iron (1.68 to fill)" cost string for a casing type. computed live (not cached) since it
// depends on current efficiency and how full the container is.
/obj/machinery/ammo_workbench/proc/get_cost_string(casing_type)
	if(!loaded_magazine)
		return ""
	// i'm very sorry for this, but literally every other thing i tried to get the material composition didn't copy at all
	var/obj/item/ammo_casing/casing_actual = new casing_type
	var/list/raw_casing_mats = casing_actual.get_material_composition()
	qdel(casing_actual)
	if(!length(raw_casing_mats))
		return ""

	// max_ammo can read 0 on a just-inserted empty container before its contents initialize; fall back to the type's spawn capacity.
	var/true_capacity = loaded_magazine.max_ammo || initial(loaded_magazine.max_ammo)
	var/rounds_to_fill = max(true_capacity - length(loaded_magazine.stored_ammo), 0)

	var/list/parts = list()
	for(var/datum/material/our_material as anything in raw_casing_mats)
		var/per_round = round(raw_casing_mats[our_material] * creation_efficiency / SHEET_MATERIAL_AMOUNT, 0.01)
		var/to_fill = round(per_round * rounds_to_fill, 0.01)
		parts += "[per_round] [our_material.name] ([to_fill] to fill)"
	return jointext(parts, ", ")

/obj/machinery/ammo_workbench/ui_data(mob/user)
	// i kinda hate how all of this is done on every tgui process tick
	var/list/data = list()

	data["loaded_datadisks"] = list()
	data["datadisk_loaded"] = FALSE
	data["datadisk_name"] = null
	data["datadisk_desc"] = null

	data["disk_error"] = disk_error
	data["disk_error_type"] = disk_error_type

	if(loaded_datadisk)
		data["datadisk_loaded"] = TRUE
		data["datadisk_name"] = initial(loaded_datadisk.name)
		data["datadisk_desc"] = initial(loaded_datadisk.desc)

	for(var/type in loaded_datadisks)
		var/obj/item/disk/ammo_workbench/disk = type
		data["loaded_datadisks"] += list(list("loaded_disk_name" = initial(disk.name), "loaded_disk_desc" = initial(disk.desc)))

	data["mag_loaded"] = FALSE
	data["error"] = null
	data["error_type"] = null
	data["system_busy"] = busy

	data["efficiency"] = creation_efficiency
	data["silo_connected"] = materials && materials.silo ? TRUE : FALSE
	data["time"] = time_per_round / 10
	data["recyclePercent"] = round(effective_recycle_percent())
	// turbo drops the signal bar by one (efficiency traded for speed).
	data["partTier"] = turbo_boost ? max(part_tier - 1, 0) : part_tier
	data["bar_state"] = activity_label
	data["recycle_preview"] = get_recycle_preview()
	data["hacked"] = hacked
	data["turboBoost"] = turbo_boost

	data["materials"] = materials?.mat_container ? materials.mat_container.ui_data() : list()
	data["SHEET_MATERIAL_AMOUNT"] = SHEET_MATERIAL_AMOUNT
	data["materialMaximum"] = materials?.mat_container ? materials.mat_container.max_amount : 0

	if(error_message)
		data["error"] = error_message
		data["error_type"] = error_type

	data["mag_loaded"] = loaded_magazine ? TRUE : FALSE
	data["mag_name"] = loaded_magazine ? loaded_magazine.name : null
	data["current_rounds"] = loaded_magazine ? length(loaded_magazine.stored_ammo) : 0
	data["max_rounds"] = loaded_magazine ? loaded_magazine.max_ammo : 0

	data["available_rounds"] = list()
	if(loaded_magazine)
		for(var/casings_to_relay = 1 to length(valid_casings))
			var/typepath = valid_casings[casings_to_relay]
			data["available_rounds"] += list(list(
				"name" = valid_casings[typepath],
				"typepath" = typepath,
				"mats_list" = get_cost_string(typepath),
				"tip_color" = casing_tip_colors[casings_to_relay]
			))

	return data

/obj/machinery/ammo_workbench/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("EjectMag")
			ejectItem()
			. = TRUE

		if("RecycleMag")
			print_log_data = sanitize_id_data(ID_DATA(usr))
			recycle_magazine()
			. = TRUE

		if("CancelFabrication")
			if(busy)
				if(is_recycling)
					error_message = "RECYCLING CANCELLED"
					error_type = ""
					recycle_finish(successfully = FALSE)
				else
					error_message = "FABRICATION CANCELLED"
					error_type = ""
					ammo_fill_finish(FALSE)
			. = TRUE

		if("FillMagazine")
			var/type_to_pass = text2path(params["selected_type"])
			print_log_data = sanitize_id_data(ID_DATA(usr))
			fill_magazine_start(type_to_pass)
			. = TRUE

		if("remove_mat") // MaterialAccessBar eject: { ref, amount(sheets) }
			if(!materials?.mat_container)
				return
			var/datum/material/mat = locate(params["ref"])
			if(!mat)
				return
			var/units_available = materials.mat_container.materials[mat]
			if(!units_available)
				return
			var/sheets_available = CEILING(units_available / SHEET_MATERIAL_AMOUNT, 0.1)
			var/desired = text2num(params["amount"]) || 0
			var/sheets_to_remove = round(min(desired, 50, sheets_available))
			if(sheets_to_remove <= 0)
				return
			materials.eject_sheets(mat, sheets_to_remove, drop_location(), sanitize_id_data(ID_DATA(usr)))
			. = TRUE

		if("ReadDisk")
			loadDisk()

		if("EjectDisk")
			ejectDisk()

		if("turboBoost")
			toggle_turbo_boost()

/obj/machinery/ammo_workbench/proc/toggle_turbo_boost(forced_off = FALSE)
	if(forced_off)
		turbo_boost = FALSE
	else
		turbo_boost = !turbo_boost
	apply_speed_state()
	update_ammotypes()
	SStgui.update_uis(src)

// keeps time/efficiency in sync with the turbo toggle so they can't drift apart
/obj/machinery/ammo_workbench/proc/apply_speed_state()
	if(turbo_boost)
		time_per_round = turbo_time_per_round
		creation_efficiency = turbo_efficiency
	else
		time_per_round = base_time_per_round
		creation_efficiency = base_efficiency

/obj/machinery/ammo_workbench/proc/ejectItem(mob/living/user)
	if(loaded_magazine)
		loaded_magazine.forceMove(drop_location())

		if(user)
			try_put_in_hand(loaded_magazine, user)

		loaded_magazine = null
	busy = FALSE
	error_message = ""
	error_type = ""
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	update_ammotypes()
	update_appearance()

// dumps the loaded container back into materials, giving back a chunk of each round's base mats based on servo tier

// turbo recycling is faster but you get less back
/obj/machinery/ammo_workbench/proc/effective_recycle_percent()
	return turbo_boost ? recycle_percent * 0.6 : recycle_percent

/obj/machinery/ammo_workbench/proc/get_recycle_preview()
	if(!loaded_magazine || !length(loaded_magazine.stored_ammo))
		return null
	var/list/reclaimed = list()
	var/list/comp_cache = list()
	for(var/atom/entry as anything in loaded_magazine.stored_ammo)
		var/casing_type = ispath(entry) ? entry : entry.type
		if(!ispath(casing_type, /obj/item/ammo_casing))
			continue
		var/list/base_mats = comp_cache[casing_type]
		if(isnull(base_mats))
			var/obj/item/ammo_casing/base_casing = new casing_type
			base_mats = base_casing.get_material_composition()
			qdel(base_casing)
			comp_cache[casing_type] = base_mats || list()
		for(var/datum/material/mat as anything in base_mats)
			reclaimed[mat] += base_mats[mat] * (effective_recycle_percent() / 100)
	if(!length(reclaimed))
		return null
	var/list/parts = list()
	for(var/datum/material/mat as anything in reclaimed)
		var/sheets = round(reclaimed[mat] / SHEET_MATERIAL_AMOUNT, 0.01)
		if(sheets > 0)
			parts += "[sheets] [mat.name]"
	return length(parts) ? jointext(parts, ", ") : null

/obj/machinery/ammo_workbench/proc/recycle_magazine(mob/living/user)
	if(machine_stat & (NOPOWER|BROKEN))
		return
	if(busy)
		error_message = "SYSTEM IS BUSY"
		error_type = ""
		return
	if(!loaded_magazine)
		error_message = "NO CONTAINER INSERTED"
		error_type = ""
		return
	if(!length(loaded_magazine.stored_ammo))
		error_message = "CONTAINER IS EMPTY"
		error_type = "bad"
		return

	// per-round loop: faster than printing, drains visibly.
	busy = TRUE
	is_recycling = TRUE
	activity_label = pick_recycle_status()
	error_message = "" // ongoing state shows on the magazine bar, not here
	error_type = ""
	SStgui.update_uis(src) // disable the controls immediately
	recycle_round()

/obj/machinery/ammo_workbench/proc/pick_recycle_status()
	var/static/list/recycle_jokes = list(
		"UNFABRICATING",
		"PRINTN'T",
		"UN-PRINTING",
	)
	if(prob(10))
		return pick(recycle_jokes)
	return "RECYCLING"

// one round at a time until the thing's empty
/obj/machinery/ammo_workbench/proc/recycle_round()
	if(machine_stat & (NOPOWER|BROKEN) || !loaded_magazine)
		recycle_finish()
		return

	// stored_ammo is a lazy mixed list (typepaths until instantiated)
	var/atom/target_round
	for(var/atom/entry as anything in loaded_magazine.stored_ammo)
		var/entry_type = ispath(entry) ? entry : entry.type
		if(ispath(entry_type, /obj/item/ammo_casing))
			target_round = entry
			break

	if(isnull(target_round)) // nothing left to process
		recycle_finish(successfully = TRUE)
		return

	var/casing_type = ispath(target_round) ? target_round : target_round.type
	// read base composition from a throwaway casing of this type (initial() won't copy material lists)
	var/obj/item/ammo_casing/base_casing = new casing_type
	var/list/base_mats = base_casing.get_material_composition()
	qdel(base_casing)

	// only reclaim if the whole round's worth fits; otherwise stop here with what we've already banked
	var/round_total = 0
	for(var/material in base_mats)
		round_total += base_mats[material] * (effective_recycle_percent() / 100)
	if(!materials?.mat_container)
		error_message = "NO MATERIAL STORAGE LINKED"
		error_type = "bad"
		recycle_finish(successfully = FALSE)
		return
	if(round_total && !materials.mat_container.has_space(round_total))
		error_message = "MATERIAL STORAGE FULL"
		error_type = "bad"
		recycle_finish(successfully = FALSE)
		return

	var/list/reclaimed_mats = list()
	for(var/material in base_mats)
		var/amount = base_mats[material] * (effective_recycle_percent() / 100)
		materials.mat_container.insert_amount_mat(amount, material)
		reclaimed_mats[material] = amount
	log_silo_use(reclaimed_mats, "recycled", "munitions")

	// remove this one round (qdel for instances triggers Exited material bookkeeping; path entries just drop)
	loaded_magazine.stored_ammo -= target_round
	if(!ispath(target_round))
		var/obj/item/ammo_casing/spent = target_round
		spent.set_custom_materials(null) // clear before qdel or the mag's Exited subtraction hits zero and runtimes
		qdel(target_round)
	loaded_magazine.update_appearance()

	flick("ammobench_process", src)
	use_energy(3000 JOULES)
	// the print sound, but backwards: one reverse zerp per round, the inverse of fill_round()'s per-round piston.
	playsound(loc, 'sound/machines/piston/piston_raise.ogg', 60, TRUE, frequency = -1)
	SStgui.update_uis(src)

	var/recycle_delay = max(time_per_round * 0.5, 1)
	timer_id = addtimer(CALLBACK(src, PROC_REF(recycle_round)), recycle_delay, TIMER_STOPPABLE)

/obj/machinery/ammo_workbench/proc/recycle_finish(successfully = TRUE)
	if(timer_id)
		deltimer(timer_id) // kill any pending next-round callback, else cancel does nothing
		timer_id = null
	busy = FALSE
	is_recycling = FALSE
	if(successfully && loaded_magazine)
		// zero out the mag's own material value so it reads as empty even if a stray entry lingered
		loaded_magazine.set_custom_materials(list())
		loaded_magazine.update_appearance()
		error_message = "MUNITIONS RECYCLED"
		error_type = "good"
		playsound(loc, 'sound/machines/ping.ogg', 40, TRUE)
	SStgui.update_uis(src)

/obj/machinery/ammo_workbench/proc/fill_magazine_start(casing_type)
	if(machine_stat & (NOPOWER|BROKEN))
		busy = FALSE
		if(timer_id)
			deltimer(timer_id)
			timer_id = null
		return

	if(error_message)
		error_message = ""
		error_type = ""

	if(!(casing_type in possible_ammo_types))
		error_message = "AMMUNITION MISMATCH"
		error_type = "bad"
		return

	var/obj/item/ammo_casing/our_casing = casing_type

	if(initial(our_casing.harmful) && !allowed_harmful)
		error_message = "SYSTEM CORRUPTION DETECTED, PLEASE EJECT CONTAINER AND SUBMIT SUPPORT TICKET"
		error_type = "bad"
		if(!hacked)
			return

	if(!loaded_magazine)
		error_message = "NO CONTAINER INSERTED"
		error_type = ""
		return

	if(loaded_magazine.stored_ammo.len >= loaded_magazine.max_ammo)
		error_message = "CONTAINER IS FULL"
		error_type = "good"
		return

	if(busy)
		return

	busy = TRUE
	is_recycling = FALSE
	activity_label = "FABRICATING"
	rounds_made_this_run = 0
	SStgui.update_uis(src) // disable the controls immediately, before the first round fires

	timer_id = addtimer(CALLBACK(src, PROC_REF(fill_round), casing_type), time_per_round, TIMER_STOPPABLE)

/obj/machinery/ammo_workbench/proc/fill_round(casing_type)
	if(machine_stat & (NOPOWER|BROKEN))
		busy = FALSE
		if(timer_id)
			deltimer(timer_id)
			timer_id = null
		return

	if(!loaded_magazine)
		return

	var/obj/item/ammo_casing/new_casing = new casing_type

	var/list/required_materials = new_casing.get_material_composition()
	var/list/efficient_materials = list()

	for(var/material in required_materials)
		var/amount = required_materials[material] * creation_efficiency
		if(amount > 0)
			efficient_materials[material] = amount

	if(!materials?.mat_container)
		error_message = "NO MATERIAL STORAGE LINKED"
		error_type = "bad"
		ammo_fill_finish(FALSE)
		qdel(new_casing)
		return

	if(!materials.mat_container.has_materials(efficient_materials))
		// ran dry partway through a run = DEPLETED; failed on the very first round = never had enough.
		error_message = rounds_made_this_run ? "MATERIALS DEPLETED" : "INSUFFICIENT MATERIALS"
		error_type = "bad"
		ammo_fill_finish(FALSE)
		qdel(new_casing)
		return

	if(new_casing.type in possible_ammo_types)
		// respect a remote silo hold before doing anything irreversible
		if(materials.silo && materials.on_hold())
			error_message = "MATERIAL ACCESS ON HOLD"
			error_type = "bad"
			ammo_fill_finish(FALSE)
			qdel(new_casing)
			return
		if(!loaded_magazine.give_round(new_casing))
			error_message = "AMMUNITION MISMATCH"
			error_type = "bad"
			ammo_fill_finish(FALSE)
			qdel(new_casing)
			return
		materials.mat_container.use_materials(efficient_materials)
		log_silo_use(efficient_materials, "printed", initial(new_casing.name))
		new_casing.set_custom_materials(efficient_materials)
		rounds_made_this_run++
		loaded_magazine.update_appearance()
		flick("ammobench_process", src)
		use_energy(3000 JOULES)
		playsound(loc, 'sound/machines/piston/piston_raise.ogg', 60, 1)
	else
		qdel(new_casing)
		ammo_fill_finish(FALSE)
		return

	if(loaded_magazine.stored_ammo.len >= loaded_magazine.max_ammo)
		ammo_fill_finish()
		error_message = "CONTAINER IS FULL"
		error_type = "good"
		return

	SStgui.update_uis(src)

	timer_id = addtimer(CALLBACK(src, PROC_REF(fill_round), casing_type), time_per_round, TIMER_STOPPABLE)

/obj/machinery/ammo_workbench/proc/ammo_fill_finish(successfully = TRUE)
	SStgui.update_uis(src)
	if(successfully)
		playsound(loc, 'sound/machines/ping.ogg', 40, TRUE)
	else
		playsound(loc, 'sound/machines/buzz/buzz-sigh.ogg', 40, TRUE)
	update_appearance()
	busy = FALSE
	is_recycling = FALSE
	if(timer_id)
		deltimer(timer_id)
		timer_id = null

/obj/machinery/ammo_workbench/proc/loadDisk()
	disk_error = ""
	disk_error_type = ""
	if(!loaded_datadisk)
		return FALSE
	if(loaded_datadisk.type in loaded_datadisks)
		disk_error = "ERROR: DISK DATA ALREADY IN SYSTEM MEMORY"
		return FALSE

	disk_error = "DISK LOADED SUCCESSFULLY"
	disk_error_type = "good"
	loaded_datadisk.on_bench_install(src)
	loaded_datadisks += loaded_datadisk.type // upon further reflection this. doesn't cause a hard del. still not a fan since the disks don't do anything by themselves
	update_ammotypes() // a disk can unlock new printable types; refresh the list now instead of waiting for a mag reinsert
	return TRUE

/obj/machinery/ammo_workbench/proc/ejectDisk()
	if(loaded_datadisk)
		loaded_datadisk.forceMove(drop_location())
		loaded_datadisk = null
		disk_error = ""
		disk_error_type = ""
		update_ammotypes() // ejecting can revoke access; keep the printable list in sync

/datum/design/board/ammo_workbench
	name = "Machine Design (Ammunitions Workbench)"
	desc = "A machine, somewhat akin to a lathe, made specifically for manufacturing ammunition. It has a slot for ammunition containers, like magazines or stripper clips."
	id = "ammo_workbench"
	build_path = /obj/item/circuitboard/machine/ammo_workbench
	category = list(RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_FAB)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY


//MISC MACHINE PROCS

/obj/machinery/ammo_workbench/RefreshParts()
	. = ..()
	var/time_efficiency = 1.8 SECONDS
	for(var/datum/stock_part/micro_laser/new_laser in component_parts)
		time_efficiency -= new_laser.tier * 2 // there's two lasers
		// time_eff prog with paired lasers is 1.4 -> 1.0 -> 0.6 -> 0.2 seconds per round
	base_time_per_round = clamp(time_efficiency, 1, 20)
	turbo_time_per_round = max(time_efficiency / 8, 1)

	var/efficiency = 1.4
	var/total_servo_tier = 0
	var/servo_count = 0
	for(var/datum/stock_part/servo/new_servo in component_parts)
		efficiency -= new_servo.tier * 0.1 // there's two servos
		total_servo_tier += new_servo.tier
		servo_count++
	// material-cost multiplier from servos: 1.2 -> 1 -> 0.8 -> 0.6
	base_efficiency = max(efficiency, 0.1)
	turbo_efficiency = base_efficiency * 2

	// reclaim scales with servo tier, mirroring /obj/machinery/recycler. averaged across the bench's pair of servos.
	// progression with paired servos: t1 62.5% -> t2 75% -> t3 87.5% -> t4 100%
	var/avg_servo_tier = servo_count ? (total_servo_tier / servo_count) : 1
	recycle_percent = min(50, 12.5 * avg_servo_tier) + 50
	part_tier = round(avg_servo_tier) // drives the signal-strength bars in the UI (1-4)

	// re-apply the active turbo state now that base_* are recomputed, so the live numbers reflect upgrades immediately.
	apply_speed_state()

	var/mat_capacity = 0
	for(var/datum/stock_part/matter_bin/new_matter_bin in component_parts)
		mat_capacity += new_matter_bin.tier * (40 * SHEET_MATERIAL_AMOUNT)

	materials?.set_local_size(mat_capacity)
	update_ammotypes()

/obj/machinery/ammo_workbench/update_overlays()
	. = ..()
	if(loaded_magazine)
		. += "ammobench_loaded"

/obj/machinery/ammo_workbench/update_icon_state()
	. = ..()
	if(panel_open)
		icon_state = "[initial(icon_state)]_t"
		return
	icon_state = initial(icon_state)

/obj/machinery/ammo_workbench/Destroy()
	QDEL_NULL(materials)
	QDEL_NULL(wires)
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	if(loaded_magazine)
		loaded_magazine.forceMove(loc)
		loaded_magazine = null

	return ..()

/obj/machinery/ammo_workbench/proc/workbench_shock(mob/user, prb)
	if(machine_stat & (BROKEN|NOPOWER)) // unpowered, no shock
		return FALSE
	if(!prob(prb))
		return FALSE
	do_sparks(5, TRUE, src)
	if (electrocute_mob(user, get_area(src), src, 0.7, TRUE))
		return TRUE
	else
		return FALSE

/obj/machinery/ammo_workbench/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/ammo_workbench/attackby(obj/item/O, mob/user, params)
	if(default_deconstruction_crowbar(user, O))
		return
	if(panel_open && is_wire_tool(O))
		wires.interact(user)
		return TRUE
	if(is_refillable() && O.is_drainable())
		return FALSE //inserting reagents into the machine
	if(Insert_Item(O, user))
		return TRUE
	else
		return ..()

/obj/machinery/ammo_workbench/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()

	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(!can_interact(user) || !user.can_perform_action(src, ALLOW_SILICON_REACH | FORBID_TELEKINESIS_REACH))
		return

	ejectItem(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/ammo_workbench/attack_robot_secondary(mob/user, list/modifiers)
	return attack_hand_secondary(user, modifiers)

/obj/machinery/ammo_workbench/attack_ai_secondary(mob/user, list/modifiers)
	return attack_hand_secondary(user, modifiers)

/obj/machinery/ammo_workbench/proc/Insert_Item(obj/item/O, mob/living/user)
	if(user.combat_mode)
		return FALSE
	if(!is_insertion_ready(user, O))
		return FALSE
	if(istype(O, /obj/item/ammo_box))
		if(!user.transferItemToLoc(O, src))
			return FALSE
		if(loaded_magazine)
			to_chat(user, span_notice("You quickly swap [loaded_magazine] for [O]."))
			loaded_magazine.forceMove(drop_location())
			user.put_in_hands(loaded_magazine)
			loaded_magazine = null
			busy = FALSE
			error_message = ""
			error_type = ""
			if(timer_id)
				deltimer(timer_id)
				timer_id = null
		loaded_magazine = O
		to_chat(user, span_notice("You insert [O] to into [src]'s reciprocal."))
		flick("h_lathe_load", src)
		update_appearance()
		update_ammotypes()
		playsound(loc, 'sound/items/weapons/autoguninsert.ogg', 35, 1)
		return TRUE
	if(istype(O, /obj/item/disk/ammo_workbench))
		if(!user.transferItemToLoc(O, src))
			return FALSE
		loaded_datadisk = O
		to_chat(user, span_notice("You insert [O] to into [src]'s floppydisk port."))
		flick("h_lathe_load", src)
		update_appearance()
		playsound(loc, 'sound/machines/terminal/terminal_insert_disc.ogg', 35, 1)
		return TRUE
	return FALSE

/obj/machinery/ammo_workbench/proc/is_insertion_ready(mob/user, obj/item/O)
	if(panel_open)
		to_chat(user, span_warning("You can't load [src] while it's opened!"))
		return FALSE
	if(disabled)
		to_chat(user, span_warning("The insertion belts of [src] won't engage!"))
		return FALSE
	if(machine_stat & BROKEN)
		to_chat(user, span_warning("[src] is broken."))
		return FALSE
	if(machine_stat & NOPOWER)
		to_chat(user, span_warning("[src] has no power."))
		return FALSE
	if(istype(O, /obj/item/disk/ammo_workbench) && loaded_datadisk)
		to_chat(user, span_warning("[src] already has a disk inserted."))
		return FALSE
	return TRUE

/obj/machinery/ammo_workbench/proc/reset(wire)
	switch(wire)
		if(WIRE_HACK)
			if(!wires.is_cut(wire))
				adjust_hacked(FALSE)
		if(WIRE_SHOCK)
			if(!wires.is_cut(wire))
				shocked = FALSE
		if(WIRE_DISABLE)
			if(!wires.is_cut(wire))
				disabled = FALSE

/obj/machinery/ammo_workbench/proc/adjust_hacked(state)
	hacked = state

// silo's recursive_jsonify chokes on the flat access list in ID_DATA; strip it and keep the name/account
/obj/machinery/ammo_workbench/proc/sanitize_id_data(alist/user_data)
	if(!islist(user_data))
		return user_data
	var/alist/clean = user_data.Copy()
	clean["accesses"] = null
	return clean

// logs to the silo for accountability without gating on ID. no-op if not silo-linked.
/obj/machinery/ammo_workbench/proc/log_silo_use(list/mats, action, name)
	if(!materials?.silo)
		return
	materials.silo.silo_log(src, action, -1, name, mats, print_log_data)

/obj/machinery/ammo_workbench/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		balloon_alert(user, "already overridden!")
		return FALSE
	obj_flags |= EMAGGED
	hacked = TRUE
	allowed_harmful = TRUE
	allowed_advanced = TRUE
	update_ammotypes()
	balloon_alert(user, "safety protocols overridden")
	if(user)
		to_chat(user, span_warning("You short out [src]'s munition safety protocols, unlocking its full catalogue."))
	playsound(src, 'sound/effects/sparks/sparks4.ogg', 60, TRUE)
	SStgui.update_uis(src)
	return TRUE


// WIRE DATUM
/datum/wires/ammo_workbench
	holder_type = /obj/machinery/ammo_workbench
	proper_name = "Ammunition Workbench"

/datum/wires/ammo_workbench/New(atom/holder)
	wires = list(
		WIRE_HACK, WIRE_DISABLE,
		WIRE_SHOCK, WIRE_ZAP
	)
	add_duds(6)
	..()

/datum/wires/ammo_workbench/interactable(mob/user)
	if(!..())
		return FALSE
	var/obj/machinery/ammo_workbench/A = holder
	if(A.panel_open)
		return TRUE

/datum/wires/ammo_workbench/get_status()
	var/obj/machinery/ammo_workbench/A = holder
	var/list/status = list()
	status += "The red light is [A.disabled ? "on" : "off"]."
	status += "The blue light is [A.hacked ? "on" : "off"]."
	return status

/datum/wires/ammo_workbench/on_pulse(wire)
	var/obj/machinery/ammo_workbench/A = holder
	switch(wire)
		if(WIRE_HACK)
			A.adjust_hacked(!A.hacked)
			addtimer(CALLBACK(A, TYPE_PROC_REF(/obj/machinery/ammo_workbench, reset), wire), 6 SECONDS)
		if(WIRE_SHOCK)
			A.shocked = !A.shocked
			addtimer(CALLBACK(A, TYPE_PROC_REF(/obj/machinery/ammo_workbench, reset), wire), 6 SECONDS)
		if(WIRE_DISABLE)
			A.disabled = !A.disabled
			addtimer(CALLBACK(A, TYPE_PROC_REF(/obj/machinery/ammo_workbench, reset), wire), 6 SECONDS)

/datum/wires/ammo_workbench/on_cut(wire, mend, source)
	var/obj/machinery/ammo_workbench/A = holder
	switch(wire)
		if(WIRE_HACK)
			A.adjust_hacked(!mend)
		if(WIRE_SHOCK)
			A.shocked = !mend
		if(WIRE_DISABLE)
			A.disabled = !mend
		if(WIRE_ZAP)
			A.workbench_shock(usr, 50)
